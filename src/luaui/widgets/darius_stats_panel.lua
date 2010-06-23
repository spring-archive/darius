function widget:GetInfo()
	return {
		name      = "Darius stats panel",
		desc      = "Displays ingame stats",
		author    = "malloc",
		date      = "June 23, 2010",
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

local fontHandler  = loadstring(VFS.LoadFile(LUAUI_DIRNAME.."modfonts.lua", VFS.ZIP_FIRST))()
local panelFont = LUAUI_DIRNAME.."fonts/freesansbold_14"
local panelFontSize = fontHandler.GetFontSize()

local panelTexture  = ":n:"..LUAUI_DIRNAME.."images/panel.tga"
local white = "\255\255\255\255"

local displayList
local guiPanel
local updatePanel

local isPanelMoved = nil
local isPanelCaptured = nil
local gameInfo = nil

local viewSizeX, viewSizeY = 0, 0
local panelWidth = 340
local panelHeight = 120
local x1 = - panelWidth * 2
local y1 = - panelHeight - 10
local panelMarginX = 25
local panelMarginY = 25
local panelSpacingY = 2

------------------------
-- Unsynced Functions --
------------------------

local function AddNewRow(n)
	return panelMarginX, panelHeight - panelMarginY - (n - 1) * (panelFontSize + panelSpacingY)
end

local function FormatSeconds(timeSecs)
	local h = math.floor(timeSecs / 3600)
	local m = math.floor(math.fmod(timeSecs, 3600) / 60)
	local s = math.floor(math.fmod(timeSecs, 60))

	if (h > 0) then
	timeString = string.format('%02i:%02i:%02i', h, m, s)
	else
	timeString = string.format('%02i:%02i', m, s)
	end

	return timeString
end

local function CreatePanelDisplayList()
	gl.PushMatrix()
	gl.Translate(x1, y1, 0)
	gl.CallList(displayList)
	fontHandler.DisableCache()
	fontHandler.UseFont(panelFont)
	fontHandler.BindTexture()

	fontHandler.DrawStatic(white.."Time survived: "..FormatSeconds(spGetSeconds()), AddNewRow(1))
	fontHandler.DrawStatic(white.."Wave number / time for the next wave", AddNewRow(2))
	fontHandler.DrawStatic(white.."Enemies left in this wave: ", AddNewRow(3))
	fontHandler.DrawStatic(white.."Enemies killed total: ", AddNewRow(4))

	gl.Texture(false)
	gl.PopMatrix()
end

local function Draw()
	if (updatePanel) then
		if (guiPanel) then
			gl.DeleteList(guiPanel)
			guiPanel = nil
		end

		guiPanel = gl.CreateList(CreatePanelDisplayList)
		updatePanel = false
	end

	if (guiPanel) then
		gl.CallList(guiPanel)
	end

end

local function UpdateRules()
	if (not gameInfo) then
		gameInfo = {}
	end

	updatePanel = true
end

--------------
-- Call-ins --
--------------

function widget:Initialize()
	fontHandler.UseFont(panelFont)

	displayList = gl.CreateList(function()
		gl.Color(1, 1, 1, 1)
		gl.Texture(panelTexture)
		gl.TexRect(0, 0, panelWidth, panelHeight)
	end)

	UpdateRules()
end

function widget:Shutdown()
	fontHandler.FreeFont(panelFont)
	fontHandler.FreeFont(waveFont)

	if (guiPanel) then
		gl.DeleteList(guiPanel)
		guiPanel = nil
	end

	gl.DeleteList(displayList)
	gl.DeleteTexture(panelTexture)

end

function widget:GameFrame(n)
	if (n%30 < 1) then
		UpdateRules()
	end
end

function widget:DrawScreen()
	x1 = math.floor(x1 - viewSizeX)
	y1 = math.floor(y1 - viewSizeY)
	viewSizeX, viewSizeY = gl.GetViewSizes()
	x1 = viewSizeX + x1
	y1 = viewSizeY + y1

	Draw()
end

function widget:MouseMove(x, y, dx, dy, button)
	if (isPanelMoved) then
		x1 = x1 + dx
		y1 = y1 + dy
		updatePanel = true
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

function widget:ViewResize(vsx, vsy)
	x1 = math.floor(x1 - viewSizeX)
	y1 = math.floor(y1 - viewSizeY)
	viewSizeX, viewSizeY = vsx, vsy
	x1 = viewSizeX + x1
	y1 = viewSizeY + y1
end
