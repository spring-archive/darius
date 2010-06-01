--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Chili Gesture Menu",
    desc      = "Hold right mouse + move or press B to use",
    author    = "Licho",
    date      = "2009-not as hot as before",
    license   = "GNU GPL, v2 or later",
    layer     = 100000,
    enabled   = true,
    handler = true,
  }
end 

include("keysym.h.lua")
-------------------------------------------------
------ SPEEDUPS
-------------------------------------------------
local osclock	= os.clock

local GL_LINE_STRIP		= GL.LINE_STRIP
local glVertex			= gl.Vertex
local glLineStipple 	= gl.LineStipple
local glLineWidth   	= gl.LineWidth
local glColor       	= gl.Color
local glBeginEnd    	= gl.BeginEnd
local glPushMatrix		= gl.PushMatrix
local glPopMatrix		= gl.PopMatrix
local glScale			= gl.Scale
local glTranslate		= gl.Translate
local glRect = gl.Rect
local glLoadIdentity	= gl.LoadIdentity
local tinsert = table.insert

local spEcho				= Spring.Echo

------------------------------------------------
-- constst


local CMD_BUILD_STRUCTURE = 10010
local ANGLE_TOLERANCE = 22.5

local MINDIST = 50
local BIG_ICON_SIZE = 32
local MOVE_THRESHOLD_SQUARED = 900
local IDLE_THRESHOLD = 0.5 -- after this seconds menu shows if you hold right mouse still
local SMALL_ICON_SIZE = 20
local KEYBOARD_ONLY = false 

local function OptionsChanged() 
	MINDIST = options.iconDistance.value
	SMALL_ICON_SIZE = options.iconSize.value
	BIG_ICON_SIZE = options.selectedIconSize.value
	MOVE_THRESHOLD_SQUARED = options.mouseMoveThreshold.value
	IDLE_THRESHOLD = options.mouseIdleThreshold.value
	KEYBOARD_ONLY = options.keyboardOnly.value
end 


options_section = 'Interface'
options = {
	order = { 'iconDistance', 'iconSize', 'selectedIconSize', 'mouseMoveThreshold', 'mouseIdleThreshold', 'keyboardOnly'},
	
	iconDistance = {
		name = "Icon distance (20-150)",
		type = 'number',
		value = 50,
		min=20,max=150,step=1,
		OnChange = OptionsChanged,
	},
	
	iconSize = {
		name = "Icon size (10-100)",
		type = 'number',
		value = 20,
		min=10,max=100,step=1,
		OnChange = OptionsChanged,		
	},	
	
	selectedIconSize = {
		name = "Selected icon size (10-100)",
		type = 'number',
		value = 32,
		min=10,max=100,step=1,
		OnChange = OptionsChanged,		
	},	
	
	mouseMoveThreshold = {
		name = "Mouse move threshold (10-2000)",
		type = 'number',
		value = 900,
		min=10,max=1000,step=1,
		desc = "When you hold right button, you must move this distance(squared) to show menu",
		OnChange = OptionsChanged,		
	},	
	
	mouseIdleThreshold = {
		name = "Mouse idle threshold (0.1-3s)",
		type = 'number',
		value = 0.5,
		min=0.1,max=3,step=0.1,
		desc = "When you hold right button still, menu appears after this time(s)",
		OnChange = OptionsChanged,		
	},	
	
	keyboardOnly = {
		name = 'Keyboard only',
		type = 'bool',
		value = false,
		desc = 'Disables  esture recognition',
		OnChange = OptionsChanged,
	}
}





local mapWidth, mapHeight = Game.mapSizeX, Game.mapSizeZ

------------------------------------------------

local average_difference = 0 -- average movement speed/difference
local ignored_angle = nil -- angle to currently ignore in menu

local origin = nil
local selected_item = nil

