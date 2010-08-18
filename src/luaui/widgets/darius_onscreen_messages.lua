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
	-- the game finished message
	if (isGameFinished == 1) then
		statusMessages[1] = "Congratulations! You won the game.";
		
			for i, message in ipairs(statusMessages) do
			fontHandler.DrawCentered("\255\255\255\255"..message, viewSizeX/2, viewSizeY/2)
		end
	end
end


-- gets the game status from the spawner (backend)
function GetGameStatusFromBackend()
	isGameFinished = spGetGameRulesParam("gameWon")
end



--------------
-- Call-ins --
--------------

function widget:Initialize()
	spEcho("Darius on-screen messages enabled")

	-- use this font for messages
	fontHandler.UseFont(messageFont)
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
