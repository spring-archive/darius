function widget:GetInfo()
  return {
    name      = "Darius Minimap",
    desc      = "Displays the minimap (replaces the original)",
    author    = "malloc (Based on Chili Minimap by Licho)",
    date      = "28th July 2010",
    license   = "GNU GPL, v2 or later",
    layer     = 50,
    enabled   = true
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

-- default size
local defaultWidth, defaultHeight = 200, 200



---------------------
-- Local functions --
---------------------

-- this function resizes the map correctly to fit into the minimap frame
local function AdjustMapToFrame(width, height)
	if (Game.mapX > Game.mapY) then
		return width, width*Game.mapY/Game.mapX
	end

	return height*Game.mapX/Game.mapY, height
end



--------------
-- Call-ins --
--------------

function widget:Initialize()
	-- minimap doesn't work with DualScreen?
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

	-- adjust map to fit into the frame
	defaultWidth, defaultHeight = AdjustMapToFrame(defaultWidth, defaultHeight)

	-- default position is in the lower-left corner
	local _, defaultPosY = gl.GetViewSizes()
	defaultPosY = defaultPosY - defaultHeight

	-- create a window for minimap
	windowMinimap = Window:New {
		name = "minimap",
		x = 0,
		y = defaultPosY,
		width  = defaultWidth,
		height = defaultHeight,
		parent = Screen0,
		draggable = true,
		dragUseGrip = true,
		resizable = true,
		dockable = true,
		fixedRatio = true,
		minimumSize = {defaultWidth, defaultHeight}
	}

	-- hide the original minimap
	gl.SlaveMiniMap(true)

	spEcho("Darius minimap enabled")
end


function widget:Shutdown()
	-- delete the window
	if (windowMinimap) then
		Screen0:RemoveChild(windowMinimap)
		windowMinimap:Dispose()
		WindowMinimap = nil
	end

	spEcho("Darius minimap disabled")
end


function widget:DrawScreen()
	-- calculate minimap size
	local _, _, mapElemWidth, mapElemHeight = Chili.unpack4(windowMinimap.clientArea)
	local _, viewSizeY = gl.GetViewSizes()

	-- set minimap graphics position inside the ui element
	local mapElemXPos, mapElemYPos = windowMinimap:LocalToScreen(15, 9) -- margins hardcoded
	gl.ConfigMiniMap(mapElemXPos, viewSizeY - mapElemHeight - mapElemYPos, mapElemWidth - 5, mapElemHeight)

	-- the actual drawing related stuff
	gl.DrawMiniMap()
end
