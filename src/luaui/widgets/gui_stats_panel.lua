function widget:GetInfo()
	return {
		name      = "Darius stats panel",
		desc      = "Displays in-game stats",
		author    = "malloc / xcompwiz",
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
local spSendLuaRulesMsg   = Spring.SendLuaRulesMsg

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
local settings = {
	pos_x,
	pos_y,
	width,
	height,
}

local defaults = {
	pos_x = -1,
	pos_y = 0,
	width = 280,
	height = 120,
}

-- in-game stats
local gamestats = {
	timeElapsed,
	timeToNextWave,
	currentWave,
	wavesTotal,
	enemiesKilled,
	enemiesTotal,
}

---------------------
-- Local functions --
---------------------

local function NextWave()
	spSendLuaRulesMsg("SendNextWave")
end

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
	return spGetGameRulesParam(name) or 0
end


-- Calculates seconds to next wave
local function CalculateTimeToNextWave(nextWave)
	local secondsToNextWave = math.floor(nextWave - Spring.GetGameSeconds())
	if secondsToNextWave < 0 then
		return 0
	end
	return secondsToNextWave
end


-- This function gets the stats from the backend
local function GetStatsFromBackend()
	gamestats.timeToNextWave = CalculateTimeToNextWave(GetParamFromSpawner("NextWave"))
	gamestats.currentWave    = GetParamFromSpawner("numOfCurrentWave")
	gamestats.wavesTotal     = GetParamFromSpawner("numberOfWaves")
	gamestats.enemiesKilled  = GetParamFromSpawner("monstersKilledTotal")
	gamestats.enemiesTotal   = GetParamFromSpawner("monstersSpawnedTotal")
end


-- This function updates the stats-labels in the panel
local function UpdateStats()
	if not (windowStats) then return end

	gamestats.timeElapsed = SecondsToHHMMSS(spGetSeconds())
	GetStatsFromBackend()

	vsx, vsy, _, _ = Spring.GetViewGeometry()
	if (windowStats.x < 0) then
		windowStats.x = 0
	end
	if (windowStats.y < 0) then
		windowStats.y = 0
	end
	if (windowStats.x > vsx - windowStats.width) then
		windowStats.x = vsx - windowStats.width
	end
	if (windowStats.y > vsy - windowStats.height) then
		windowStats.y = vsy - windowStats.height
	end

	local font_size = 15
	local width = windowStats.width - 30
	local lblwidth = width*3/4
	-- Scale labels
	local smallestFont = nil
	for _, lbl in pairs(windowStats.labels) do
		while (lbl.font:GetTextWidth(lbl.caption) < lblwidth) do
			lbl.font.size = lbl.font.size + 1
		end
		while (lbl.font:GetTextWidth(lbl.caption) > lblwidth) do
			lbl.font.size = lbl.font.size - 1
		end
		if not (smallestFont) then smallestFont = lbl.font.size end
		if (smallestFont > lbl.font.size) then smallestFont = lbl.font.size end
	end
	font_size = smallestFont
	local next_y = 0
	local left_offset = 0
	for _, lbl in pairs(windowStats.labels) do
		lbl.y = next_y
		lbl.font.size = smallestFont
		if (lbl.font:GetTextWidth(lbl.caption) > left_offset) then
			left_offset = lbl.font:GetTextWidth(lbl.caption)
		end
		lbl:Invalidate()

		next_y = lbl.y + font_size
	end

	left_offset = left_offset + 5

	if lbl_time then
		lbl_time:SetCaption(gamestats.timeElapsed)
		lbl_time.x = left_offset
		lbl_time.y = 0
		lbl_time.font.size = font_size
		lbl_time:Invalidate()
	end

	if lbl_timetonext then
		lbl_timetonext:SetCaption(gamestats.timeToNextWave)
		lbl_timetonext.x = left_offset
		lbl_timetonext.y = lbl_time.y + lbl_time.font.size
		lbl_timetonext.font.size = font_size
		lbl_timetonext:Invalidate()
	end

	if lbl_currentwave then
		lbl_currentwave:SetCaption(gamestats.currentWave)
		lbl_currentwave.x = left_offset
		lbl_currentwave.y = lbl_timetonext.y + lbl_timetonext.font.size
		lbl_currentwave.font.size = font_size
		lbl_currentwave:Invalidate()
	end

	if lbl_wavestotal then
		lbl_wavestotal:SetCaption(" of " .. gamestats.wavesTotal)
		lbl_wavestotal.x = lbl_currentwave.x + lbl_currentwave.font:GetTextWidth(lbl_currentwave.caption)
		lbl_wavestotal.y = lbl_currentwave.y
		lbl_wavestotal.font.size = font_size
		lbl_wavestotal:Invalidate()
	end
	if lbl_enemieskilled then
		lbl_enemieskilled:SetCaption(gamestats.enemiesKilled)
		lbl_enemieskilled.x = left_offset
		lbl_enemieskilled.y = lbl_currentwave.y + lbl_currentwave.font.size
		lbl_enemieskilled.font.size = font_size
		lbl_enemieskilled:Invalidate()
	end
	
	if lbl_enemiestotal then
		lbl_enemiestotal:SetCaption(" of " .. gamestats.enemiesTotal)
		lbl_enemiestotal.x = lbl_enemieskilled.x + lbl_enemieskilled.font:GetTextWidth(lbl_enemieskilled.caption)
		lbl_enemiestotal.y = lbl_enemieskilled.y
		lbl_enemiestotal.font.size = font_size
		lbl_enemiestotal:Invalidate()
	end

	if btn_sendwave then
		if GetParamFromSpawner("allowSendingNextWave") == 1 then
			btn_sendwave:SetCaption("Force next wave!")
		else
			btn_sendwave:SetCaption("Spawning in progress!")
		end
		btn_sendwave.x = width/14
		btn_sendwave.y = lbl_enemieskilled.y + lbl_enemieskilled.font.size * 1.5
		btn_sendwave.width = width - width/7
		btn_sendwave.height = font_size
		btn_sendwave.font.size = font_size * 0.8
		btn_sendwave:Invalidate()
	end

	windowStats.minHeight = btn_sendwave.y + btn_sendwave.height * 1.5 + 20
	windowStats.maxHeight = btn_sendwave.y + btn_sendwave.height * 1.5 + 20
	windowStats:Invalidate()
end


-- This function creates and draws the actual UI element
local function CreatePanel()

	-- if window hasn't been initialized, free the resources associated
	if windowStats then
		windowStats:Dispose()
		windowStats = nil
	end

	-- position x of the stats in the panel
	local label_x_offset = (settings.width or defaults.width) * 0.6
	local font_size = 15

	-- labels which store dynamic data
	lbl_time          = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset, y=0 }
	lbl_timetonext    = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset, y=15 }
	lbl_currentwave   = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset, y=30 }
	lbl_wavestotal    = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset+50, y=30 }
	lbl_enemieskilled = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset, y=45 }
	lbl_enemiestotal  = Label:New { textColor = color.sub_fg, fontSize=font_size, x=label_x_offset+50, y=45 }
	
	-- FIXME: Button does not really fit into the UI ...
	-- button to send new wave
	btn_sendwave = Button:New{ caption = "Force next wave!", OnMouseUp = { NextWave }, y=60, width=200 }

	-- the ui
	windowStats = Window:New {
		name = 'stats_panel',
		x = settings.pos_x or defaults.pos_x,
		y = settings.pos_y or defaults.pos_y,
		clientWidth = settings.width or defaults.width,
		clientHeight = settings.height or defaults.height,
		minWidth = 50,
		minHeight = 20,
		dockable = false,
		draggable = true,
		resizable = true,
		parent = Screen0,
		children = {
			-- dynamic labels
			lbl_time,
			lbl_timetonext,
			lbl_currentwave,
			lbl_wavestotal,
			lbl_enemieskilled,
			lbl_enemiestotal,
			btn_sendwave
		}
	}

	-- label list for static text
	windowStats.labels = {}
	table.insert(windowStats.labels, Label:New { caption = 'Time survived:',         textColor = color.sub_fg, fontSize=font_size, y=0 })
	table.insert(windowStats.labels, Label:New { caption = 'Seconds to next wave:',  textColor = color.sub_fg, fontSize=font_size, y=15 })
	table.insert(windowStats.labels, Label:New { caption = 'Current wave:',          textColor = color.sub_fg, fontSize=font_size, y=30 })
	table.insert(windowStats.labels, Label:New { caption = 'Enemies killed:',        textColor = color.sub_fg, fontSize=font_size, y=45 })

	for _, lbl in pairs(windowStats.labels) do
		table.insert(windowStats.children, lbl)
	end
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
	Button = Chili.Button
	Screen0 = Chili.Screen0

	-- create the panel and get initial stats
	CreatePanel()
	UpdateStats()

	WG.Darius:RegisterWidget(widget)
end



function widget:Update()
	UpdateStats()
end


-- loads the ui settings
function widget:GetConfigData()
	-- only get the stored settings if the window has been initialized
	if (windowStats) then
		settings.pos_x = windowStats.x
		settings.pos_y = windowStats.y
		settings.width = windowStats.width
		settings.height = windowStats.height
	end

	return settings
end


-- stores the ui settings
function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		settings = data -- store the settings
	end
end


function widget:Shutdown()
	WG.Darius:RemoveWidget(widget)
	-- delete the window
	if (windowStats) then
		Screen0:RemoveChild(windowStats) -- remove window
		windowStats:Dispose() -- free the resources
		windowStats = nil
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
		if (windowStats) then
			windowStats.x = WrapScreen(defaults.pos_x, vsx)
			windowStats.y = WrapScreen(defaults.pos_y, vsy)
			windowStats.width = WrapScreen(defaults.width, vsx)
			windowStats.height = WrapScreen(defaults.height, vsy)
		end
	elseif (message == "show") then
		if (windowStats) then Screen0:AddChild(windowStats) end
	elseif (message == "hide") then
		if (windowStats) then Screen0:RemoveChild(windowStats) end
	end
end
