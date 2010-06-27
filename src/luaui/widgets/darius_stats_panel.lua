function widget:GetInfo()
	return {
		name      = "Darius stats panel",
		desc      = "Displays ingame stats",
		author    = "malloc",
		date      = "June 24, 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 100,
		enabled   = true
	}
end

--------------
-- Speed Up --
--------------

local spEcho = Spring.Echo
local spGetSeconds  = Spring.GetGameSeconds
local spGetGameRulesParam = Spring.GetGameRulesParam

----------------
-- Local Vars --
----------------

-- fonts
local fontHandler  = loadstring(VFS.LoadFile(LUAUI_DIRNAME.."modfonts.lua", VFS.ZIP_FIRST))()
local panelFont = LUAUI_DIRNAME.."fonts/freesansbold_14"
local waveFont = LUAUI_DIRNAME.."fonts/freesansbold_16"

-- panel outfit
local panelTexture  = ":n:"..LUAUI_DIRNAME.."images/panel.tga"
local white = "\255\255\255\255"

-- display lists
local dispListPanelTex = nil
local dispListPanel = nil

-- panel status
local panelUpdate = false
local waveUpdate = false
local isPanelMoved = false
local isPanelCaptured = false

-- panel size, initial position and margin
local viewSizeX, viewSizeY = 0, 0
local panelWidth = 340
local panelHeight = 110
local x1 = -gl.GetViewSizes() + 10	-- initial position x
local y1 = -panelHeight - 10		-- initial position y
local panelMarginX = 20
local panelMarginY = 22
local panelSpacingY = 2

local round = 0
local wave = 0
local monstersLeft = 0
local monstersKilled = 0
local nextWaveDisplay = 0

fontHandler.UseFont(panelFont)
local panelFontSize = fontHandler.GetFontSize()



------------------------
-- Unsynced Functions --
------------------------

-- calculates position for the line number
local function AddNewPanelRow(lineNum)
	return panelMarginX, panelHeight - panelMarginY - (lineNum - 1) * (panelFontSize + panelSpacingY)
end


-- formats seconds to hh:mm:ss or mm:ss
local function SecondsToTimestamp(numberOfSeconds)
	local hours = math.floor(numberOfSeconds / 3600)
	local mins = math.floor(math.fmod(numberOfSeconds, 3600) / 60)
	local secs = math.floor(math.fmod(numberOfSeconds, 60))

	if (hours > 0) then
		formattedTimeString = string.format('%02i:%02i:%02i', hours, mins, secs)
	else
		formattedTimeString = string.format('%02i:%02i', mins, secs)
	end

	return formattedTimeString
end

-- draws the panel content
local function CreatePanelDisplayList()
	gl.PushMatrix()
	
	-- translate to the drawing position
	gl.Translate(x1, y1, 0)
	
	-- apply textures to the panel
	gl.CallList(dispListPanelTex)
	
	-- draw texts with textures beneath
	fontHandler.DisableCache()
	fontHandler.UseFont(panelFont)
	fontHandler.BindTexture()
	
	-- draw texts
	fontHandler.DrawStatic(white.."Time survived: "..SecondsToTimestamp(spGetSeconds()), AddNewPanelRow(1))
	fontHandler.DrawStatic(white.."Time for the next wave: "..nextWaveDisplay, AddNewPanelRow(2))
	fontHandler.DrawStatic(white.."Enemies left in this wave: "..tostring(monstersLeft), AddNewPanelRow(3))
	fontHandler.DrawStatic(white.."Enemies killed total: "..tostring(monstersKilled), AddNewPanelRow(4))
	
	fontHandler.DrawStatic(white.."Round: "..tostring(round), AddNewPanelRow(5))
	
	if (wave > 0) then
		fontHandler.DrawStatic(white.."Wave: "..tostring(wave), AddNewPanelRow(6))
	end

	gl.PopMatrix()
end

