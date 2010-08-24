function widget:GetInfo()
	return {
		name      = "Darius End-Game Display",
		desc      = "Displays post-game stats",
		author    = "xcompwiz",
		date      = "July 1, 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 100,
		enabled   = true
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

-- Card data (for awards)
local carddata = {}

-- UI elements
local window_endgame
local lbl_awards

local settings = {
	cardsize_x = 120,
	cardsize_y = 200,
	pos_x,
	pos_y,
	width,
	height,
}

local defaults = {
	pos_x = 0,
	pos_y = 500,
	width = 400,
	height = 400,
}

-- in-game stats
local gamestats = {
	awards = {},
	timeElapsed = 0,
	wavesTotal = 0,
	enemiesKilled = 0,
	enemiesTotal = 0,
}

---------------------
-- Local functions --
---------------------

-- converts seconds to hh:mm:ss
local function SecondsToHHMMSS(numOfSecs)
	local numOfHours = math.floor(numOfSecs / 3600)
	local numOfMins = math.floor(math.fmod(numOfSecs, 3600) / 60)
	local numOfSecs = math.floor(math.fmod(numOfSecs, 60))

	return string.format('%02i:%02i:%02i', numOfHours, numOfMins, numOfSecs)
end

local function LoadCardData()
	local materialFiles = VFS.DirList('cards/lua/material', '*.lua')
	local weaponFiles = VFS.DirList('cards/lua/weapon', '*.lua')
	local specialFiles = VFS.DirList('cards/lua/special', '*.lua')

	for i=1, #materialFiles do
		local card = VFS.Include(materialFiles[i])
		carddata[card.name] = card
	end
	for i=1, #weaponFiles do
		local card = VFS.Include(weaponFiles[i])
		carddata[card.name] = card
	end

	for i=1, #specialFiles do
		local card = VFS.Include(specialFiles[i])
		carddata[card.name] = card
	end
end

-- gets the game stats
local function GetStats()
	gamestats.enemiesKilled    = spGetGameRulesParam("monstersKilledTotal")
	gamestats.enemiesTotal     = spGetGameRulesParam("monstersSpawnedTotal")
	gamestats.wavesCompleted   = spGetGameRulesParam("numOfCurrentWave")
	gamestats.wavesTotal       = spGetGameRulesParam("numberOfWaves")
end

--Award str should be whitespace seperated
local function SetAward(awardstr)
	if (awardstr) then
		-- iterate over whitespace-separated components
		for id in awardstr:gmatch("%S+") do
			local card = carddata[id]
			if (type(card) == "table") then
				table.insert(gamestats.awards, card)
			end
		end
	end
end

-- This function creates the actual UI element
local function CreatePanel()

	-- if window has already been initialized, free the resources associated
	if window_endgame then
		window_endgame:Dispose()
		window_endgame = nil
	end
	
	local font_size = 13

	window_endgame = Window:New {
		name = 'endgame_stats',
		x = settings.pos_x or defaults.pos_x,
		y = settings.pos_y or defaults.pos_y,
		width = settings.width or defaults.width,
		height = settings.height or defaults.height,
		minWidth = 200,
		minHeight = 200,
		dockable = false,
		draggable = true,
		resizable = true,
		parent = Screen0,
		children = {},
	}

	-- label list
	window_endgame.labels = {}
	table.insert(window_endgame.labels, Label:New { textColor = color.sub_fg, fontSize=font_size, x=0, y= 0, caption = 'Game Time: ' .. SecondsToHHMMSS(gamestats.timeElapsed) })
	table.insert(window_endgame.labels, Label:New { textColor = color.sub_fg, fontSize=font_size, x=0, y=15, caption = 'Enemies Killed: ' .. gamestats.enemiesKilled .. ' of ' .. gamestats.enemiesTotal })
	table.insert(window_endgame.labels, Label:New { textColor = color.sub_fg, fontSize=font_size, x=0, y=45, caption = 'Waves completed: ' .. gamestats.wavesCompleted .. ' of ' .. gamestats.wavesTotal })
	for _, lbl in pairs(window_endgame.labels) do
		table.insert(window_endgame.children, lbl)
	end

	--Card awards
	if (#gamestats.awards ~= 0) then
		lbl_awards = Label:New { textColor = color.sub_fg, fontSize=font_size+5, x=0, y= 0, caption = 'Cards Awarded' }
		table.insert(window_endgame.children, lbl_awards)

		window_endgame.cards = {}
		for _, card in pairs(gamestats.awards) do
			local button = WG.Darius:GetCardButton(card, settings.cardsize_x, settings.cardsize_y)
			table.insert(window_endgame.cards, button)
		end
		for _, btn in pairs(window_endgame.cards) do
			table.insert(window_endgame.children, btn)
		end
	end
end

local function AdjustWindow()
	if not (window_endgame) then return end

	vsx, vsy, _, _ = Spring.GetViewGeometry()
	if (window_endgame.x < 0) then
		window_endgame.x = 0
	end
	if (window_endgame.y < 0) then
		window_endgame.y = 0
	end
	if (window_endgame.x > vsx - window_endgame.width) then
		window_endgame.x = vsx - window_endgame.width
	end
	if (window_endgame.y > vsy - window_endgame.height) then
		window_endgame.y = vsy - window_endgame.height
	end

	local max_width = window_endgame.width - 35
	local max_height = window_endgame.height - 35
	local max_label_height = max_height
	if (#gamestats.awards ~= 0) then max_label_height = max_height/5 end

	-- Scale labels
	local smallestFont = nil
	for _, lbl in pairs(window_endgame.labels) do
		while (lbl.font:GetTextWidth(lbl.caption) < max_width) do
			lbl.font.size = lbl.font.size + 1
		end
		while (lbl.font:GetTextWidth(lbl.caption) > max_width) do
			lbl.font.size = lbl.font.size - 1
		end
		while (lbl.font:GetTextHeight(lbl.caption) > max_label_height/3-1) do
			lbl.font.size = lbl.font.size - 1
		end
		if not (smallestFont) then smallestFont = lbl.font.size end
		if (smallestFont > lbl.font.size) then smallestFont = lbl.font.size end
	end
	local next_y = 0
	for _, lbl in pairs(window_endgame.labels) do
		lbl.y = next_y
		lbl.font.size = smallestFont
		lbl:Invalidate()

		next_y = lbl.y + lbl.font:GetTextHeight(lbl.caption)
	end

	window_endgame.minHeight = next_y + 50

	-- Awards
	if (lbl_awards) then
		lbl_awards.y = next_y + (max_height / 10)
		lbl_awards:Invalidate()
		local grid_btn_y = lbl_awards.y + lbl_awards.font:GetTextHeight(lbl_awards.caption)

		local max_card_width = max_width/#gamestats.awards
		settings.cardsize_y = max_height - grid_btn_y
		settings.cardsize_x = settings.cardsize_y * 0.6
		if (settings.cardsize_x > max_card_width) then
			settings.cardsize_x = max_card_width
			settings.cardsize_y = max_card_width / 0.6
		end

		local next_btn_x = 0
		for _, btn in pairs(window_endgame.cards) do
			btn.x = next_btn_x
			btn.y = grid_btn_y + 10
			btn:UpdateCard(settings.cardsize_x, settings.cardsize_y)
			next_btn_x = btn.x + settings.cardsize_x
		end

		window_endgame.minHeight = grid_btn_y + settings.cardsize_y + 50
	end

	window_endgame:Invalidate()
end

--------------
-- Call-ins --
--------------

-- inits Chili-stuff, creates the panel and gets initial stats
function widget:Initialize()
	LoadCardData()
	widgetHandler:RegisterGlobal("SetAwardDisplay" , SetAward)
	WG.Darius:RegisterWidget(widget)
end

function widget:GameOver()
	gamestats.timeElapsed = spGetSeconds()
	GetStats()

	-- if chili is not loaded, disable this widget
	if not WG.Chili then
		widgetHandler:RemoveWidget(widget)
		return
	end

	-- the chili components needed
	Chili = WG.Chili
	Window = Chili.Window
	StackPanel = Chili.StackPanel
	Label = Chili.Label
	Screen0 = Chili.Screen0

	-- create the panel
	CreatePanel()
end

function widget:Update(...)
	AdjustWindow()
end

-- saves the ui settings
function widget:GetConfigData()
	-- only get the stored settings if the window has been initialized
	if (window_endgame) then
		settings.pos_x = window_endgame.x
		settings.pos_y = window_endgame.y
		settings.width = window_endgame.width
		settings.height = window_endgame.height
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
	if (window_endgame) then
		Screen0:RemoveChild(window_endgame) -- remove window_endgame
		window_endgame:Dispose() -- free the resources
		window_endgame = nil
	end
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
		if (window_endgame) then
			vsx, vsy, _, _ = Spring.GetViewGeometry()
			window_endgame.x = WrapScreen(defaults.pos_x, vsx)
			window_endgame.y = WrapScreen(defaults.pos_y, vsy)
			window_endgame.width = WrapScreen(defaults.width, vsx)
			window_endgame.height = WrapScreen(defaults.height, vsy)
		end
	end
end
