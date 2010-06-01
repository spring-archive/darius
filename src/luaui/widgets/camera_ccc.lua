--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Complete Control Camera",
    desc      = "v0.11 Camera featuring 5 actions. Type \255\90\90\255/luaui ccc help\255\255\255\255 for help.",
    author    = "CarRepairer (smoothscroll code by trepan)",
    date      = "2009-12-15",
    license   = "GNU GPL, v2 or later",
    layer     = 1002,
	handler   = true,
    enabled   = false,
  }
end

include("keysym.h.lua")

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

options_section = 'View'
options = {
	order = { 'helpwindow', 'targetmouse', 'edgemove', 'oldscroll', 'invertzoom', 'zoomoutfromcursor', 'speedFactor', 'speedFactor_k', 'zoominfactor', 'zoomoutfactor', 'follow', },
	lblblank1 = {name='', type='label'},
	helpwindow = {
		name = 'CC Cam Help',
		type = 'text',
		value = [[
			Complete Control Camera has five main actions...
			
			Zoom..... <Mousewheel>
			Altitude..... <Ctrl> + <Mousewheel>
			Smooth Scroll..... <Middlebutton-drag>
			Rotate World..... <Ctrl> + <Middlebutton-drag>
			Rotate Camera..... <Ctrl> + <Alt> + <Middlebutton-drag>
			
			Additional actions:
			Scroll with arrow keys.
			Use <Shift> for faster scroll/zoom/altitude.
			Reset Camera..... <Ctrl> + <Alt> + <Shift> + <Middleclick>
			or /luaui ccc reset
		]],
	},
	oldscroll = {
		name = 'Spring Style Scrolling',
		type = 'bool',
		value = false,
		desc = 'Use spring style scrolling instead of Smoothscroll.',
	},
	targetmouse = {
		name = 'Rotate World Targets Cursor',
		type = 'bool',
		value = false,
		desc = 'Rotate world at origin of cursor rather than center of screen.',
	},
	edgemove = {
		name = 'Scroll Camera At Edge',
		type = 'bool',
		value = true,
		desc = 'Scroll camera when the cursor is at the edge of the screen.'
	},
	speedFactor = {
		name = 'Mouse Scroll Speed',
		desc = 'This speed applies to smoothscroll or spring style scroll.',
		type = 'number',
		min = 10,
		max = 40,
		value = 25,
	},
	speedFactor_k = {
		name = 'Arrow Keys/Edge Scroll Speed',
		desc = 'This speed applies to edge scrolling and arrow keys.',
		type = 'number',
		min = 5,
		max = 20,
		value = 10,
	},
	zoominfactor = {
		name = 'Zoom-In Speed',
		type = 'number',
		min = 0.1,
		max = 0.5,
		step = 0.05,
		value = 0.2,
	},
	zoomoutfactor = {
		name = 'Zoom-Out Speed',
		type = 'number',
		min = 0.1,
		max = 0.5,
		step = 0.05,
		value = 0.2,
	},
	invertzoom = {
		name = 'Invert Zoom',
		type = 'bool',
		value = false,
		desc = 'Invert the scroll wheel direction for zooming.'
	},
	--[[
	restrict = {
		name = 'Restrict Camera',
		type = 'bool',
		value = true,
		desc = 'Restrict the camera from scrolling off the map.'
	},
	--]]
	zoomoutfromcursor = {
		name = 'Zoom out from Cursor',
		type = 'bool',
		value = false,
		desc = 'Zoom out from the position of the cursor rather than the center of the screen.'
	},
	follow = {
		name = "Follow player's cursor",
		type = 'bool',
		value = false,
		desc = "Follow the cursor of the player you're spectating."
	},	
}

--add to options?
local ROTFACTOR = 0.005

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local GL_LINES    = GL.LINES

local glBeginEnd  = gl.BeginEnd
local glColor     = gl.Color
local glLineWidth = gl.LineWidth
local glVertex    = gl.Vertex

local spGetCameraState		= Spring.GetCameraState
local spGetCameraVectors	= Spring.GetCameraVectors
local spGetModKeyState		= Spring.GetModKeyState
local spGetMouseState		= Spring.GetMouseState
local spIsAboveMiniMap		= Spring.IsAboveMiniMap
local spSendCommands		= Spring.SendCommands
local spSetCameraState		= Spring.SetCameraState
local spSetMouseCursor		= Spring.SetMouseCursor
local spTraceScreenRay		= Spring.TraceScreenRay
local spWarpMouse			= Spring.WarpMouse
local spGetCameraDirection	= Spring.GetCameraDirection
local spSetCameraTarget		= Spring.SetCameraTarget

