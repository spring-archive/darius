function widget:GetInfo()
  return {
    name      = "Darius Minimap",
    desc      = "Replaces the original minimap",
    author    = "malloc (Based on Chili Minimap by Licho)",
    date      = "July 2010",
    license   = "GNU GPL, v2 or later",
    layer     = 50,
    enabled   = false
  }
end


--------------
-- Speed Up --
--------------

local spEcho = Spring.Echo



----------------
-- Local Vars --
----------------

-- the minimap UI element
local windowMinimap



---------------------
-- Local functions --
---------------------

local function AdjustToMapAspectRatio(width, height)
	if (Game.mapX > Game.mapY) then
		return width, width * Game.mapY / Game.mapX
	end
	
	return height * Game.mapX / Game.mapY, height
end



--------------
-- Call-ins --
--------------

function widget:Initialize()
	-- minimap doesn't work with DualScreen (a Spring limitation?)
	if (Spring.GetMiniMapDualScreen()) then
		Spring.Echo("Minimap disabled automatically because DualScreen is enabled.")
		widgetHandler:RemoveWidget()
		return
	end
	
	-- if chili is not loaded, disable this widget
	if not WG.Chili then
		widgetHandler:RemoveWidget()
		return
	end

	-- chili components needed
	Chili = WG.Chili
	Window = Chili.Window
	Screen0 = Chili.Screen0

	-- set initial size
	local defaultWidth, defaultHeight = AdjustToMapAspectRatio(250, 250)

	-- create a window for minimap
	windowMinimap = Window:New {  
		name = "minimap",
		x = 10,  
		y = 10,
		width  = defaultWidth,
		height = defaultHeight,
		parent = Screen0,
		draggable = true,
		dragUseGrip = true,
		resizable = true,
		dockable = true,
		fixedRatio = true,
		minimumSize = {200, 200}
	}
	
	-- hide the original minimap
	gl.SlaveMiniMap(true)
	
	spEcho("Darius minimap enabled")
end


function widget:Shutdown()
	-- restore the original minimap
	gl.SlaveMiniMap(false)
	Spring.SendCommands("minimap geo " .. Spring.GetConfigString("MiniMapGeometry"))
	
	-- delete the window
	if (windowMinimap) then
		Screen0:RemoveChild(windowMinimap) -- remove the window
		windowMinimap:Dispose()
		WindowMinimap = nil
	end
	
	spEcho("Darius minimap disabled")
end 


function widget:DrawScreen()
	-- calculate minimap size
	local _, _, mapElemWidth, mapElemHeight = Chili.unpack4(windowMinimap.clientArea)
	local _, viewSizeY = gl.GetViewSizes()
	
	-- set minimap element position inside the ui element
	local mapElemXPos, mapElemYPos = windowMinimap:LocalToScreen(15, 9) -- frame margins hardcoded
	gl.ConfigMiniMap(mapElemXPos, viewSizeY - mapElemHeight - mapElemYPos, mapElemWidth - 5, mapElemHeight)

	-- the actual drawing related stuff
	gl.DrawMiniMap()
end 
