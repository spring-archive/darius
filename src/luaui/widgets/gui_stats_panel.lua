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
local file     = LUAUI_DIRNAME .. "Configs/gui_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color    = confdata.color



----------------
-- Local Vars --
----------------

-- the status panel UI element
local windowStats

-- settings of the status panel
local storedSettings = {
	pos_x,
	pos_y,
	width,
	height
}

-- in-game stats
local gamestats = {
	timeElapsed,
	timeToNextWave,
	numOfCurrentWave,
	numOfWavesTotal,
	enemiesKilled,
	enemiesTotal
}

-- default size
local defaultWidth, defaultHeight = 280, 95



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
	return spGetGameRulesParam(name) or "0"
end


local function CalculateTimeToNextWave(nextWave)
	local nw = math.floor(nextWave - Spring.GetGameSeconds())
	if nw < 0 then
		return 0
	end
	return nw
end

-- This function gets the stats from the backend
local function GetStatsFromBackend()
	gamestats.timeToNextWave      = CalculateTimeToNextWave(GetParamFromSpawner("NextWave"))
	gamestats.numOfCurrentWave    = GetParamFromSpawner("numOfCurrentWave")
	gamestats.enemiesKilled       = GetParamFromSpawner("monstersKilledTotal")
	gamestats.enemiesTotal = GetParamFromSpawner("monstersSpawnedTotal")
	gamestats.wavesTotal = GetParamFromSpawner("numberOfWaves")
end


-- This function updates the stats-labels in the panel
local function UpdateStats()
	gamestats.timeElapsed = SecondsToHHMMSS(spGetSeconds())
	GetStatsFromBackend()

	if lbl_time then
		lbl_time:SetCaption(gamestats.timeElapsed)
	end

	if lbl_timetonext then
		lbl_timetonext:SetCaption(gamestats.timeToNextWave)
	end

	if lbl_currentwave then
		lbl_currentwave:SetCaption(gamestats.numOfCurrentWave)
	end

	if lbl_enemieskilled then
		lbl_enemieskilled:SetCaption(gamestats.enemiesKilled)
	end
	
	if lbl_enemiestotal then
		lbl_enemiestotal:SetCaption(gamestats.enemiesTotal)
	end
	
	if lbl_wavestotal then
		lbl_wavestotal:SetCaption(gamestats.wavesTotal)
	end
end


-- This function creates and draws the actual UI element
local function CreatePanel()

	-- if window hasn't been initialized, free the resources associated
	if windowStats then
		windowStats:Dispose()
		windowStats = nil
	end

	-- position x of the stats in the panel
	local label_x_offset = 170
	local font_size = 15

	-- labels which store dynamic data
	lbl_time          = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset, y=0 }
	lbl_timetonext    = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset, y=15 }
	lbl_currentwave   = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset, y=30 }
	lbl_wavestotal    = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset+50, y=30 }
	lbl_enemieskilled = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset, y=45 }
	lbl_enemiestotal  = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset+50, y=45 }

	-- the ui
	windowStats = Window:New {
		name = 'stats_panel',
		x = storedSettings.pos_x or 10,
		y = storedSettings.pos_y or 10,
		clientWidth = storedSettings.width or defaultWidth,
		clientHeight = storedSettings.height or defaultHeight,
		minimumSize = {defaultWidth, defaultHeight},
		dockable = true,
		draggable = true,
		resizable = false,
		parent = Screen0,
		children = {
			-- static labels
			Label:New { caption = 'Time survived:',         textColor = color.sub_fg, fontSize=font_size, y=0 },
			Label:New { caption = 'Time to the next wave:', textColor = color.sub_fg, fontSize=font_size, y=15 },
			Label:New { caption = 'Current wave:',          textColor = color.sub_fg, fontSize=font_size, y=30 },
			Label:New { caption = 'of ',                    textColor = color.sub_fg, fontSize=font_size, x=label_x_offset+25, y=30 },
			Label:New { caption = 'Enemies killed:',        textColor = color.sub_fg, fontSize=font_size, y=45 },
			Label:New { caption = 'of ',                    textColor = color.sub_fg, fontSize=font_size, x=label_x_offset+25, y=45 },
			-- dynamic labels
			lbl_time,
			lbl_timetonext,
			lbl_currentwave,
			lbl_wavestotal,
			lbl_enemieskilled,
			lbl_enemiestotal
		}
	}
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

	-- the chili components needed
	Chili = WG.Chili
	Window = Chili.Window
	Label = Chili.Label
	Screen0 = Chili.Screen0

	-- create the panel and get initial stats
	CreatePanel()
	UpdateStats()

	spEcho("Darius in-game stats panel enabled")
end



function widget:Update()
	UpdateStats()
end


-- loads the ui settings
function widget:GetConfigData()
	-- only get the stored settings if the window has been initialized
	if (windowStats) then
		storedSettings.pos_x = windowStats.x
		storedSettings.pos_y = windowStats.y
		storedSettings.width = windowStats.width
		storedSettings.height = windowStats.height
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
	if (windowStats) then
		Screen0:RemoveChild(windowStats) -- remove window
		windowStats:Dispose() -- free the resources
		windowStats = nil
	end

	spEcho("Darius in-game stats panel disabled")
end