local abs	= math.abs
local min 	= math.min
local max	= math.max
local sqrt	= math.sqrt
local sin	= math.sin
local cos	= math.cos

local echo = Spring.Echo


local helpText = ''
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local vsx, vsy = widgetHandler:GetViewSizes()
function widget:ViewResize(viewSizeX, viewSizeY)
	vsx = viewSizeX
	vsy = viewSizeY
end

local init = true
local mx, my
local cx, cy
local smoothscroll = false
local springscroll = false
local springscrolldrag = false
local rotate, lockSpot, gx, gy, gz, gdist, movekey
local move = {}
local keys = {
	[276] = 'left',
	[275] = 'right',
	[273] = 'up',
	[274] = 'down',
}
local icon_size = 20
local cycle = 1
local camcycle = 1

local maxZoom = Game.mapSizeZ + 1000
if Game.mapSizeX > Game.mapSizeZ then
	maxZoom = Game.mapSizeX + 1000
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function explode(div,str)
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end

local function SetLockSpot(cs, x,y)
	local gpos
	if options.targetmouse.value then
		_, gpos = spTraceScreenRay(x, y, true)
	else
		_, gpos = spTraceScreenRay(vsx/2, vsy/2, true)
	end
	if gpos then
		gx,gy,gz = gpos[1], gpos[2], gpos[3]
		
		spSetCameraTarget(gx,gy,gz, 1)
		local px,py,pz = cs.px,cs.py,cs.pz
		local dx,dy,dz = gx-px, gy-py, gz-pz
		gdist = sqrt(dx*dx + dy*dy + dz*dz)
	--else
		--spSetCameraState(cs, 1)
	end
	
end

local function ResetCam()
	local cs = spGetCameraState()
	cs.px = Game.mapSizeX/2
	cs.py = maxZoom
	cs.pz = Game.mapSizeZ/2
	cs.rx = -3.14/2
	cs.ry = 3.14
	spSetCameraState(cs, 1)
end


local function MoveRotatedCam(cs, mxm, mym)
	-- forward, up, right, top, bottom, left, right
	local camVecs = spGetCameraVectors()
	local cf = camVecs.forward
	local len = sqrt((cf[1] * cf[1]) + (cf[3] * cf[3]))
	local dfx = cf[1] / len
	local dfz = cf[3] / len
	local cr = camVecs.right
	local len = sqrt((cr[1] * cr[1]) + (cr[3] * cr[3]))
	local drx = cr[1] / len
	local drz = cr[3] / len

	--[[ not so great.
	if options.restrict.value then
		local mxm = mxm
		local mym = mym
		
		local _, gpos = spTraceScreenRay(vsx*0.5,vsy*0.5,true)
		if gpos then
			local gx,gy,gz = gpos[1], gpos[2], gpos[3]
			
			local margin = 100
			
			local nx = gx + (mxm * drx)
			local nz = gz + (mxm * drz)
			if (nx > Game.mapSizeX - margin)
				or (nx < margin)
				or (nz > Game.mapSizeZ - margin)
				or (nz < margin)
				then
				mxm = 0
			end
				
			local nx = gx + (mym * dfx)
			local nz = gz + (mym * dfz)
			if (nx > Game.mapSizeX - margin)
				or (nx < margin)
				or (nz > Game.mapSizeZ - margin)
				or (nz < margin)
				then
				mym = 0
			end
				
			cs.px = cs.px + (mxm * drx) + (mym * dfx)
			cs.pz = cs.pz + (mxm * drz) + (mym * dfz)
		
			return cs
		end
	end
	--]]
	cs.px = cs.px + (mxm * drx) + (mym * dfx)
	cs.pz = cs.pz + (mxm * drz) + (mym * dfz)
	
	return cs
	
end