local menu = nil -- nil indicates no menu is visible atm
local menu_selected = nil -- currently selected item - used in last level menus where you can select without changing origin
local menu_invisible = false  -- indicates if menu should be active but invisible (for right hold click)
local menu_start = 0 -- time when the menu was started

local menu_keymode = false -- was menu opened using keyboard


-- remember the walk through the menu, to be able to go back
local level = 0
local levels = {}

local move_digested = nil -- was move command digested (hold right click detection)

local customKeyBind = false

local menu_corcom = include("Configs/marking_menu_menu_corcom.lua")
local menu_armcom = include("Configs/marking_menu_menu_armcom.lua")

local menu_armcsa = include("Configs/marking_menu_menu_armcsa.lua")
local menu_corcsa = include("Configs/marking_menu_menu_corcsa.lua")

local menu_armnano = include("Configs/marking_menu_menu_armnano.lua")
local menu_cornano = include("Configs/marking_menu_menu_cornano.lua")


local menu_use = {
  armbeaver = menu_armcom,
  armca = menu_armcom,
  armch = menu_armcom,
  armcombattle2 = menu_armcom,
  armcombuild2 = menu_armcom,
  armcomdgun2 = menu_armcom,
  armcomdgun = menu_armcom,
  armcom = menu_armcom,
  armcs = menu_armcom,
  armdecom = menu_armcom,
  armrectr = menu_armcom,
  arm_spider = menu_armcom,
  consul = menu_armcom,
  pioneer = menu_armcom,

  armnanotc = menu_armnano,

  armcsa = menu_armcsa,
  
  corcom = menu_corcom,
  coracv =menu_corcom,
  corca = menu_corcom,
  corch = menu_corcom,
  corcombattle2 = menu_corcom,
  corcombuild2 = menu_corcom,
  corcomdgun2 = menu_corcom,
  corcomdgun = menu_corcom,
  corcs = menu_corcom,
  cordecom = menu_corcom,
  corfast = menu_corcom,
  cornecro = menu_corcom,
  corned = menu_corcom,
  pinchy = menu_corcom,
  
  cornanotc = menu_cornano,
  
  corcsa = menu_corcsa,

}

local keys = {
	[KEYSYMS.W] = '0',
	[KEYSYMS.E] = '45',
	[KEYSYMS.D] = '90',
	[KEYSYMS.C] = '135',
	[KEYSYMS.X] = '180',
	[KEYSYMS.Z] = '225',
	[KEYSYMS.Y] = '225', -- support qwertz keyboards
	[KEYSYMS.A] = '270',
	[KEYSYMS.Q] = '315',
}

local keys_display = {
	'W',
	'E',
	'D',
	'C',
	'X',
	'Z',
	'A',
	'Q',
}


local function GetAngle(x1,y1,x2,y2) 
  return 180 * math.atan2(x1-x2,y1-y2) / math.pi
end

local function GetPos(x1,y1,angle,dist) 
  local a = angle * math.pi/180
  return x1 + math.sin(a) * dist, y1 + math.cos(a)*dist
end

local function GetDist(x1,y1,x2,y2)
  local dx = x2 - x1
  local dy = y2 - y1
  return math.sqrt(dx*dx+dy*dy)
end

local function AngleDifference(a1,a2) 
  return math.abs((a1 + 180 - a2) % 360 - 180)
end 



function widget:Update(t)
  if not menu or KEYBOARD_ONLY then return end 
  local mx, my = Spring.GetMouseState()
  ProcessMove(mx,my)
  if hold_pos then 
    local dx = mx - hold_pos[1]
    local dy = my - hold_pos[2]
    if dx*dx + dy*dy > MOVE_THRESHOLD_SQUARED  or os.clock() - menu_start > IDLE_THRESHOLD then 
      menu_invisible = false 
      hold_pos = nil
    end 
  end 
end

local lx = 0
local ly = 0


