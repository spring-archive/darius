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

local settings = {
	pos_x,
	pos_y,
	width,
	height,
}

local defaults = {
	pos_x = 0,
	pos_y = 0,
	width = 200,
	height = 200,
}

local displayMiniMap = true

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

local function AdjustWindow()
	if not (windowMinimap) then return end

	vsx, vsy, _, _ = Spring.GetViewGeometry()
	if (windowMinimap.x < 0) then
		windowMinimap.x = 0
	end
	if (windowMinimap.y < 0) then
		windowMinimap.y = 0
	end
	if (windowMinimap.x > vsx - windowMinimap.width) then
		windowMinimap.x = vsx - windowMinimap.width
	end
	if (windowMinimap.y > vsy - windowMinimap.height) then
		windowMinimap.y = vsy - windowMinimap.height
	end
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

	-- create a window for minimap
	windowMinimap = Window:New {
		name = "minimap",
		x = settings.pos_x or defaults.pos_x,
		y = settings.pos_y or defaults.pos_y,
		width  = settings.width or defaults.width,
		height = settings.height or defaults.height,
		parent = Screen0,
		draggable = true,
		dragUseGrip = true,
		resizable = true,
		dockable = false,
		fixedRatio = true,
		minWidth = 100,
		minHeight = 100,
	}

	-- adjust map to fit into the frame
	windowMinimap.width, windowMinimap.height = AdjustMapToFrame(windowMinimap.width, windowMinimap.height)

	-- hide the original minimap
	gl.SlaveMiniMap(true)

	WG.Darius:RegisterWidget(widget)
end

function widget:Update(...)
	AdjustWindow()
end

-- saves the ui settings
function widget:GetConfigData()
	-- only get the stored settings if the window has been initialized
	if (windowMinimap) then
		settings.pos_x = windowMinimap.x
		settings.pos_y = windowMinimap.y
		settings.width = windowMinimap.width
		settings.height = windowMinimap.height
	end

	return settings
end

-- loads the ui settings
function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		settings = data -- store the settings
	end
end

function widget:Shutdown()
	WG.Darius:RemoveWidget(widget)
	-- delete the window
	if (windowMinimap) then
		Screen0:RemoveChild(windowMinimap)
		windowMinimap:Dispose()
		WindowMinimap = nil
	end
end


function widget:DrawScreen()
	if (displayMiniMap) then
		-- calculate minimap size
		local _, _, mapElemWidth, mapElemHeight = Chili.unpack4(windowMinimap.clientArea)
		local _, viewSizeY = gl.GetViewSizes()

		-- set minimap graphics position inside the ui element
		local mapElemXPos, mapElemYPos = windowMinimap:LocalToScreen(15, 9) -- margins hardcoded
		gl.ConfigMiniMap(mapElemXPos, viewSizeY - mapElemHeight - mapElemYPos, mapElemWidth - 5, mapElemHeight)

		-- the actual drawing related stuff
		gl.DrawMiniMap()
	end
end

-----------------------------
-- Darius Message Handling --
-----------------------------

function widget:RcvMessage(message)
	if (message == "reset") then
		if (windowMinimap) then
			windowMinimap.x = defaults.pos_x
			windowMinimap.y = defaults.pos_y
			windowMinimap.width = defaults.width
			windowMinimap.height = defaults.height
		end
	elseif (message == "show") then
		if (windowMinimap) then Screen0:AddChild(windowMinimap) end
		displayMiniMap = true
	elseif (message == "hide") then
		if (windowMinimap) then Screen0:RemoveChild(windowMinimap) end
		displayMiniMap = false
	end
end
