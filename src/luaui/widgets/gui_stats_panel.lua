function widget:GetInfo()
	return {
		name      = "Darius stats panel",
		desc      = "Displays in-game stats",
		author    = "malloc",
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
local file     = LUAUI_DIRNAME .. "Configs/crudemenu_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color    = confdata.color



----------------
-- Local Vars --
----------------

-- the status panel ui
local window_stats

-- settings of the status panel
local settings = {
	pos_x,
	pos_y,
	width,
	height
}

-- in-game stats
local gamestats = {
	gametime,
	curroundnum,
	curwavenum,
	enemiesleftinwave,
	enemieskilledtotal
}



---------------------
-- Local functions --
---------------------

-- This function converts seconds to hh:mm:ss or mm:ss (if an hour isn't reached yet)
local function SecondsToHHMMSS(numOfSecs)
	local numOfHours = math.floor(numOfSecs / 3600)
	local numOfMins = math.floor(math.fmod(numOfSecs, 3600) / 60)
	local numOfSecs = math.floor(math.fmod(numOfSecs, 60))

	if (numOfHours > 0) then
		return string.format('%02i:%02i:%02i', numOfHours, numOfMins, numOfSecs)
	end

	return string.format('%02i:%02i', numOfMins, numOfSecs)
end


-- This function gets a single paremeter from the spawner (backend)
function GetParamFromSpawner(name)
	return spGetGameRulesParam(name) or ""
end


-- This function gets the stats from the backend
local function GetStatsFromBackend()
	gamestats.curroundnum = GetParamFromSpawner("currentRound")
	gamestats.curwavenum = GetParamFromSpawner("currentWave")
	gamestats.enemiesleftinwave = GetParamFromSpawner("monstersLeftInTheWave")
	gamestats.enemieskilledtotal = GetParamFromSpawner("monstersKilledTotal")
end


-- This function updates the stats-labels in the panel
local function UpdateStats()
	gamestats.gametime = SecondsToHHMMSS(spGetSeconds())
	GetStatsFromBackend()

	if lbl_time then
		lbl_time:SetCaption(gamestats.gametime)
	end

	if lbl_roundnum then
		lbl_roundnum:SetCaption(gamestats.curroundnum)
	end

	if lbl_wavenum then
		lbl_wavenum:SetCaption(gamestats.curwavenum)
	end

	if lbl_enemiesleft then
		lbl_enemiesleft:SetCaption(gamestats.enemiesleftinwave)
	end

	if lbl_enemieskilled then
		lbl_enemieskilled:SetCaption(gamestats.enemieskilledtotal)
	end
end


-- This function creates and draws the actual UI-element
local function CreatePanel()

	-- if window hasn't been initialized, quit immediately
	if window_stats then
		window_stats:Dispose()
		window_stats = nil
	end

	-- position x of the stats in the panel
	local label_x_offset = 180

	-- labels which store dynamic data
	lbl_time = Label:New          { textColor = color.sub_fg, y=0,  x=label_x_offset }
	lbl_roundnum = Label:New      { textColor = color.sub_fg, y=15, x=label_x_offset }
	lbl_wavenum = Label:New       { textColor = color.sub_fg, y=30, x=label_x_offset }
	lbl_enemiesleft = Label:New   { textColor = color.sub_fg, y=45, x=label_x_offset }
	lbl_enemieskilled = Label:New { textColor = color.sub_fg, y=60, x=label_x_offset }

	-- the ui
	window_stats = Window:New {
		name = 'stats_panel',
		x = settings.pos_x or 10,
		y = settings.pos_y or 10,
		clientWidth = settings.width or 320,
		clientHeight = settings.height or 100,
		dockable = true,
		draggable = true,
		resizable = true,
		backgroundColor = color.main_bg,
		parent = screen0,
		children = {
			Label:New { caption = 'Time survived:',             textColor = color.sub_fg, y=0  },
			Label:New { caption = 'Round:',                     textColor = color.sub_fg, y=15 },
			Label:New { caption = 'Wave:',                      textColor = color.sub_fg, y=30 },
			Label:New { caption = 'Enemies left in this wave:', textColor = color.sub_fg, y=45 },
			Label:New { caption = 'Enemies killed total:',      textColor = color.sub_fg, y=60 },
			lbl_time,
			lbl_roundnum,
			lbl_wavenum,
			lbl_enemiesleft,
			lbl_enemieskilled
		}
	}
end



--------------
-- Call-ins --
--------------

-- inits Chili-stuff, creates the panel and gets initial stats
function widget:Initialize()
	spEcho("Darius in-game stats panel enabled")

	-- if chili is not loaded, disable this widget
	if not WG.Chili then
		widgetHandler:RemoveWidget(widget)
		return
	end

	-- chili stuff
	Chili = WG.Chili
	Window = Chili.Window
	Label = Chili.Label
	screen0 = Chili.Screen0

	-- create the panel and get initial stats
	CreatePanel()
	UpdateStats()
end


-- loads the ui settings
function widget:GetConfigData()
	-- only get settings if the window has been initialized
	if (window_stats) then
		settings.pos_x = window_stats.x
		settings.pos_y = window_stats.y
		settings.width = window_stats.width
		settings.height = window_stats.height
	end

	return settings
end


-- stores the ui settings to [somewhere yet unknown place] 
function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		settings = data
	end
end


function widget:Update()
	UpdateStats()
end


function widget:Shutdown()
	spEcho("Darius in-game stats panel disabled")

	if (window_stats) then
		screen0:RemoveChild(window_stats)
		window_stats:Dispose()
		window_stats = nil
	end
end