function ProcessMove(x,y) 
  if (menu ==nil or KEYBOARD_ONLY) then return end 
  local dx = x - lx 
  local dy = y - ly
  diff =  math.sqrt(dx*dx + dy*dy)
  lx = x 
  ly = y 

  
  if diff < average_difference * 0.5 then  -- we are slowed down, this is a spot where we check stuff in detail
    
    local angle = GetAngle(x,y, origin[1],origin[2])
    local dist = GetDist(x,y,origin[1],origin[2])
    if (ignored_angle == nil or AngleDifference(angle,ignored_angle) > ANGLE_TOLERANCE) and  dist > MINDIST then
      local item = nil
      if (menu.items) then 
        for _,i in ipairs(menu.items) do 
          if (AngleDifference(i.angle,angle) < ANGLE_TOLERANCE) then 
            item = i
            break
          end 
        end 
      end
      if (item == nil) then  -- "back" in menu
        if level > 0 then 
          local l_menu, l_angle = unpack(levels[level])
          if (AngleDifference(l_angle, angle)< ANGLE_TOLERANCE) then 
            levels[level] = nil
            level = level - 1 
            menu = l_menu
            menu_selected = menu
            
            if level > 0 then  --  incorrect angle is angle of previous level (to which we are going). If there is none we are in initial state and all angles are valid
              ignored_angle = levels[level][2]  + 180
            else 
              ignored_angle = nil
            end 
            origin = {x,y}
          end 
        end 
      end 
      if (item ~= nil) then
        
        if (item.items ~= nil)  then -- item has subitems 
          
          level = level + 1  -- save level
          levels[level] = {menu, item.angle+180}

          ignored_angle = item.angle
          menu = item
          menu_selected = item
        
          origin = {x,y}
        else 
          
          if (dist > MINDIST + 2*BIG_ICON_SIZE) then 
            local nx,ny = GetPos(x,y, item.angle - 180, MINDIST)
            origin  = {nx,ny}
          end 
          menu_selected = item
        end 
      else 
        -- spEcho("no item"..angle) FIXME?
      end 
    else
      if (dist < MINDIST) then 
        menu_selected = menu
      elseif diff > 0 then -- we moved and slowed a bit, so move menu to new position
        origin = {x,y}
      end
    end 
  end
  average_difference = average_difference*0.8+  0.2*diff -- geometric averaging
end 



-- setups menu for selected unit
function SetupMenu(keyboard) 
  if (keyboard) then menu_keymode = true else menu_keymode = false end
  local units = Spring.GetSelectedUnits()

  -- only show menu if a unit is selected
  if units and #units > 0 then 
    origin = {Spring.GetMouseState()} -- origin might by set by mouse hold detection so we only set it if unset
    
    local ud = nil
    local found = false
    for _, unitID in ipairs(units) do 
      ud = UnitDefs[Spring.GetUnitDefID(unitID)]
      if ud.builder and menu_use[ud.name] then 
        found = true
        break
      end
    end 

    -- setup menu depending on selected unit
    if found then 
      levels = {}
      level =0
      menu_flash = nil -- erase previous flashing
      menu = menu_use[ud.name]
      menu_selected = menu
      menu_start = os.clock()
    else
      menu = nil
      menu_selected=  nil
      return false
    end

    return true
  end
end 


function EndMenu(ok)
  if (not ok) then 
		menu_selected = nil
   end
 
  if menu_selected~=nil and menu_selected.unit ~= nil then 
    local cmdid = menu_selected.cmd
	if (cmdid == nil) then 
		local ud = UnitDefNames[menu_selected.unit]
		if (ud ~= nil) then
			cmdid = Spring.GetCmdDescIndex(-ud.id)
		end
	end 
	
    if (cmdid) then
      local alt, ctrl, meta, shift = Spring.GetModKeyState()
      local _, _, left, _, right = Spring.GetMouseState()
        
      if (menu ~= menu_selected) then -- store last item and level to render its back path
        level = level + 1  -- save level
        levels[level] = {menu_selected, menu_selected.angle+180}
      end 
      if os.clock() - menu_start > level * 0.25 then  -- if speed was slower than 250ms per level, flash the gesture
        menu_flash = {origin[1], origin[2], os.clock()}  
      end 
      Spring.SetActiveCommand(cmdid, _, left, right, alt, ctrl, meta, shift)  -- FIXME set only when you close menu
    end
  end 
  origin = nil
  menu = nil
  menu_selected = nil
  ignored_angle = nil
  hold_pos = nil
  menu_invisible = false 
  menu_keymode = false