function widget:Update(dt)
	if options.follow.value then
		camcycle = camcycle %(32*6) + 1
		if camcycle == 1 then
			if WG.alliedCursorsPos then 
				local teamID = Spring.GetLocalTeamID()
				local _, playerID = Spring.GetTeamInfo(teamID)
				local pp = WG.alliedCursorsPos[ playerID ]
				if pp then 
					Spring.SetCameraTarget(pp[1], 0, pp[2], 5)
				end 
			end 
		end
	end
	cycle = cycle %(32*15) + 1
	-- Periodic warning
	if cycle == 1 then
		local c_widgets, c_widgets_list = '', {}
		for name,data in pairs(widgetHandler.knownWidgets) do
			if data.active and ( name:find('SmoothScroll') or name:find('Hybrid Overhead') )then
				c_widgets_list[#c_widgets_list+1] = name
			end
		end
		for _,wname in ipairs(c_widgets_list) do
			c_widgets = c_widgets .. wname .. ', '
		end
		if c_widgets ~= '' then
			echo('<CC Cam> *Periodic warning* Please disable other camera widgets: ' .. c_widgets)
		end
	end

	local cs = spGetCameraState()
	
	local use_springscrolldrag = springscrolldrag and not springscroll

	local a,c,m,s = spGetModKeyState()
	if smoothscroll
		or move.right or move.left or move.up or move.down
		or use_springscrolldrag
		then
		
		local x, y, lmb, mmb, rmb = spGetMouseState()
		
		if (c) then
			return
		end
		-- clear the velocities
		cs.vx  = 0; cs.vy  = 0; cs.vz  = 0
		cs.avx = 0; cs.avy = 0; cs.avz = 0
				
		local mxm, mym = 0,0
		
		local heightFactor = (cs.py/1000)
		if smoothscroll then
			local speed = dt * options.speedFactor.value * heightFactor 
			mxm = speed * (x - cx)
			mym = speed * (y - cy)
		elseif use_springscrolldrag then
			local speed = options.speedFactor.value * heightFactor / 10
			mxm = speed * (x - mx)
			mym = speed * (y - my)
			cx = vsx * 0.5
			cy = vsy * 0.5
			spWarpMouse(cx, cy)
		else
			local speed = options.speedFactor_k.value * (s and 3 or 1) * heightFactor
			
			if move.right then
				mxm = speed
			elseif move.left then
				mxm = -speed
			end
			
			if move.up then
				mym = speed
			elseif move.down then
				mym = -speed
			end
		end
		
		cs = MoveRotatedCam(cs, mxm, mym)
		
		spSetCameraState(cs, 0)
	end
	mx, my = spGetMouseState()
	
	if options.edgemove.value then
		if mx > vsx-3 then 
			move.right = true 
		elseif mx < 3 then
			move.left = true
		elseif my > vsy-3 then
			move.up = true
		elseif my < 3 then
			move.down = true
		elseif not movekey then
			move = {}
		end
	end

	if init or ((cs.name ~= "free") and (cs.name ~= "ov")) then 
		init = false
		spSendCommands("viewfree") 
		local cs = spGetCameraState()
		cs.tiltSpeed = 0
		cs.scrollSpeed = 0
		cs.gndOffset = 10
		spSetCameraState(cs,0)
	end
	
	
	

	

end

function widget:MouseMove(x, y, dx, dy, button)
	if rotate then
		local cs = spGetCameraState()
		if cs.rx then
			
			cs.rx = cs.rx + dy * ROTFACTOR
			cs.ry = cs.ry - dx * ROTFACTOR
			if cs.rx <= -1.5 then
				cs.rx = -1.49
			elseif cs.rx > 1.5 then
				cs.rx = 1.49
			end
			
			if lockSpot then
				if not gdist then
					SetLockSpot(cs, x,y)
				else
					local opp = sin(cs.rx) * gdist
					local alt = sqrt(gdist * gdist - opp * opp)
					cs.px = gx - sin(cs.ry) * alt
					cs.py = gy - opp
					cs.pz = gz - cos(cs.ry) * alt
				end
			end
			spSetCameraState(cs, 0)
			
			cx = vsx * 0.5
			cy = vsy * 0.5
			spWarpMouse(cx, cy)		
		end
	elseif springscroll then
		if dx > 0 or dy > 0 then
			springscrolldrag = false
		end
		
		local cs = spGetCameraState()
		
		local speed = options.speedFactor.value * cs.py/1000 / 10
		local mxm = speed * dx
		local mym = speed * dy
	
		cs = MoveRotatedCam(cs, mxm, mym)
				
		spSetCameraState(cs, 0)
		
		cx = vsx * 0.5
		cy = vsy * 0.5
		spWarpMouse(cx, cy)		
	end
end


function widget:MousePress(x, y, button)
	
	-- Not Middle Click --
	if (button ~= 2) then
		springscrolldrag = false
		return false
	end
	
	local a,c,m,s = spGetModKeyState()
	
	-- Reset --
	if a and c and s then
		ResetCam()
		return true
	end
	
	
	-- Above Minimap --
	if (spIsAboveMiniMap(x, y)) then
		return false
	end
	
	local cs = spGetCameraState()
	
	-- Rotate --
	rotate, lockSpot = false, false
	if c then
		rotate = true
		-- Rotate World --
		if not a then
			SetLockSpot(cs, x,y)
			lockSpot = true
		end
		return true
	end
	
	-- Scrolling --
	if options.oldscroll.value then
		springscroll = true
		springscrolldrag = not springscrolldrag
		
	else
		smoothscroll = true
	end
	cx = vsx * 0.5
	cy = vsy * 0.5
	spWarpMouse(cx, cy)
	spSendCommands({'trackoff'})

	return true
	
end

function widget:MouseRelease(x, y, button)
	if (button == 2) then
		rotate = nil
		lockSpot = nil
		smoothscroll = false
		springscroll = false
		gdist = nil
		return -1
	end
end

function widget:MouseWheel(up, value)
	local a,c,m,s = spGetModKeyState()
	
	local cs = spGetCameraState()
	
	if options.invertzoom.value then
		up = not up
	end
	
	-- Altitude --
	if c then
		local py = abs(cs.py)
		local dy = py * (up and 1 or -1) * (s and 0.3 or 0.1)
		spSetCameraState({ py = py + dy, }, 0)
		return true
	end
	
	-- Zoom --	
	local _, gpos = spTraceScreenRay(mx, my, true)
	
	local gx,gy,gz
	local dx, dy, dz
	local dist
	
	if not options.zoomoutfromcursor.value and up then
	elseif gpos then
		gx, gy, gz = gpos[1], gpos[2], gpos[3]
	elseif not up then --zooming in off map
		gx, gy, gz = Game.mapSizeX / 2, 0, Game.mapSizeZ / 2
	end
	
	
	if gx then
		dx = gx - cs.px
		dy = gy - cs.py
		dz = gz - cs.pz
		dist = sqrt((dx * dx) + (dy * dy) + (dz * dz))
	else
		dx = cs.px - Game.mapSizeX/2
		dy = cs.py - 0
		dz = cs.pz - Game.mapSizeZ/2
		
		dist = sqrt((dx * dx) + (dy * dy) + (dz * dz))
		
		dx = cs.dx*2000
		dy = cs.dy*2000
		dz = cs.dz*2000
	end
	
	
	local sp = (up and -options.zoomoutfactor.value or options.zoominfactor.value) * (s and 4 or 1)
	
	if not up or dist < maxZoom then
		dx = dx * sp
		dy = dy * sp
		dz = dz * sp
		local newCS = {
			px = cs.px + dx,
			py = cs.py + dy,
			pz = cs.pz + dz,
			--vx = 0,
			--vy = 0,
			--vz = 0,
		}
		spSetCameraState(newCS, 0)
	end

	return true
end

function widget:KeyPress(key, modifier, isRepeat)
	if keys[key] then
		movekey = true
		move[keys[key]] = true
	end
end
function widget:KeyRelease(key)
	if keys[key] then
		move[keys[key]] = nil
	end
	if not (move.up or move.down or move.left or move.right) then
		movekey = nil
	end
end

local function DrawLine(x0, y0, c0, x1, y1, c1)
  glColor(c0); glVertex(x0, y0)
  glColor(c1); glVertex(x1, y1)
end

local red   = { 1, 0, 0 }
local green = { 0, 1, 0 }
local black = { 0, 0, 0 }
local white = { 1, 1, 1 }

function widget:DrawScreen()
	if not cx then return end

	local filefound	
	if smoothscroll then
		filefound = gl.Texture(LUAUI_DIRNAME .. 'Images/ccc/smoothscroll.png')
	elseif rotate and lockSpot then
		filefound = gl.Texture(LUAUI_DIRNAME .. 'Images/ccc/rotate1.png')
	elseif rotate then
		filefound = gl.Texture(LUAUI_DIRNAME .. 'Images/ccc/rotate2.png')
	elseif springscrolldrag then
		filefound = gl.Texture(LUAUI_DIRNAME .. 'Images/ccc/springscroll1.png')
	elseif springscroll then
		filefound = gl.Texture(LUAUI_DIRNAME .. 'Images/ccc/springscroll2.png')
	end
	
	if filefound then
		spSetMouseCursor('none')
		gl.TexRect(cx-icon_size, cy-icon_size, cx+icon_size, cy+icon_size)
		gl.Texture(false)
		if smoothscroll then
			local x, y = spGetMouseState()
			glLineWidth(2)
			glBeginEnd(GL_LINES, DrawLine, x, y, green, cx, cy, red)
			glLineWidth(1)
		end
	end
	

end
function widget:Initialize()
	helpText = explode( '\n', options.helpwindow.value )
end
function widget:Shutdown()
	spSendCommands{"viewta"}
end

function widget:TextCommand(command)
	if command == "ccc target" then
		return true
	elseif command == "ccc help" then
		for i, text in ipairs(helpText) do
			echo('<CC Cam['.. i ..']> '.. text)
		end
		return true
	elseif command == "ccc reset" then
		ResetCam()
		return true
	end
	return false
end   

--------------------------------------------------------------------------------
