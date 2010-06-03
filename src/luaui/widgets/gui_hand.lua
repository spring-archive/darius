------ -- -
function widget:GetInfo()
	return {
	name = "Card Hand GUI",
	desc = "Displays the player's hand",
	author = "xcompwiz",
	date = "May 6, 2010",
	license = "GNU GPL, v2 or later",
	layer = 1000,
	enabled = true
	}
end

--------------
-- Speed Up --
--------------
local spEcho = Spring.Echo

-- Chili Stuff
local VFSMODE      = VFS.RAW_FIRST
local file = LUAUI_DIRNAME .. "Configs/crudemenu_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color = confdata.color

--------------
-- settings --
--------------
local settings = {
	cardsize_x = 100,
	cardsize_y = 200,
	pos_x,
	pos_y,
}

----------------
-- local vars --
----------------
local window_hand

---------------------
-- local functions --
---------------------
-- Drawing --
local function MakeHandMenu()
	if window_hand then
		window_hand:Dispose()
		window_hand = nil
	end

	local vsx, vsy = widgetHandler:GetViewSizes()
	local hand_width = 900
	local hand_height = 250
	local hand_pos_x = settings.pos_x or 0.5 * vsx - hand_width * 0.5
	local hand_pos_y = settings.pos_y or 0.05 * vsy - hand_height * 0.5

	lbl_fps = Label:New{ name='lbl_fps', caption = 'FPS:', textColor = color.sub_header,  }
	lbl_gtime = Label:New{ name='lbl_gtime', caption = 'Time:', textColor = color.sub_header, align="center" }

	window_hand = Window:New {  
		caption="Hand",
		x = hand_pos_x,
		y = hand_pos_y,
		dockable = true,
		name = "cardhand2",
		clientWidth = hand_width,
		clientHeight = hand_height,
		draggable = true,
		resizable = false,
		OnMouseUp = {},
		backgroundColor = color.main_bg,

		children = {
			StackPanel:New{
				name='stack_main',
				orientation = 'horizontal',
				width = hand_width,
				height = hand_height,
				resizeItems = false,
				padding = {0,0,0,0},
				itemPadding = {2,0,0,0},
				itemMargin = {0,0,0,0},
				children = {
				}
			}
		}
	}
	screen0:AddChild(window_hand)
end

--------------
-- Call-ins --
--------------
function widget:Initialize()
	spEcho( "Hand widget ON" )

	if (not WG.Chili) then
		widgetHandler:RemoveWidget(widget)
		return
	end

	-- setup Chili
	 Chili = WG.Chili
	 Button = Chili.Button
	 Label = Chili.Label
	 Window = Chili.Window
	 ScrollPanel = Chili.ScrollPanel
	 StackPanel = Chili.StackPanel
	 Grid = Chili.Grid
	 TextBox = Chili.TextBox
	 Image = Chili.Image
	 screen0 = Chili.Screen0

	MakeHandMenu()
	widget:ViewResize(Spring.GetViewGeometry())
end

function widget:GetConfigData()
	if (window_hand) then
		settings.pos_x = window_hand.x
		settings.pos_y = window_hand.y
	end
	return settings
end

function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		--settings = data
	end
end

function widget:ViewResize(viewSizeX, viewSizeY)
end

function widget:IsAbove(x, y)
	local vsx, vsy = widgetHandler:GetViewSizes()
	y = vsy - y
	if (window_hand) then
		if (x >= window_hand.x and x < window_hand.x + window_hand.width) then
			--spEcho("(" .. x .. ", " .. y .. ")  [" .. window_hand.y .. ", " .. window_hand.y + window_hand.height .. "]")
			if (y >= window_hand.y and y < window_hand.y + window_hand.height) then
				return true
			end
		end
	end
	return false
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

function widget:Shutdown()
	spEcho( "Hand widget OFF" )
	if (window_hand) then
		screen0:RemoveChild(window_hand)
		window_hand:Dispose()
	end
end
