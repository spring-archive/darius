function widget:GetInfo()
	return {
		name      = "Lasso Terraform GUI",
		desc      = "Interface for lasso terraform.",
		author    = "Google Frog",
		version   = "v1",
		date      = "Nov, 2009",
		license   = "GNU GPL, v2 or later",
		layer     = 3,
		enabled   = true,
		handler   = true,
	}
end

include("keysym.h.lua")

--------------------------------------------------------------------------------
-- Speedups
--------------------------------------------------------------------------------

local osclock	= os.clock

local GL_LINE_STRIP		= GL.LINE_STRIP
local GL_LINES			= GL.LINES
local glVertex			= gl.Vertex
local glLineStipple 	= gl.LineStipple
local glLineWidth   	= gl.LineWidth
local glColor       	= gl.Color
local glBeginEnd    	= gl.BeginEnd
local glPushMatrix		= gl.PushMatrix
local glPopMatrix		= gl.PopMatrix
local glScale			= gl.Scale
local glTranslate		= gl.Translate
local glLoadIdentity	= gl.LoadIdentity
local glCallList        = gl.CallList
local glCreateList      = gl.CreateList
local glDepthTest		= gl.DepthTest
local glBillboard       = gl.Billboard
local glText            = gl.Text

local spGetActiveCommand 	= Spring.GetActiveCommand
local spSetActiveCommand	= Spring.SetActiveCommand

local spIsAboveMiniMap		= Spring.IsAboveMiniMap --
--local spGetMiniMapGeometry	= (Spring.GetMiniMapGeometry or Spring.GetMouseMiniMapState)

local spGetSelectedUnits	= Spring.GetSelectedUnits

local spGiveOrder			= Spring.GiveOrder
local spGetUnitDefID 		= Spring.GetUnitDefID
local spGiveOrderToUnit   	= Spring.GiveOrderToUnit
local spGetUnitPosition		= Spring.GetUnitPosition
local spGetModKeyState		= Spring.GetModKeyState
local spGetUnitBuildFacing  = Spring.GetUnitBuildFacing

local spTraceScreenRay		= Spring.TraceScreenRay
local spGetGroundHeight		= Spring.GetGroundHeight
local spGetCurrentTooltip	= Spring.GetCurrentTooltip

local spSendCommands 		= Spring.SendCommands

local mapWidth, mapHeight 	= Game.mapSizeX, Game.mapSizeZ
local maxUnits = Game.maxUnits

local st_find = string.find

local sqrt	= math.sqrt
local floor = math.floor
local ceil = math.ceil 
local abs = math.abs
local modf = math.modf
local string_format = string.format

local team = Spring.GetMyTeamID()

-- command IDs
local CMD_RAMP = 39734
local CMD_LEVEL = 39736
local CMD_RAISE = 39737
local CMD_SMOOTH = 39738
local CMD_RESTORE = 39739
local CMD_TERRAFORM_INTERNAL = 39801

local Grid = 16 -- grid size, do not change without other changes.

---------------------------------
--Config
---------------------------------

-- max difference of height around terraforming, Makes Shraka Pyramids. Not used
local maxHeightDifference = 30 

-- elmos of height that correspond to a 1 veritcal pixel of mouse movement during height choosing
local mouseSensitivity = 2 

-- snap to Y grid for raise
local heightSnap = 15

-- max sizes of non-ramp command, reduces slowdown MUST AGREE WITH GADGET VALUES
local maxAreaSize = 2000 -- max width or length
local maxWallPoints = 700 -- max points that makeup a wall

-- bounding ramp dimensions, reduces slowdown MUST AGREE WITH GADGET VALUES
local maxRampLength = 3000
local maxRampWidth = 800
local minRampLength = 32
local minRampWidth = 24

local startRampWidth = 40

-- max slope of certain units, changes ramp colour
local botPathingGrad = 1.35
local vehPathingGrad = 0.5

-- Colours used during height choosing for level and raise
local negVolume   = {1, 0, 0, 0.1} -- negative volume
local posVolume   = {0, 1, 0, 0.1} -- posisive volume
local groundGridColor  = {0.3, 0.2, 1, 0.8} -- grid representing new ground height

-- colour of lasso during drawing
local lassoColor = {0.2, 1.0, 0.2, 1.0}

-- colour of ramp
local vehPathingColor = {0.2, 1.0, 0.2, 1.0}
local botPathingColor = {0.78, .78, 0.39, 1.0}
local noPathingColor = {1.0, 0.2, 0.2, 1.0}

-- cost mult of terra
local costMult = 1
local modOptions = Spring.GetModOptions()
if modOptions.terracostmult then
	costMult = modOptions.terracostmult
end

----------------------------------
-- Global Vars

local drawingLasso = false
local drawingRectangle = false
local drawingRamp = false
local setHeight = false
local terraform_type = 1 -- 1 = level, 2 = raise, 3 = smooth, 4 = ramp, 5 = restore

local volumeSelection = 0

local mouseBuilding = false

local terraformHeight = 0
local orHeight = 0 -- store ground height
local storedHeight = 0 -- for snap to height
local loop = 0

local point = {}
local points = 0

local drawPoint = {}
local drawPoints = 0

local volumeDraw
local groundGridDraw
local mouseGridDraw

local mouseUnit = {id = false}

local mouseX, mouseY

---------------