end


function widget:CommandNotify(cmdID, cmdParams, cmdOptions)
  if cmdID ~= CMD_BUILD_STRUCTURE then return end 
  if menu == nil then 
    return SetupMenu(true)
  else 
    EndMenu(false)
    return true
  end 
end



function widget:KeyPress(k)
	if (menu) then 
		if k == KEYSYMS.ESCAPE then  -- cancel menu
			Spring.Echo (" ending menu")
			EndMenu(false)
			return true 
		end 
		local angle = keys[k]
		if angle == nil then return end 
		menu_invisible = false -- if menu was activated with mouse but isnt visible yet,show it now
		if (menu.items) then 
			local item = nil
		
			for _,i in ipairs(menu.items) do 
				if (AngleDifference(i.angle,angle) < ANGLE_TOLERANCE) then 
					item = i
					break
				end 
			end 
			
			if item ~= nil then 
				if (item.items ~= nil)  then -- item has subitems 
					level = level + 1  -- save level
					levels[level] = {menu, item.angle+180}

					ignored_angle = item.angle
					menu = item
					menu_selected = item
				else 
					menu_selected = item 
					EndMenu(true)
				end 
			else
				if (AngleDifference(menu.angle, angle) < ANGLE_TOLERANCE) then  -- we selected "same" item  - like mex = "w,w" - end selection
					menu_selected = menu
					EndMenu(true)
				elseif (level > 0) then  -- we are moving back possibly
					local l_menu, l_angle = unpack(levels[level])
					if (AngleDifference(l_angle, angle)< ANGLE_TOLERANCE) then 
						levels[level] = nil
						level = level - 1 
						menu = l_menu
						menu_selected = menu
            
						if level > 0 then  --  incorrect angle is angle of previous level (to which we are going). If there is none we are in initial state and all angles are valid
							ignored_angle = levels[level][2]  + 180
						else 
							ignored_angle = nil
						end 
					end 
				end
			end 
			return true
		end
	end 
end


function widget:MousePress(x,y,button)
	if menu then
		if (button == 3) then
			EndMenu(false) -- cancel after keyboard menu open
		elseif (button == 1 and menu_keymode) then  -- selection with lmb from keyboard menu
			ProcessMove(Spring.GetMouseState())
			EndMenu(true) 
			return true
		end
	elseif (menu == nil) then 
		if (button == 3) then
			local activeCmdIndex, activeid = Spring.GetActiveCommand()
			local _, defid = Spring.GetDefaultCommand()
			if ((activeid == nil or activeid < 0) and defid == CMD.MOVE) then 
				if SetupMenu() then 
					menu_invisible = true 
					move_digested = true 
					hold_pos = {x,y} 
					return true
				end 
			end 
		end 
	end 
	return false
end


local function MinimapMouseToWorld(mx, my)
	
	local _, posy, sizex, sizey = Spring.GetMiniMapGeometry()
	local rx, ry
	
	if dualMinimapOnLeft then
		rx, ry = (mx + sizex) / sizex, (my - posy) / sizey
	else
		rx, ry = mx / sizex, (my - posy) / sizey
	end
	
	if (rx >= 0) and (rx <= 1) and
	   (ry >= 0) and (ry <= 1) then
		
		local mapx, mapz = mapWidth * rx, mapHeight * (1 - ry)
		
		return {mapx, Spring.GetGroundHeight(mapx, mapz), mapz}
	else
		return nil
	end
