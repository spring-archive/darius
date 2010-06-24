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

----------------
-- Local Vars --
----------------

-- fonts
local fontHandler  = loadstring(VFS.LoadFile(LUAUI_DIRNAME.."modfonts.lua", VFS.ZIP_FIRST))()
local panelFont = LUAUI_DIRNAME.."fonts/freesansbold_14"
local panelFontSize = fontHandler.GetFontSize()

-- panel outfit
local panelTexture  = ":n:"..LUAUI_DIRNAME.."images/panel.tga"
local white = "\255\255\255\255"

-- display lists
local dispListPanelTex = nil
local dispListPanel = nil

-- panel status
local panelUpdate = false
local isPanelMoved = false
local isPanelCaptured = false

-- panel size, initial position and margin
local viewSizeX, viewSizeY = 0, 0
local panelWidth = 340
local panelHeight = 80
local x1 = -gl.GetViewSizes() + 10	-- initial position x
local y1 = -panelHeight - 10		-- initial position y
local panelMarginX = 20
local panelMarginY = 22
local panelSpacingY = 2



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
	fontHandler.BindTexture()
	
	-- draw texts
	fontHandler.DrawStatic(white.."Time survived: "..SecondsToTimestamp(spGetSeconds()), AddNewPanelRow(1))
	fontHandler.DrawStatic(white.."Wave number / time for the next wave", AddNewPanelRow(2))
	fontHandler.DrawStatic(white.."Enemies left in this wave: ", AddNewPanelRow(3))
	fontHandler.DrawStatic(white.."Enemies killed total: ", AddNewPanelRow(4))

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

end

-- this function calculates the actual ingame stats
local function UpdateStats()
	panelUpdate = true -- stats changed, panel must be updated
end

--------------
-- Call-ins --
--------------

function widget:Initialize()
	fontHandler.UseFont(panelFont)

	-- create a new display list for texturing the panel
	dispListPanelTex = gl.CreateList(function()
		gl.Color(1, 1, 1, 1)
		gl.Texture(panelTexture)
		gl.TexRect(0, 0, panelWidth, panelHeight)
	end)

	UpdateStats() -- get the initial stats
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