-- draws the panel to the screen
local function Draw()
	-- update the content of the panel
	if (panelUpdate) then
		if (dispListPanel) then
			gl.DeleteList(dispListPanel) -- content outdated, delete the list
			dispListPanel = nil
		end

		dispListPanel = gl.CreateList(CreatePanelDisplayList) -- get new content
		panelUpdate = false -- don't update content till we have a new dispList
	end

	-- draw the panel by calling the display list
	if (dispListPanel) then
		gl.CallList(dispListPanel)
	end
	
	-- draw the new wave message
	if (waveMessage) then
		fontHandler.UseFont(waveFont)
		
		for i, message in ipairs(waveMessage) do
			fontHandler.DrawCentered(message, viewSizeX/2, viewSizeY/2)
		end
	end
end

-- this function gets the parameter from synced code
function GetRuleOrDefault(name, default)
	rule = spGetGameRulesParam(name)
	if (rule == nil) then
		return default
	else
		return rule
	end
end

-- this function calculates the actual ingame stats
function UpdateStats()
	monstersLeft = GetRuleOrDefault("monstersLeft", 0)
	monstersKilled = GetRuleOrDefault("monstersKilled", 0)
	round = GetRuleOrDefault("round", 1)
	wave = GetRuleOrDefault("wave", 0)
	timeToNextWave = spGetGameRulesParam("nextWave")
	
	if (timeToNextWave ~= nil and timeToNextWave ~= 0) then
		local timeLeft = timeToNextWave - spGetSeconds()
		
		if timeLeft > 0 then
			nextWaveDisplay = tostring(math.floor(timeLeft))
		else
			timeLeft = 0
			nextWaveDisplay = 0;
		end
	end
	
	if (nextWaveDisplay == 0) then
		waveMessage = {}
		nextWaveNumber = wave + 1;
		waveMessage[1] = "Wave "..tostring(nextWaveNumber).." begins!"
	else
		waveMessage = nil
	end
	
	panelUpdate = true -- stats changed, panel must be updated
end

-- from synced
function Victory()
	spEcho("Congratulations, you win!")
end

--------------
-- Call-ins --
--------------

function widget:Initialize()
	-- create a new display list for texturing the panel
	dispListPanelTex = gl.CreateList(function()
		gl.Color(1, 1, 1, 1)
		gl.Texture(panelTexture)
		gl.TexRect(0, 0, panelWidth, panelHeight)
	end)
	
	UpdateStats() -- get the initial stats
	
	--widgetHandler:RegisterGlobal("Victory" , Victory)
	--widgetHandler:RegisterGlobal("UpdateStats" , UpdateStats)
end

function widget:Shutdown()
	fontHandler.FreeFont(panelFont)

	if (dispListPanel) then
		gl.DeleteList(dispListPanel)
		dispListPanel = nil
	end

	gl.DeleteList(dispListPanelTex)
	gl.DeleteTexture(panelTexture)

end

function widget:GameFrame(n)
	if (n%30 < 1) then
		UpdateStats()
	end
end

function widget:DrawScreen()
	x1 = math.floor(x1 - viewSizeX)
	y1 = math.floor(y1 - viewSizeY)
	viewSizeX, viewSizeY = gl.GetViewSizes()
	x1 = viewSizeX + x1
	y1 = viewSizeY + y1

	Draw() -- call widget's own draw function
end

function widget:MouseMove(x, y, dx, dy, button)
	if (isPanelMoved) then
		x1 = x1 + dx
		y1 = y1 + dy
		panelUpdate = true -- for smoother movement
	end
end

function widget:MousePress(x, y, button)
	if (x > x1 and x < x1 + panelWidth and y > y1 and y < y1 + panelHeight) then
		isPanelCaptured = true
		isPanelMoved  = true
	end

	return isPanelCaptured
end

function widget:MouseRelease(x, y, button)
	isPanelCaptured = nil
	isPanelMoved  = nil

	return isPanelCaptured
end

-- runs when the window is resized
function widget:ViewResize(vsx, vsy)
	x1 = math.floor(x1 - viewSizeX)
	y1 = math.floor(y1 - viewSizeY)
	viewSizeX, viewSizeY = vsx, vsy
	x1 = viewSizeX + x1
	y1 = viewSizeY + y1
end
