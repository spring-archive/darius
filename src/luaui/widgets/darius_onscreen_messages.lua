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
local statusMessages = {}

-- size of the window (used for centering the text)
local viewSizeX, viewSizeY = gl.GetViewSizes()



---------------------
-- Local functions --
---------------------

-- draws messages on screen
local function DrawMessages()
	-- the next wave messages
	if (timeToNextWave > -1) then
		if (math.floor(timeToNextWave) < 1) then statusMessages = {} -- clear
		elseif (math.floor(timeToNextWave) == 3) then statusMessages[1] = "Ready!"
		elseif (math.floor(timeToNextWave) == 2) then statusMessages[1] = "Set!"
		elseif (math.floor(timeToNextWave) < 2) then statusMessages[1] = "Wave #"..numOfNextWave.." begins!"
		else
			statusMessages[1] = "Time before the wave #"..numOfNextWave..": "..math.floor(timeToNextWave).." seconds"
		end
	end

	-- the game finished message
	if (isGameFinished == 1) then
		statusMessages[1] = "Congratulations! You won the game.";
	end

	-- draws the actual texts set above
	for i, message in ipairs(statusMessages) do
		fontHandler.DrawCentered("\255\255\255\255"..message, viewSizeX/2, viewSizeY/2)
	end
end


-- gets the game status from the spawner (backend)
function GetGameStatusFromBackend()
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
	statusMessages[1] = "Welcome to Darius Tower Defense! Game starts in a few seconds."
end


function widget:Update()
	GetGameStatusFromBackend()
end


function widget:DrawScreen()
	DrawMessages() -- do the opengl stuff there
end


-- runs when the window is resized
function widget:ViewResize(vsx, vsy)
   -- store the new size using parameters, no need to call the GetViewSizes function
	viewSizeX, viewSizeY = vsx, vsy	
end


function widget:Shutdown()
	spEcho("Darius on-screen messages disabled")
	fontHandler.FreeFont(messageFont)
end