end


function widget:MouseRelease(x,y,button)
	if button ~= 3 then return end 
	if move_digested and (menu_invisible) then  -- we digested command, but menu not displayed, issue standard move command 
	
		local activeCmdIndex, activeid = Spring.GetActiveCommand()
		if (activeid ~= nil and activeid < 0) then  -- we already had unit selected and menu wasnt visible - cancel previous unit selection
			Spring.SetActiveCommand(0) 
		else 
			inMinimap = Spring.IsAboveMiniMap(x, y)
			local pos
	
			if inMinimap then
				pos = MinimapMouseToWorld(x, y)
			else
				_, pos = Spring.TraceScreenRay(x, y, true)
			end
    
			local alt, ctrl, meta, shift = Spring.GetModKeyState()
			local keyState = {}
			if alt   then tinsert(keyState, "alt") end
			if ctrl  then tinsert(keyState, "ctrl") end
			if meta  then tinsert(keyState, "meta") end
			if shift then tinsert(keyState, "shift") end
    
			if meta and WG.CommandInsert then 
				WG.CommandInsert(CMD.MOVE,pos,keyState)
			else 
				Spring.GiveOrder(CMD.MOVE, pos, keyState)
			end 
		end 
	end 
	ProcessMove(Spring.GetMouseState())
	hold_pos = nil
	EndMenu(true)
end 



function widget:IsAbove(x,y) 
  if (menu ~= nil) then return true 
  else return false end 
end 


function widget:GetTooltip(x, y)
  if menu_selected ~= nil and menu_selected.unit ~= nil then 
    local ud = UnitDefNames[menu_selected.unit]
    if (ud) then 
      return 'Build: ' ..ud.humanName .. ' - ' .. ud.tooltip  
    end 
  end 
end





local function BackPathFunc(origin, len)
  local sx,sy = unpack(origin)
  glVertex(sx,sy)
  for i=level,1,-1 do
    local menu,angle = unpack(levels[i])
    sx,sy= GetPos(sx,sy, angle, len)
    glVertex(sx,sy)
  end
end 


local function DrawMenuItem(item, x,y, size, alpha, displayLabel, angle)
  if not alpha then alpha = 1 end 
  if displayLabel == nil then displayLabel = true end
  if item then 
    local ud = UnitDefNames[item.unit]
    if (ud)  then
      if (displayLabel and item.label) then 
        glColor(0,1,1,alpha)
        local wid = gl.GetTextWidth(item.label)*12
        gl.Text(item.label,x-wid*0.5, y+size,12,"")
      end 

      glColor(1*alpha,1*alpha,1,alpha)
      gl.Texture(WG.GetBuildIconFrame(ud)) 
      gl.TexRect(x-size, y-size, x+size, y+size)
      gl.Texture("#"..ud.id)
      gl.TexRect(x-size, y-size, x+size, y+size)
      gl.Texture(false)


	  if angle then 
		if angle < 0 then angle = angle + 360 end 
		local idx = angle / 45
		gl.Text(keys_display[1 + idx%8],x-size+4,y-size + 4,10,"")
	  end 
    end 
  end 
  
end 



