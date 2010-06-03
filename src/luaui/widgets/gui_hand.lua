------ -- -
function widget:GetInfo()
	return {
	name = "Card Hand GUI",
	desc = "Displays the player's hand",
	author = "xcompwiz",
	date = "May 6, 2010",
	license = "GNU GPL, v2 or later",
	layer = 0,
	enabled = true
	}
end

--------------
-- Speed Up --
--------------
local Echo = Spring.Echo
local vsx, vsy

----------------
-- local vars --
----------------
local POSITION_X = 0.5 -- horizontal centre of screen
local POSITION_Y = 0.05 -- near bottom

---------------------
-- local functions --
---------------------
local function MouseOverCard(x, y)
	return 0
end

--------------
-- Call-ins --
--------------
function widget:Initialize()
	Echo( "Hand widget ON" )

--	if (not WG.Chili) then
--		widgetHandler:RemoveWidget(widget)
--		return
--	end

	-- setup Chili
--	 Chili = WG.Chili
--	 Button = Chili.Button
--	 Label = Chili.Label
--	 Window = Chili.Window
--	 ScrollPanel = Chili.ScrollPanel
--	 StackPanel = Chili.StackPanel
--	 Grid = Chili.Grid
--	 TextBox = Chili.TextBox
--	 Image = Chili.Image
--	 screen0 = Chili.Screen0

	widget:ViewResize(Spring.GetViewGeometry())
end

function widget:GetConfigData()
	return {
	position_x = POSITION_X,
	position_y = POSITION_Y
	}
end

function widget:SetConfigData(data)
	POSITION_X = data.position_x or POSITION_X
	POSITION_Y = data.position_y or POSITION_Y
end

function widget:ViewResize(viewSizeX, viewSizeY)
	vsx = viewSizeX
	vsy = viewSizeY
end

function widget:IsAbove(x, y)
	if MouseOverCard(x, y) == -1 then
		return false
	else
		return true
	end
end

function widget:GetTooltip(x, y)
  return "Basic tool tip\n"
end

function widget:MousePress(x, y, button)
end

function widget:Update()
end

function widget:DrawScreen()
end

function widget:UnitCreated(unitID, unitDefID, unitTeam)
	Echo( "Hello Unit " .. unitID )
end

function widget:Shutdown()
	Echo( "Hand widget OFF" )
end
