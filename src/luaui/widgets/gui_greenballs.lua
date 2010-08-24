function widget:GetInfo()
	return {
		name = "Greenballs display",
		desc = "Shows how many greenballs you have",
		author = "Jammer / malloc / xcompwiz",
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
local settings = {
	pos_x,
	pos_y,
	width,
	height,
}

local defaults = {
	pos_x = -400,
	pos_y = 0,
	width = 120,
	height = 50,
}

---------------------
-- Local functions --
---------------------

local function UpdateGreenballUI() 
	if not (windowGreenballs) then return end
	vsx, vsy, _, _ = Spring.GetViewGeometry()
	if (windowGreenballs.x < 0) then
		windowGreenballs.x = 0
	end
	if (windowGreenballs.y < 0) then
		windowGreenballs.y = 0
	end
	if (windowGreenballs.x > vsx - windowGreenballs.width) then
		windowGreenballs.x = vsx - windowGreenballs.width
	end
	if (windowGreenballs.y > vsy - windowGreenballs.height) then
		windowGreenballs.y = vsy - windowGreenballs.height
	end

	if (img_greenball) then
		img_greenball.x = 0
		img_greenball.y = 0
		img_greenball.width = math.min(windowGreenballs.height-25,(windowGreenballs.width-25)/2)
		img_greenball.height = img_greenball.width
		img_greenball:Invalidate()
	end
	local lbl_width = windowGreenballs.width-25 - img_greenball.width
	if (lbl_amount) then
		lbl_amount.x = img_greenball.x + img_greenball.width + 1
		lbl_amount.y = 0
		lbl_amount:SetCaption(Darius:GetGreenballs())
		while (lbl_amount.font:GetTextWidth(lbl_amount.caption) < lbl_width) do
			lbl_amount.font.size = lbl_amount.font.size + 1
		end
		while (lbl_amount.font:GetTextWidth(lbl_amount.caption) > lbl_width) do
			lbl_amount.font.size = lbl_amount.font.size - 1
		end
		while (lbl_amount.font:GetTextHeight(lbl_amount.caption) > img_greenball.height) do
			lbl_amount.font.size = lbl_amount.font.size - 1
		end
		lbl_amount:Invalidate()
	end
	windowGreenballs:Invalidate()
end


-- This function creates and draws the actual UI element
local function CreateGreenballUI()

	-- if window hasn't been initialized, free the resources associated
	if windowGreenballs then
		windowGreenballs:Dispose()
		windowGreenballs = nil
	end
	
	lbl_amount    = Label:New { x=10, width=60, align="right", textColor = color.game_fg, caption = '', fontSize=30 }
	img_greenball = Image:New { width=25, height=25, file = 'bitmaps/greenball.png' }

	windowGreenballs = Window:New {
		name = "greenballs",
		x = settings.pos_x or defaults.pos_x,
		y = settings.pos_y or defaults.pos_y,
		width = settings.width or defaults.width,
		height = settings.height or defaults.height,
		minimumSize = {20, 20},
		dockable = false,
		draggable = true,
		resizable = true,
		--fixedRatio = true, --Does strange behavior
		backgroundColor = color.main_bg,
		tooltip = "Greenballs\n\nThe game's currency. Needed to draw and play cards. You get more by killing monsters.",

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
	Darius:RegisterWidget(widget)
end


function widget:Update()
	UpdateGreenballUI()
end


-- loads the ui settings
function widget:GetConfigData()
	-- only get the stored settings if the window has been initialized
	if (windowGreenballs) then
		settings.pos_x = windowGreenballs.x
		settings.pos_y = windowGreenballs.y
		settings.width = windowGreenballs.width
		settings.height = windowGreenballs.height
	end

	return settings
end


-- stores the ui settings
function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		settings = data
	end
end


function widget:Shutdown()
	Darius:RemoveWidget(widget)
	-- delete the window
	if (windowGreenballs) then
		Screen0:RemoveChild(windowGreenballs) -- remove window
		windowGreenballs:Dispose() -- free the resources
		windowGreenballs = nil
	end
	
	spEcho("Darius greenballs widget disabled")
end

-----------------------------
-- Darius Message Handling --
-----------------------------

local function WrapScreen(point, vsa)
	if (point >= 0) then return point end
	return vsa + point
end

function widget:RcvMessage(message)
	if (message == "reset") then
		if (windowGreenballs) then
			windowGreenballs.x = WrapScreen(defaults.pos_x, vsx)
			windowGreenballs.y = WrapScreen(defaults.pos_y, vsy)
			windowGreenballs.width = WrapScreen(defaults.width, vsx)
			windowGreenballs.height = WrapScreen(defaults.height, vsy)
		end
	elseif (message == "show") then
		if (windowGreenballs) then Screen0:AddChild(windowGreenballs) end
	elseif (message == "hide") then
		if (windowGreenballs) then Screen0:RemoveChild(windowGreenballs) end
	end
end