function widget:DrawScreen() 

  if menu_flash then 
    -- render back path
    gl.Texture(false)
    glColor(0,1,1,0.5 + 0.5 * math.sin(os.clock()*30))
    gl.LineWidth(2)
    gl.BeginEnd(GL_LINE_STRIP, BackPathFunc, menu_flash, MINDIST*3)
    
    local sx,sy = unpack(menu_flash)
    for i=level,1,-1 do
      local menu,angle = unpack(levels[i])
      sx,sy= GetPos(sx,sy, angle, MINDIST*3)
    end
    gl.Rect(sx-5,sy-5,sx+5,sy+5)

    if (os.clock() - menu_flash[3]>1) then  -- only flash for 3 seconds
      menu_flash = nil 
    end 
  end 

  if (menu == nil or menu_invisible) then return end  -- get out if menu not visible

  
  -- render back path
  gl.Texture(false)
  glColor(0,1,1,1)
  local sx,sy = unpack(origin)
  gl.BeginEnd(GL_LINE_STRIP, BackPathFunc, origin, MINDIST+SMALL_ICON_SIZE)
  for i=level,1,-1 do
    local menu,angle = unpack(levels[i])
    sx,sy= GetPos(sx,sy, angle, MINDIST+SMALL_ICON_SIZE)
    DrawMenuItem(menu, sx,sy, SMALL_ICON_SIZE, 0.5, true, angle)
    glColor(0,1,1,1)
    gl.Rect(sx-5,sy-5,sx+5,sy+5)
  end

  glColor(0,1,1,1)
  glRect(origin[1]-2,origin[2]-2,origin[1]+2, origin[2] + 2)


  glColor(1,1,1,1)  
  if (menu == menu_selected) then 
    DrawMenuItem(menu, origin[1], origin[2], BIG_ICON_SIZE, 1, false, menu.angle) 
  else 
    DrawMenuItem(menu, origin[1], origin[2], SMALL_ICON_SIZE, 0.8, true, menu.angle) 
  end 
  

  if (menu.items) then 
    for _,i in ipairs(menu.items) do 
      local x,y = GetPos(origin[1], origin[2], i.angle, MINDIST + SMALL_ICON_SIZE)
      
      if (i == menu_selected) then 
        DrawMenuItem(i, x,y, BIG_ICON_SIZE, 1, true, i.angle)
      else 
        DrawMenuItem(i, x,y, SMALL_ICON_SIZE, 0.8, true, i.angle)
      end 
    end 
  end 

end


function widget:Initialize()

  -- check for custom key bind
  local hotkeys = Spring.GetActionHotKeys("markingmenu")
  if hotkeys == nil then
  else
    if #hotkeys > 0 then
      customKeyBind = true
    end
  end

  -- adding functions because of "handler=true"
  widgetHandler.AddAction    = function (_, cmd, func, data, types)
    return widgetHandler.actionHandler:AddAction(widget, cmd, func, data, types)
  end
  widgetHandler.RemoveAction = function (_, cmd, types)
    return widgetHandler.actionHandler:RemoveAction(widget, cmd, types)
  end

  widgetHandler:AddAction("markingmenu", ActionMenu, nil, "t")
  if not customKeyBind then
    Spring.SendCommands("bind any+b markingmenu")
  end

end 

function widget:Shutdown()
  if not customKeyBind then
    Spring.SendCommands("unbind b markingmenu")
  end
  widgetHandler:RemoveAction("markingmenu")
end

function ActionMenu()
  if menu == nil then 
    local _ , activeid = Spring.GetActiveCommand()
    if (activeid == nil or activeid < 0) then 
      return SetupMenu(true)
    end 
  else 
    EndMenu(false)
  end
end

function widget:CommandsChanged()
	local selectedUnits = Spring.GetSelectedUnits()
	local customCommands = widgetHandler.customCommands
	local foundBuilder = false
    
  for _, unitID in ipairs(selectedUnits) do
		local unitDefID = Spring.GetUnitDefID(unitID)
			
    if UnitDefs[unitDefID].builder then 
      foundBuilder = true 
      break
    end 
  end 

  if foundBuilder then 
    table.insert(customCommands, {			
      id      = 0,
      type    = CMDTYPE.ICON,
      tooltip = 'Hold \255\10\240\240RIGHT MOUSE \255\255\255\255 + gesture or press \255\10\240\240B',
      name = "Build",
      cursor  = 'Build',
      action  = '',
      params  = { }, 
      pos = {CMD_CLOAK,CMD_ONOFF,CMD_REPEAT,CMD_MOVE_STATE,CMD_FIRE_STATE}, 
    })
  end 

end
