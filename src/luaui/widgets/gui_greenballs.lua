function widget:GetInfo()
	return {
		name = "Greenballs display",
		desc = "Shows how many greenballs you have",
		author = "Jammer / malloc",
		date = "August 2010",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true
	}
end



--------------
-- Speed Up --
--------------

local spEcho              = Spring.Echo
local spGetSeconds        = Spring.GetGameSeconds
local spGetGameRulesParam = Spring.GetGameRulesParam



-------------------
-- ChiliUI stuff --
-------------------

local VFSMODE  = VFS.RAW_FIRST
local file     = LUAUI_DIRNAME .. "Configs/gui_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color    = confdata.color



----------------
-- Local Vars --
----------------

-- the status panel UI element
local windowGreenballs

-- settings of the status panel
local storedSettings = {
	pos_x,
	pos_y,
	width,
	height
}

-- default size
local defaultWidth, defaultHeight = 120, 50



---------------------
-- Local functions --
---------------------

local function UpdateGreenballUI() 
	lbl_amount:SetCaption(Darius:GetGreenballs())
end


-- This function creates and draws the actual UI element
local function CreateGreenballUI()

	-- if window hasn't been initialized, free the resources associated
	if windowStats then
		windowStats:Dispose()
		windowStats = nil
	end
	
	lbl_amount    = Label:New { x=10, width=60, align="right", textColor = color.game_fg, caption = '', fontSize=30 }
	img_greenball = Image:New { width=25, height=25, file = 'bitmaps/greenball.png' }
	
	windowGreenballs = Window:New {  
		name = "greenballs",
		x = storedSettings.pos_x or 250,
		y = storedSettings.pos_y or 0,
		clientWidth = storedSettings.width or defaultWidth,
		clientHeight = storedSettings.height or defaultHeight,
		minimumSize = {defaultWidth, defaultHeight},
		dockable = true,
		draggable = true,
		resizable = false,
		backgroundColor = color.main_bg,
		tooltip = "Greenballs\n\nThe game's currency. Needed to draw cards. You get more by killing monsters.",		
		children = {
			img_greenball,
			lbl_amount
		}
	}
	
	Screen0:AddChild(windowGreenballs)
end



--------------
-- Call-ins --
--------------

-- inits Chili-stuff, creates the panel and gets initial stats
function widget:Initialize()
	-- if chili is not loaded, disable this widget
	if not WG.Chili then
		widgetHandler:RemoveWidget(widget)
		return
	end

	Darius = WG.Darius
	
	-- the chili components needed
	Chili = WG.Chili
	Window = Chili.Window
	Label = Chili.Label
	Image = Chili.Image
	Screen0 = Chili.Screen0

	-- create the panel and get initial stats
	CreateGreenballUI()
	UpdateGreenballUI()
	
	spEcho("Darius greenballs widget enabled")
end


function widget:Update()
	UpdateGreenballUI()
end


-- loads the ui settings
function widget:GetConfigData()
	-- only get the stored settings if the window has been initialized
	if (windowGreenballs) then
		storedSettings.pos_x = windowGreenballs.x
		storedSettings.pos_y = windowGreenballs.y
		storedSettings.width = windowGreenballs.width
		storedSettings.height = windowGreenballs.height
	end

	return storedSettings
end


-- stores the ui settings
function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		storedSettings = data -- store the settings
	end
end


function widget:Shutdown()
	-- delete the window
	if (windowGreenballs) then
		Screen0:RemoveChild(windowGreenballs) -- remove window
		windowGreenballs:Dispose() -- free the resources
		windowGreenballs = nil
	end
	
	spEcho("Darius greenballs widget disabled")
end