local function SendCommand()
			
	local constructor = spGetSelectedUnits()

	if terraform_type == 4 then
		if (#constructor > 0) then 
			local params = {}
			params[1] = terraform_type
			params[2] = team
			params[3] = loop
			params[4] = terraformHeight 
			params[5] = points
			params[6] = storedHeight
			params[7] = volumeSelection
			local i = 8
			for j = 1, points do
				params[i] = point[j].x
				params[i + 1] = point[j].y
				params[i + 2] = point[j].z
				i = i + 3
			end
					
			i = i + 2
			for j = 1, #constructor do
				params[i] = constructor[j]
				i = i + 1
			end
			
			local a,c,m,s = spGetModKeyState()
			
			if s then
				Spring.GiveOrderToUnit(constructor[1], CMD_TERRAFORM_INTERNAL, params, {"shift"})
			else
				Spring.GiveOrderToUnit(constructor[1], CMD_TERRAFORM_INTERNAL, params, {})
				spSetActiveCommand(-1)
			end
		end
	else
		if (#constructor > 0) then 
			local params = {}
			params[1] = terraform_type
			params[2] = team
			params[3] = loop
			params[4] = terraformHeight 
			params[5] = points
			params[6] = #constructor
			params[7] = volumeSelection
			local i = 8
			for j = 1, points do
				params[i] = point[j].x
				params[i + 1] = point[j].z
				i = i + 2
			end
			
			
					
			i = i + 2
			for j = 1, #constructor do
				params[i] = constructor[j]
				i = i + 1
			end
			
			local a,c,m,s = spGetModKeyState()
			
			if s then
				Spring.GiveOrderToUnit(constructor[1], CMD_TERRAFORM_INTERNAL, params, {"shift"})
			else
				Spring.GiveOrderToUnit(constructor[1], CMD_TERRAFORM_INTERNAL, params, {})
				spSetActiveCommand(-1)
			end
		end
	end
	points = 0		
end

---------------

local function lineVolumeLevel()

	for i = 1, drawPoints do
		repeat -- emulating continue
			if (terraformHeight < drawPoint[i].ytl) then
				if (volumeSelection == 1) then
					break -- continue
				end
				glColor(negVolume)
			else
				if (volumeSelection == 2) then
					break -- continue
				end
				glColor(posVolume)
			end
			
			for lx = 0,12,4 do
				for lz = 0,12,4 do
					glVertex(drawPoint[i].x+lx ,drawPoint[i].ytl,drawPoint[i].z+lz)
					glVertex(drawPoint[i].x+lx ,terraformHeight,drawPoint[i].z+lz)
				end
			end
		until true --do not repeat
	end

end

local function lineVolumeRaise()

	for i = 1, drawPoints do
		if (terraformHeight < 0) then
			glColor(negVolume)
		else
			glColor(posVolume)
		end
		
		for lx = 2,14,4 do
			for lz = 2,14,4 do
				glVertex(drawPoint[i].x+lx ,drawPoint[i].ytl,drawPoint[i].z+lz)
				glVertex(drawPoint[i].x+lx ,drawPoint[i].ytl + terraformHeight,drawPoint[i].z+lz)
			end
		end
		
	end

end

local function groundGrid()

	for i = 1, drawPoints do
	
		glColor(groundGridColor)
		
		glVertex(drawPoint[i].x,drawPoint[i].ytl,drawPoint[i].z)
		glVertex(drawPoint[i].x+Grid,drawPoint[i].ytr,drawPoint[i].z)

		glVertex(drawPoint[i].x,drawPoint[i].ytl,drawPoint[i].z)
		glVertex(drawPoint[i].x,drawPoint[i].ybl,drawPoint[i].z+Grid)
		
		if drawPoint[i].Right then
			glVertex(drawPoint[i].x+16,drawPoint[i].ytr,drawPoint[i].z)
			glVertex(drawPoint[i].x+16,drawPoint[i].ybr,drawPoint[i].z+Grid)
		end
		
		if drawPoint[i].Bottom then
			glVertex(drawPoint[i].x,drawPoint[i].ybl,drawPoint[i].z+16)
			glVertex(drawPoint[i].x+Grid,drawPoint[i].ybr,drawPoint[i].z+16)
		end
		
	end

end

local function mouseGridLevel()

	for i = 1, drawPoints do
	
		glColor(groundGridColor)
		
		glVertex(drawPoint[i].x,terraformHeight,drawPoint[i].z)
		glVertex(drawPoint[i].x+Grid,terraformHeight,drawPoint[i].z)

		glVertex(drawPoint[i].x,terraformHeight,drawPoint[i].z)
		glVertex(drawPoint[i].x,terraformHeight,drawPoint[i].z+Grid)
		
		if drawPoint[i].Right then
			glVertex(drawPoint[i].x+16,terraformHeight,drawPoint[i].z)
			glVertex(drawPoint[i].x+16,terraformHeight,drawPoint[i].z+Grid)
		end
		
		if drawPoint[i].Bottom then
			glVertex(drawPoint[i].x,terraformHeight,drawPoint[i].z+16)
			glVertex(drawPoint[i].x+Grid,terraformHeight,drawPoint[i].z+16)
		end
		
	end

end

local function mouseGridRaise()

	for i = 1, drawPoints do
	
		glColor(groundGridColor)
		
		glVertex(drawPoint[i].x,drawPoint[i].ytl+terraformHeight,drawPoint[i].z)
		glVertex(drawPoint[i].x+Grid,drawPoint[i].ytr+terraformHeight,drawPoint[i].z)

		glVertex(drawPoint[i].x,drawPoint[i].ytl+terraformHeight,drawPoint[i].z)
		glVertex(drawPoint[i].x,drawPoint[i].ybl+terraformHeight,drawPoint[i].z+Grid)
		
		if drawPoint[i].Right then
			glVertex(drawPoint[i].x+16,drawPoint[i].ytr+terraformHeight,drawPoint[i].z)
			glVertex(drawPoint[i].x+16,drawPoint[i].ybr+terraformHeight,drawPoint[i].z+Grid)
		end
		
		if drawPoint[i].Bottom then
			glVertex(drawPoint[i].x,drawPoint[i].ybl+terraformHeight,drawPoint[i].z+16)
			glVertex(drawPoint[i].x+Grid,drawPoint[i].ybr+terraformHeight,drawPoint[i].z+16)
		end
		
	end

end

local function calculateLinePoints(mPoint, mPoints)

	local border = {left = Game.mapSizeX, right = 0, top = Game.mapSizeZ, bottom = 0}
	
	local gPoint = {}
	local gPoints = 1
	
	mPoint[1].x = floor((mPoint[1].x+8)/16)*16
	mPoint[1].z = floor((mPoint[1].z+8)/16)*16
	
	gPoint[1] = {x = floor((mPoint[1].x+8)/16)*16, z = floor((mPoint[1].z+8)/16)*16}
	
	if gPoint[gPoints].x < border.left then
		border.left = gPoint[gPoints].x 
	end
	if gPoint[gPoints].x > border.right then
		border.right = gPoint[gPoints].x 
	end
	if gPoint[gPoints].z < border.top then
		border.top = gPoint[gPoints].z
	end
	if gPoint[gPoints].z > border.bottom then
		border.bottom = gPoint[gPoints].z 
	end
	
	
	for i = 2, mPoints, 1 do
		mPoint[i].x = floor((mPoint[i].x+8)/16)*16
		mPoint[i].z = floor((mPoint[i].z+8)/16)*16
		
		local diffX = mPoint[i].x - mPoint[i-1].x
		local diffZ = mPoint[i].z - mPoint[i-1].z
		local a_diffX = abs(diffX)
		local a_diffZ = abs(diffZ)
			
		if a_diffX <= 16 and a_diffZ <= 16 then
			gPoints = gPoints + 1
			gPoint[gPoints] = {x = mPoint[i].x, z = mPoint[i].z}
			if gPoint[gPoints].x < border.left then
				border.left = gPoint[gPoints].x 
			end
			if gPoint[gPoints].x > border.right then
				border.right = gPoint[gPoints].x 
			end
			if gPoint[gPoints].z < border.top then
				border.top = gPoint[gPoints].z
			end
			if gPoint[gPoints].z > border.bottom then
				border.bottom = gPoint[gPoints].z 
			end
		else

			-- prevent holes inbetween points
			if a_diffX > a_diffZ then
				local m = diffZ/diffX
				local sign = diffX/a_diffX
				for j = 0, a_diffX, 16 do	
					gPoints = gPoints + 1
					gPoint[gPoints] = {x = mPoint[i-1].x + j*sign, z = floor((mPoint[i-1].z + j*m*sign)/16)*16}
					if gPoint[gPoints].x < border.left then
						border.left = gPoint[gPoints].x 
					end
					if gPoint[gPoints].x > border.right then
						border.right = gPoint[gPoints].x 
					end
					if gPoint[gPoints].z < border.top then
						border.top = gPoint[gPoints].z
					end
					if gPoint[gPoints].z > border.bottom then
						border.bottom = gPoint[gPoints].z 
					end
				end
			else
				local m = diffX/diffZ
				local sign = diffZ/a_diffZ
				for j = 0, a_diffZ, 16 do	
					gPoints = gPoints + 1
					gPoint[gPoints] = {x = floor((mPoint[i-1].x + j*m*sign)/16)*16, z = mPoint[i-1].z + j*sign}
					if gPoint[gPoints].x < border.left then
						border.left = gPoint[gPoints].x 
					end
					if gPoint[gPoints].x > border.right then
						border.right = gPoint[gPoints].x 
					end
					if gPoint[gPoints].z < border.top then
						border.top = gPoint[gPoints].z
					end
					if gPoint[gPoints].z > border.bottom then
						border.bottom = gPoint[gPoints].z 
					end
				end
			end
			
		end
	end
	
	if gPoints > maxWallPoints then
		Spring.Echo("Terraform Command Too Large")
		setHeight = false
		drawingLoop = false
		volumeDraw = false
		groundGridDraw = false
		mouseGridDraw = false
		points = 0
		return
	end
	
	local area = {}
	
	for i = border.left-32,border.right+32,16 do
		area[i] = {}
	end
	
	drawPoint = {}
	drawPoints = 0
	
	for i = 1, gPoints do
		
		for lx = -16,0,16 do
			for lz = -16,0,16 do
				if not area[gPoint[i].x+lx][gPoint[i].z+lz] then
					drawPoints = drawPoints + 1
					drawPoint[drawPoints] = {x = gPoint[i].x+lx,z = gPoint[i].z+lz, 
						ytl = spGetGroundHeight(gPoint[i].x+lx,gPoint[i].z+lz), 
						ytr = spGetGroundHeight(gPoint[i].x+lx+16,gPoint[i].z+lz),
						ybl = spGetGroundHeight(gPoint[i].x+lx,gPoint[i].z+lz+16), 
						ybr = spGetGroundHeight(gPoint[i].x+lx+16,gPoint[i].z+lz+16),
					}
					area[gPoint[i].x+lx][gPoint[i].z+lz]  = true
				end
			end
		end
	
	end
	
	for i = 1, drawPoints do
		
		if not area[drawPoint[i].x+16][drawPoint[i].z] then
			drawPoint[i].Right = true
		end
		if not area[drawPoint[i].x][drawPoint[i].z+16] then
			drawPoint[i].Bottom = true
		end
		
	end
	
end

local function calculateAreaPoints(mPoint, mPoints)
	local border = {left = Game.mapSizeX, right = 0, top = Game.mapSizeZ, bottom = 0}
	
	local gPoint = {}
	local gPoints = 1
	
	mPoints = mPoints + 1
	mPoint[mPoints] = mPoint[1]
	
	mPoint[1].x = floor((mPoint[1].x)/16)*16
	mPoint[1].z = floor((mPoint[1].z)/16)*16
	
	gPoint[1] = {x = floor((mPoint[1].x)/16)*16, z = floor((mPoint[1].z)/16)*16}
	
	if gPoint[gPoints].x < border.left then
		border.left = gPoint[gPoints].x 
	end
	if gPoint[gPoints].x > border.right then
		border.right = gPoint[gPoints].x 
	end
	if gPoint[gPoints].z < border.top then
		border.top = gPoint[gPoints].z
	end
	if gPoint[gPoints].z > border.bottom then
		border.bottom = gPoint[gPoints].z 
	end
	
	for i = 2, mPoints, 1 do
		mPoint[i].x = floor((mPoint[i].x)/16)*16
		mPoint[i].z = floor((mPoint[i].z)/16)*16
		
		local diffX = mPoint[i].x - mPoint[i-1].x
		local diffZ = mPoint[i].z - mPoint[i-1].z
		local a_diffX = abs(diffX)
		local a_diffZ = abs(diffZ)
			
		if a_diffX <= 16 and a_diffZ <= 16 then
			gPoints = gPoints + 1
			gPoint[gPoints] = {x = mPoint[i].x, z = mPoint[i].z}
			if gPoint[gPoints].x < border.left then
				border.left = gPoint[gPoints].x 
			end
			if gPoint[gPoints].x > border.right then
				border.right = gPoint[gPoints].x 
			end
			if gPoint[gPoints].z < border.top then
				border.top = gPoint[gPoints].z
			end
			if gPoint[gPoints].z > border.bottom then
				border.bottom = gPoint[gPoints].z 
			end
		else

			-- prevent holes inbetween points
			if a_diffX > a_diffZ then
				local m = diffZ/diffX
				local sign = diffX/a_diffX
				for j = 0, a_diffX, 16 do	
					gPoints = gPoints + 1
					gPoint[gPoints] = {x = mPoint[i-1].x + j*sign, z = floor((mPoint[i-1].z + j*m*sign)/16)*16}
					if gPoint[gPoints].x < border.left then
						border.left = gPoint[gPoints].x 
					end
					if gPoint[gPoints].x > border.right then
						border.right = gPoint[gPoints].x 
					end
					if gPoint[gPoints].z < border.top then
						border.top = gPoint[gPoints].z
					end
					if gPoint[gPoints].z > border.bottom then
						border.bottom = gPoint[gPoints].z 
					end
				end
			else
				local m = diffX/diffZ
				local sign = diffZ/a_diffZ
				for j = 0, a_diffZ, 16 do	
					gPoints = gPoints + 1
					gPoint[gPoints] = {x = floor((mPoint[i-1].x + j*m*sign)/16)*16, z = mPoint[i-1].z + j*sign}
					if gPoint[gPoints].x < border.left then
						border.left = gPoint[gPoints].x 
					end
					if gPoint[gPoints].x > border.right then
						border.right = gPoint[gPoints].x 
					end
					if gPoint[gPoints].z < border.top then
						border.top = gPoint[gPoints].z
					end
					if gPoint[gPoints].z > border.bottom then
						border.bottom = gPoint[gPoints].z 
					end
				end
			end
			
		end
	end
	
	if border.right-border.left > maxAreaSize or border.bottom-border.top > maxAreaSize then
		Spring.Echo("Terraform Command Too Large")
		setHeight = false
		drawingLoop = false
		volumeDraw = false
		groundGridDraw = false
		mouseGridDraw = false
		points = 0
		return
	end
	
	local area = {}
	
	for i = border.left-32,border.right+32,16 do
		area[i] = {}
	end
	
	for i = 1, gPoints do
		area[gPoint[i].x][gPoint[i].z] = 2
	end
	
	for i = border.left,border.right,16 do
		for j = border.top,border.bottom,16 do
			if area[i][j] ~= 2 then
				area[i][j] = 1
			end
		end
	end
	
	for i = border.left,border.right,16 do
		if area[i][border.top] ~= 2 then
			area[i][border.top] = -1
		end
		if area[i][border.bottom] ~= 2 then
			area[i][border.bottom] = -1
		end
	end
	for i = border.top,border.bottom,16 do
		if area[border.left][i] ~= 2 then
			area[border.left][i] = -1
		end
		if area[border.right][i] ~= 2 then
			area[border.right][i] = -1
		end
	end
	
	local continue = true

	while continue do
		continue = false
		for i = border.left,border.right,16 do
			for j = border.top,border.bottom,16 do
				if area[i][j] == -1 then
					if area[i+16][j] == 1 then
						area[i+16][j] = -1
						continue = true
					end
					if area[i-16][j]  == 1 then
						area[i-16][j]  = -1
						continue = true
					end
					if area[i][j+16] == 1 then
						area[i][j+16] = -1
						continue = true
					end
					if area[i][j-16] == 1 then
						area[i][j-16] = -1
						continue = true
					end
					area[i][j] = false
				end
			end
		end
		
	end
	
	drawPoint = {}
	drawPoints = 0
	
	for i = border.left, border.right, 16 do
		for j = border.top, border.bottom, 16 do
			if area[i][j] then
				drawPoints = drawPoints + 1
				drawPoint[drawPoints] = {x = i,z = j, 
					ytl = spGetGroundHeight(i,j), 
					ytr = spGetGroundHeight(i+16,j),
					ybl = spGetGroundHeight(i,j+16), 
					ybr = spGetGroundHeight(i+16,j+16),
				}
			end
		end
	end
	
	for i = 1, drawPoints do
		
		if not area[drawPoint[i].x+16][drawPoint[i].z] then
			drawPoint[i].Right = true
		end
		if not area[drawPoint[i].x][drawPoint[i].z+16] then
			drawPoint[i].Bottom = true
		end
		
	end
	
end

--------------------------------------------------------------------------------
-- Mouse/keyboard Callins
--------------------------------------------------------------------------------

local function snapToHeight(heightArray, snapHeight, arrayCount)
	local smallest = abs(heightArray[1] - snapHeight)
	local smallestIndex = 1
	for i=2, arrayCount do
		local diff = abs(heightArray[i] - snapHeight)
		if diff < smallest then
			smallest = diff
			smallestIndex = i
		end
	end
	return smallestIndex
end

function widget:MousePress(mx, my, button)

	local toolTip = Spring.GetCurrentTooltip()
	if not (toolTip == "" or st_find(toolTip, "TechLevel") or st_find(toolTip, "Terrain type") or st_find(toolTip, "Metal:")) then
		return false
	end

	local activeCmdIndex, activeid = spGetActiveCommand()
	
	if ((activeid == CMD_LEVEL) or (activeid == CMD_RAISE) or (activeid == CMD_SMOOTH) or (activeid == CMD_RESTORE)) and not (setHeight or drawingRectangle or drawingLasso or drawingRamp) then
	
		if button == 1 then
			if not spIsAboveMiniMap(mx, my) then
		
				local _, pos = spTraceScreenRay(mx, my, true)
				if pos then	
					widgetHandler:UpdateWidgetCallIn("DrawWorld", self)
					orHeight = spGetGroundHeight(pos[1],pos[3])
					
					local a,c,m,s = spGetModKeyState()
					if a then
						local ty, id = spTraceScreenRay(mx, my, false)
						if ty == "unit" then
							local ud = UnitDefs[spGetUnitDefID(id)]
							--if (ud.isBuilding == true or ud.maxAcc == 0) then
								mouseUnit = {id = id, ud = ud}
							--end
						end
						drawingRectangle = true
						drawingLasso = false
						point[1] = {x = floor((pos[1])/16)*16, y = spGetGroundHeight(pos[1],pos[3]), z = floor((pos[3])/16)*16}
						point[2] = {x = floor((pos[1])/16)*16, y = spGetGroundHeight(pos[1],pos[3]), z = floor((pos[3])/16)*16}
						point[3] = {x = floor((pos[1])/16)*16, y = spGetGroundHeight(pos[1],pos[3]), z = floor((pos[3])/16)*16}
					else
						drawingRectangle = false
						drawingLasso = true
						points = 1
						point[1] = {x = pos[1], y = orHeight, z = pos[3]}
					end
					
					if (activeid == CMD_LEVEL) then
						terraform_type = 1
						terraformHeight = point[1].y
						storedHeight = orHeight
					elseif (activeid == CMD_RAISE) then
						terraform_type = 2
						terraformHeight = 0
						storedHeight = 0
					elseif (activeid == CMD_SMOOTH) then
						terraform_type = 3
					elseif (activeid == CMD_RESTORE) then
						terraform_type = 5
					end
					
					return true
				end
			end
		else
			spSetActiveCommand(-1)
			return true
		end
		
	elseif (activeid == CMD_RAMP) and not (setHeight or drawingRectangle or drawingLasso or drawingRamp) then
		if button == 1 then
			if not spIsAboveMiniMap(mx, my) then
		
				local _, pos = spTraceScreenRay(mx, my, true)
				if pos then	
				
					widgetHandler:UpdateWidgetCallIn("DrawWorld", self)
					orHeight = spGetGroundHeight(pos[1],pos[3])
					
					point[1] = {x = pos[1], y = orHeight, z = pos[3], ground = orHeight}
					point[2] = {x = pos[1], y = point[1].y, z = pos[3], ground = point[1]}
					storedHeight = orHeight
					points = 2
					drawingRamp = 1
					terraform_type = 4
					terraformHeight = startRampWidth -- width
					mouseX = mx
					mouseY = my
					return true
					
				end
			end
		end
		
	end
	
	if setHeight and button == 1 then
		
		SendCommand()
		volumeSelection = 0
		setHeight = false
		drawingLoop = false
		volumeDraw = false
		groundGridDraw = false
		mouseGridDraw = false
		drawingRamp = false
		points = 0
		return true
	end
	
	if drawingRamp == 2 and button == 1 then
		mouseX = mx
		mouseY = my
		drawingRamp = 3
		return true
	end
	
	if drawingLasso or setHeight or drawingRamp or drawingRectangle then
		if button == 3 then
			spSetActiveCommand(-1)
			drawingLasso = false
			drawingRectangle = false
			setHeight = false
			volumeDraw = false
			groundGridDraw = false
			mouseGridDraw = false
			drawingRamp = false
			volumeSelection = 0
			points = 0
			return true
		end
	end
	
	return false
end

function widget:MouseMove(mx, my, dx, dy, button)

	if drawingLasso then

		if button == 1 then
			local _, pos = spTraceScreenRay(mx, my, true)
			local a,c,m,s = spGetModKeyState()
			if pos and not c then
				
				local diffX = abs(point[points].x - pos[1])
				local diffZ = abs(point[points].z - pos[3])
				
				if diffX >= 10 or diffZ >= 10 then
					points = points + 1
					point[points] = {x = pos[1], y = pos[2], z = pos[3]}
				end
			end
		end
		
		return true
		
	elseif drawingRectangle then

		if button == 1 then
			local _, pos = spTraceScreenRay(mx, my, true)
		
			if pos then
			
				local x = floor((pos[1])/16)*16
				local z = floor((pos[3])/16)*16
				
				if x > point[1].x then
					point[2].x = x+16
					point[3].x = point[1].x
				else
					if x - point[1].x == 0 then
						x = x - 16
					end
					point[2].x = x
					point[3].x = point[1].x+16
				end
				
				if z > point[1].z then
					point[2].z = z+16
					point[3].z = point[1].z
				else
					if z - point[1].z == 0 then
						z = z - 16
					end
					point[2].z = z
					point[3].z = point[1].z+16
				end
			end
		end
		
		return true
		
	elseif drawingRamp == 1 then
		
		local a,c,m,s = spGetModKeyState()
		if a then
			Spring.WarpMouse (mouseX,mouseY)
			storedHeight = storedHeight + (my-mouseY)*mouseSensitivity
			local heightArray = {
				-6,
				orHeight,
			}
			point[1].y = heightArray[snapToHeight(heightArray,storedHeight,2)]
		else
			if my ~= mouseY then
				Spring.WarpMouse (mouseX,mouseY)
				point[1].y = point[1].y + (my-mouseY)*mouseSensitivity
				storedHeight = point[1].y 
			end	
		end
		
		return true
		
	elseif drawingRamp == 3 then

		local a,c,m,s = spGetModKeyState()
		if a then
			Spring.WarpMouse (mouseX,mouseY)

			local dis = sqrt((point[1].x-point[2].x)^2 + (point[1].z-point[2].z)^2)
			storedHeight = storedHeight + (my-mouseY)/50*dis*mouseSensitivity
			local heightArray = {
				botPathingGrad*dis+point[1].y,
				vehPathingGrad*dis+point[1].y,
				point[1].y,
				-botPathingGrad*dis+point[1].y,
				-vehPathingGrad*dis+point[1].y,
				-5,
				orHeight,
			}
			point[2].y = heightArray[snapToHeight(heightArray,storedHeight,7)]
		else
			if my ~= mouseY then
				Spring.WarpMouse (mouseX,mouseY)
				point[2].y = point[2].y + (my-mouseY)*mouseSensitivity
				storedHeight = point[2].y 
			end
		end
			
		return true
	
	end
	
	return false
end

function widget:Update(n)

	if setHeight then
		local mx,my = Spring.GetMouseState()
			
		if terraform_type == 1 then
			local a,c,m,s = spGetModKeyState()
			if c then
				local _, pos = spTraceScreenRay(mx, my, true)
				if pos then	
					terraformHeight = pos[2]
					storedHeight = terraformHeight
					mouseX = mx
					mouseY = my
				end
			elseif a then
				Spring.WarpMouse (mouseX,mouseY)
				storedHeight = storedHeight + (my-mouseY)*mouseSensitivity 
				local heightArray = {
					-2,
					orHeight,
					-23,
				}
				terraformHeight = heightArray[snapToHeight(heightArray,storedHeight,3)]
			else
				Spring.WarpMouse (mouseX,mouseY)
				terraformHeight = terraformHeight + (my-mouseY)*mouseSensitivity
				storedHeight = terraformHeight
			end
			volumeDraw = glCreateList(glBeginEnd, GL_LINES, lineVolumeLevel)
			mouseGridDraw = glCreateList(glBeginEnd, GL_LINES, mouseGridLevel)
		elseif terraform_type == 2 then
			Spring.WarpMouse (mouseX,mouseY)
			local a,c,m,s = spGetModKeyState()
			if c then
				terraformHeight = 0
				storedHeight = 0
			elseif a then
				storedHeight = storedHeight + (my-mouseY)*mouseSensitivity 
				terraformHeight = floor((storedHeight+heightSnap/2)/heightSnap)*heightSnap
			else
				terraformHeight = terraformHeight + (my-mouseY)*mouseSensitivity
				storedHeight = terraformHeight
			end
			volumeDraw = glCreateList(glBeginEnd, GL_LINES, lineVolumeRaise)
			mouseGridDraw = glCreateList(glBeginEnd, GL_LINES, mouseGridRaise)
		elseif terraform_type == 4 then
			Spring.WarpMouse (mouseX,mouseY)
			terraformHeight = terraformHeight + (my-mouseY)*mouseSensitivity
			if terraformHeight < minRampWidth then
				terraformHeight = minRampWidth
			end
			if terraformHeight > maxRampWidth then
				terraformHeight = maxRampWidth
			end
		end
	
	elseif drawingRamp == 2 then
		local mx,my = Spring.GetMouseState()
		local _, pos = spTraceScreenRay(mx, my, true)
		if pos then
			local dis = sqrt((point[1].x-pos[1])^2 + (point[1].z-pos[3])^2)
			if dis ~= 0 then
				orHeight = spGetGroundHeight(pos[1],pos[3])
				storedHeight = orHeight
				if dis < minRampLength then
					point[2] = {
						x = point[1].x+minRampLength*(pos[1]-point[1].x)/dis, 
						y = orHeight, 
						z = point[1].z+minRampLength*(pos[3]-point[1].z)/dis, 
						ground = orHeight
					}
				elseif dis > maxRampLength then
					point[2] = {
						x = point[1].x+maxRampLength*(pos[1]-point[1].x)/dis, 
						y = orHeight, 
						z = point[1].z+maxRampLength*(pos[3]-point[1].z)/dis, 
						ground = orHeight
					}
				else
					point[2] = {x = pos[1], y = orHeight, z = pos[3], ground = orHeight}	
				end
			end
		end
	end

end

function widget:MouseRelease(mx, my, button)
	
	if drawingLasso then
		if button == 1 then
			--spSetActiveCommand(-1)
			
			local _, pos = spTraceScreenRay(mx, my, true)
			if pos then
				local diffX = abs(point[points].x - pos[1])
				local diffZ = abs(point[points].z - pos[3])
				if diffX >= 10 or diffZ >= 10 then
					points = points + 1
					point[points] = {x = pos[1], y = pos[2], z = pos[3]}
				end
			end
			
			if terraform_type == 1 or terraform_type == 2 then
				setHeight = true
				drawingLasso = false
				mouseX = mx
				mouseY = my
				
				local disSQ = (point[1].x-point[points].x)^2 + (point[1].z-point[points].z)^2
			
				if disSQ < 6400 and points > 10 then
					loop = 1
					calculateAreaPoints(point,points)
					groundGridDraw = glCreateList(glBeginEnd, GL_LINES, groundGrid)
				else
					loop = 0
					calculateLinePoints(point,points)
					groundGridDraw = glCreateList(glBeginEnd, GL_LINES, groundGrid)
				end
				
				if terraform_type == 1 then
					volumeDraw = glCreateList(glBeginEnd, GL_LINES, lineVolumeLevel)
					mouseGridDraw = glCreateList(glBeginEnd, GL_LINES, mouseGridLevel)
				elseif terraform_type == 2 then
					volumeDraw = glCreateList(glBeginEnd, GL_LINES, lineVolumeRaise)
					mouseGridDraw = glCreateList(glBeginEnd, GL_LINES, mouseGridRaise)
				end
			elseif terraform_type == 3 or terraform_type == 5 then
			
				local disSQ = (point[1].x-point[points].x)^2 + (point[1].z-point[points].z)^2
			
				if disSQ < 6400 and points > 10 then
					loop = 1
					calculateAreaPoints(point,points)
					groundGridDraw = glCreateList(glBeginEnd, GL_LINES, groundGrid)
				else
					loop = 0
					calculateLinePoints(point,points)
					groundGridDraw = glCreateList(glBeginEnd, GL_LINES, groundGrid)
				end
				if points ~= 0 then
					SendCommand()
				end
				volumeSelection = 0
				drawingLasso = false
				drawingRectangle = false
				setHeight = false
				volumeDraw = false
				groundGridDraw = false
				mouseGridDraw = false
				points = 0
			end
			
			return true
		elseif button == 4 or button == 5 then
			drawingLasso = false
			drawingRectangle = false
			setHeight = false
			volumeDraw = false
			groundGridDraw = false
			mouseGridDraw = false
			volumeSelection = 0
			points = 0
		else
			return true
		end
	elseif drawingRectangle then
	
		if button == 1 then
			--spSetActiveCommand(-1)
			
			if terraform_type == 1 or terraform_type == 2 then
				setHeight = true
				drawingRectangle = false
				mouseX = mx
				mouseY = my
				
				local x,z
				
				local _, pos = spTraceScreenRay(mx, my, true)
				if pos then
					
					if mouseUnit.id and point[1].x == point[2].x and point[1].z == point[2].z then
						local ty, id = spTraceScreenRay(mx, my, false)
						if ty == "unit" and id == mouseUnit.id then
							
							local x,_,z = spGetUnitPosition(mouseUnit.id)
							local face = spGetUnitBuildFacing(mouseUnit.id)
							
							local xsize,ysize
							if (face == 0) or (face == 2) then
								xsize = mouseUnit.ud.xsize*4
								ysize = (mouseUnit.ud.zsize or mouseUnit.ud.ysize)*4
							else
								xsize = (mouseUnit.ud.zsize or mouseUnit.ud.ysize)*4
								ysize = mouseUnit.ud.xsize*4
							end
								
							points = 5
							point[1] = {x = x - xsize - 16, z = z - ysize - 16}
							point[2] = {x = x + xsize + 16, z = point[1].z}
							point[3] = {x = point[2].x, z = z + ysize + 16}
							point[4] = {x = point[1].x, z = point[3].z}
							point[5] = {x =point[1].x, z = point[1].z}
							
							loop = 0
							calculateLinePoints(point,points)
							groundGridDraw = glCreateList(glBeginEnd, GL_LINES, groundGrid)
							
							if terraform_type == 1 then
								volumeDraw = glCreateList(glBeginEnd, GL_LINES, lineVolumeLevel)
								mouseGridDraw = glCreateList(glBeginEnd, GL_LINES, mouseGridLevel)
							elseif terraform_type == 2 then
								volumeDraw = glCreateList(glBeginEnd, GL_LINES, lineVolumeRaise)
								mouseGridDraw = glCreateList(glBeginEnd, GL_LINES, mouseGridRaise)
							end
							
							mouseUnit.id = false
							return true
						end
						
					end
					
					x = floor((pos[1])/16)*16
					z = floor((pos[3])/16)*16
						
					if x - point[1].x == 0 then
						x = x - 16
					end
					if z - point[1].z == 0 then
						z = z - 16
					end
				else
					x = point[2].x
					z = point[2].z
				end	
				
				points = 5
				point[2] = {x = point[1].x, z = z}
				point[3] = {x = x, z = z}
				point[4] = {x = x, z = point[1].z}
				point[5] = {x = point[1].x, z = point[1].z}
				local a,c,m,s = spGetModKeyState()
					
				if c then
					loop = 0
					calculateLinePoints(point,points)
				else
					loop = 1
					calculateAreaPoints(point,points)
				end
				groundGridDraw = glCreateList(glBeginEnd, GL_LINES, groundGrid)
				
				if terraform_type == 1 then
					volumeDraw = glCreateList(glBeginEnd, GL_LINES, lineVolumeLevel)
					mouseGridDraw = glCreateList(glBeginEnd, GL_LINES, mouseGridLevel)
				elseif terraform_type == 2 then
					volumeDraw = glCreateList(glBeginEnd, GL_LINES, lineVolumeRaise)
					mouseGridDraw = glCreateList(glBeginEnd, GL_LINES, mouseGridRaise)
				end
				
			elseif terraform_type == 3 or terraform_type == 5 then
			
				local _, pos = spTraceScreenRay(mx, my, true)
				local x,z
				if pos then
				
					if mouseUnit.id and point[1].x == point[2].x and point[1].z == point[2].z then
						local ty, id = spTraceScreenRay(mx, my, false)
						if ty == "unit" and id == mouseUnit.id then
							
							local x,_,z = spGetUnitPosition(mouseUnit.id)
							local face = spGetUnitBuildFacing(mouseUnit.id)
							
							local xsize,ysize
							if (face == 0) or (face == 2) then
								xsize = mouseUnit.ud.xsize*4
								ysize = (mouseUnit.ud.zsize or mouseUnit.ud.ysize)*4
							else
								xsize = (mouseUnit.ud.zsize or mouseUnit.ud.ysize)*4
								ysize = mouseUnit.ud.xsize*4
							end
							
							points = 5
							point[1] = {x = x - xsize - 16, z = z - ysize - 16}
							point[2] = {x = x + xsize + 16, z = point[1].z}
							point[3] = {x = point[2].x, z = z + ysize + 16}
							point[4] = {x = point[1].x, z = point[3].z}
							point[5] = {x =point[1].x, z = point[1].z}			
							
							SendCommand()
							drawingLasso = false
							drawingRectangle = false
							setHeight = false
							volumeDraw = false
							groundGridDraw = false
							mouseGridDraw = false
							mouseUnit.id = false
							points = 0
							return true
						end
					end
				
					x = floor((pos[1])/16)*16
					z = floor((pos[3])/16)*16
					
					if x - point[1].x == 0 then
						x = x - 16
					end
					if z - point[1].z == 0 then
						z = z - 16
					end
				else
					x = point[2].x
					z = point[2].z
				end
						
				points = 5
				point[2] = {x = point[1].x, z = z}
				point[3] = {x = x, z = z}
				point[4] = {x = x, z = point[1].z}
				point[5] = {x = point[1].x, z = point[1].z}
				
				local a,c,m,s = spGetModKeyState()
				if c then
					loop = 0
					calculateLinePoints(point,points)
				else
					loop = 1
					calculateAreaPoints(point,points)
				end

				if points ~= 0 then
					SendCommand()
				end
				drawingLasso = false
				drawingRectangle = false
				setHeight = false
				volumeDraw = false
				groundGridDraw = false
				mouseGridDraw = false
				points = 0
				
			end
			
			return true
		elseif button == 4 or button == 5 then
			drawingLasso = false
			drawingRectangle = false
			setHeight = false
			volumeDraw = false
			groundGridDraw = false
			mouseGridDraw = false
			volumeSelection = 0
			points = 0
		else
			return true
		end
	
	elseif drawingRamp == 1 then
	
		if button == 1 then
			mouseX = mx
			mouseY = my
			--spSetActiveCommand(-1)
			drawingRamp = 2
			return true
		elseif button == 4 or button == 5 then
			drawingRamp = false
			points = 0
		else
			return true
		end
	
	elseif drawingRamp == 3 then
	
		if button == 1 then
			mouseX = mx
			mouseY = my
			setHeight = true
			drawingRamp = false
			return true
		elseif button == 4 or button == 5 then
			drawingRamp = false
			points = 0
		else
			return true
		end
	
	end
	return false
end

local keyCtrl = 306 

function widget:KeyRelease(key)
	if key == keyCtrl and drawingLasso then
		local mx,my = Spring.GetMouseState()
		local _, pos = spTraceScreenRay(mx, my, true)
		if pos then
				
			local diffX = abs(point[points].x - pos[1])
			local diffZ = abs(point[points].z - pos[3])
				
			if diffX >= 10 or diffZ >= 10 then
				points = points + 1
				point[points] = {x = pos[1], y = pos[2], z = pos[3]}
			end
		end
		return true
	end
end

function widget:KeyRelease(key)

	if ((key == KEYSYMS.LCTRL) or (key == KEYSYMS.RCTRL)) and drawingLasso then
		local mx,my = Spring.GetMouseState()
		local _, pos = spTraceScreenRay(mx, my, true)
		if pos then
				
			local diffX = abs(point[points].x - pos[1])
			local diffZ = abs(point[points].z - pos[3])
				
			if diffX >= 10 or diffZ >= 10 then
				points = points + 1
				point[points] = {x = pos[1], y = pos[2], z = pos[3]}
			end
		end
		return true
	end
end

function widget:KeyPress(key)

	if key == KEYSYMS.SPACE and ( 
		(terraform_type == 1 and (setHeight or drawingLasso)) or 
		(terraform_type == 4 and (setHeight or drawingRamp)) or 
		(terraform_type == 5 and drawingLasso)
	) then
		volumeSelection = volumeSelection+1
		if volumeSelection > 2 then
			volumeSelection = 0
		end
		return true
	end
end

--------------------------------------------------------------------------------
-- Drawing
--------------------------------------------------------------------------------

local function DrawLine()
	for i = 1, points do
		glVertex(point[i].x,point[i].y,point[i].z)
	end
	
	local mx,my = Spring.GetMouseState()
	local _, pos = spTraceScreenRay(mx, my, true)
	if pos then
		glVertex(pos[1],pos[2],pos[3])
	end
	
end

local function DrawRectangleLine()

	glVertex(point[3].x,point[1].y,point[3].z)
	glVertex(point[3].x,point[1].y,point[2].z)
	glVertex(point[2].x,point[1].y,point[2].z)
	glVertex(point[2].x,point[1].y,point[3].z)
	glVertex(point[3].x,point[1].y,point[3].z)
	
end

local function DrawRampFirstSetHeight(dis)
	
	glVertex(point[1].x,point[1].y,point[1].z)
	glVertex(point[1].x,point[1].ground,point[1].z)
	
end

local function DrawRampStart(dis)

	local perpendicular = {x = terraformHeight*(point[1].z-point[2].z)/dis, z = -terraformHeight*(point[1].x-point[2].x)/dis}
	
	glVertex(point[1].x+perpendicular.x,point[1].y,point[1].z+perpendicular.z)
	glVertex(point[1].x+perpendicular.x,point[1].ground,point[1].z+perpendicular.z)
	glVertex(point[1].x-perpendicular.x,point[1].ground,point[1].z-perpendicular.z)
	glVertex(point[1].x-perpendicular.x,point[1].y,point[1].z-perpendicular.z)
	
end

local function DrawRampMiddleEnd(dis)
	
	local perpendicular = {x = terraformHeight*(point[1].z-point[2].z)/dis, z = -terraformHeight*(point[1].x-point[2].x)/dis}
	
	glVertex(point[2].x-perpendicular.x,point[2].y,point[2].z-perpendicular.z)
	glVertex(point[1].x-perpendicular.x,point[1].y,point[1].z-perpendicular.z)
	glVertex(point[1].x+perpendicular.x,point[1].y,point[1].z+perpendicular.z)
	glVertex(point[2].x+perpendicular.x,point[2].y,point[2].z+perpendicular.z)
	glVertex(point[2].x-perpendicular.x,point[2].y,point[2].z-perpendicular.z)
	glVertex(point[2].x-perpendicular.x,point[2].ground,point[2].z-perpendicular.z)
	glVertex(point[2].x+perpendicular.x,point[2].ground,point[2].z+perpendicular.z)
	glVertex(point[2].x+perpendicular.x,point[2].y,point[2].z+perpendicular.z)
	
end

local function drawMouseText(y,text)

	local mx,my = Spring.GetMouseState()
	glText(text, mx+40, my+y, 22,"")

end


function widget:DrawWorld()
	
	if not (drawingLasso or setHeight or drawingRectangle or drawingRamp) then
		widgetHandler:RemoveWidgetCallIn("DrawWorld", self)
		return
	end
	
	--// draw the lines
	--glLineStipple(2, 4095)
	glLineWidth(3.0)
	
	if terraform_type == 4 then
	
		local dis = sqrt((point[1].x-point[2].x)^2 + (point[1].z-point[2].z)^2)
		
		if dis == 0 then
			glColor(vehPathingColor)
			glBeginEnd(GL_LINES, DrawRampFirstSetHeight)
		else
			local grad = abs(point[1].y-point[2].y)/dis
			if grad <= vehPathingGrad then
				glColor(vehPathingColor)
			elseif grad <= botPathingGrad then
				glColor(botPathingColor)
			else
			   glColor(noPathingColor)
			end
			glBeginEnd(GL_LINE_STRIP, DrawRampStart, dis)
			glBeginEnd(GL_LINE_STRIP, DrawRampMiddleEnd, dis)
		end
	
	else
	
		if setHeight then	
			--glDepthTest(true)
			glCallList(groundGridDraw)
			glCallList(volumeDraw)
			glCallList(mouseGridDraw)
			
			--glDepthTest(false)
		elseif drawingLasso then
			glColor(lassoColor)
			glBeginEnd(GL_LINE_STRIP, DrawLine)
		elseif drawingRectangle then
			glColor(lassoColor)
			glBeginEnd(GL_LINE_STRIP, DrawRectangleLine)
		end
		
	end

	glColor(1, 1, 1, 1)
	glLineWidth(1.0)
	--glLineStipple(false)
end

function widget:DrawScreen()

	if terraform_type == 1 or terraform_type == 2 then
		if setHeight then
			drawMouseText(0,floor(terraformHeight))
		end
	elseif terraform_type == 4 then
		if drawingRamp == 1 then
			drawMouseText(0,floor(point[1].y))
		elseif drawingRamp == 3 then
			if point[2].y == 0 then
				drawMouseText(0,point[2].y .. " Water Level")
			elseif point[2].y == point[1].y then
				drawMouseText(0,floor(point[2].y) .. " Flat")
			else
				drawMouseText(0,floor(point[2].y))
			end
		end
	end
	
	if terraform_type == 1 or terraform_type == 4  or terraform_type == 5 then
		if volumeSelection == 1 then
			drawMouseText(-30,"Only raise")
		elseif volumeSelection == 2 then
			drawMouseText(-30,"Only lower")
		end
	end

end