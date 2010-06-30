function widget:GetInfo()
	return {
		name      = "Darius on-screen messages",
		desc      = "Displays messages on screen during gameplay",
		author    = "malloc",
		date      = "July 1, 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 100,
		enabled   = true -- enabled by default
	}
end



--------------
-- Speed Up --
--------------

local spEcho = Spring.Echo
local spGetGameRulesParam = Spring.GetGameRulesParam



----------------
-- Local Vars --
----------------

-- fonts
local fontHandler = loadstring(VFS.LoadFile(LUAUI_DIRNAME.."modfonts.lua", VFS.ZIP_FIRST))()
local messageFont = LUAUI_DIRNAME.."fonts/freesansbold_16"

-- array to store the messages to display
local StatusMessages = {}

-- size of the window (used for centering the text)
local viewSizeX, viewSizeY = gl.GetViewSizes()



---------------------
-- Local functions --
---------------------

-- draws messages on screen
local function DrawMessages()
	-- the next wave messages
	if (timeToNextWave > -1) then
		if (math.floor(timeToNextWave) < 1) then StatusMessages = {} -- clear
		elseif (math.floor(timeToNextWave) == 3) then StatusMessages[1] = "Ready!"
		elseif (math.floor(timeToNextWave) == 2) then StatusMessages[1] = "Set!"
		elseif (math.floor(timeToNextWave) < 2) then StatusMessages[1] = "Wave #"..numOfNextWave.." begins!"
		else
			StatusMessages[1] = "Time before the wave #"..numOfNextWave..": "..math.floor(timeToNextWave).." seconds"
		end
	end

	-- the game finished message
	if (isGameFinished == 1) then
		StatusMessages[1] = "Congratulations! You won the game.";
	end

	-- draws the actual texts set above
	for i, message in ipairs(StatusMessages) do
		fontHandler.DrawCentered("\255\255\255\255"..message, viewSizeX/2, viewSizeY/2)
	end
end


-- gets the game status from the spawner (backend)
function UpdateStatus()
	numOfNextWave = spGetGameRulesParam("currentWave") + 1
	timeToNextWave = spGetGameRulesParam("timeToTheNextWave")
	isGameFinished = spGetGameRulesParam("gameWon")
end



--------------
-- Call-ins --
--------------

function widget:Initialize()
	spEcho("Darius on-screen messages enabled")

	-- use this font for messages
	fontHandler.UseFont(messageFont)
	
	-- the initial welcome message
	StatusMessages[1] = "Welcome to Darius Tower Defense. Game starts in a few seconds."
end


function widget:Update()
	UpdateStatus()
end


function widget:DrawScreen()
	DrawMessages()
end


-- runs when the window is resized
function widget:ViewResize(vsx, vsy)
	viewSizeX, viewSizeY = vsx, vsy
end


function widget:Shutdown()
	spEcho("Darius on-screen messages disabled")
	
	fontHandler.FreeFont(messageFont)
end
