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
local spEcho = Spring.Echo

-- Chili Stuff
local VFSMODE      = VFS.RAW_FIRST
local file = LUAUI_DIRNAME .. "Configs/crudemenu_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color = confdata.color

WhiteStr   = "\255\255\255\255"
GreyStr    = "\255\210\210\210"
GreenStr   = "\255\092\255\092"
OrangeStr  = "\255\255\190\128"
RedStr     = "\255\255\170\170"

--------------
-- settings --
--------------
local settings = {
	cardsize_x = 140,
	cardsize_y = 200,
	pos_x,
	pos_y,
}

----------------
-- local vars --
----------------
local window_hand
local stack_hand

-- The cards in the player's hand
local old_cards_in_hand = {}
local cards_in_hand = {}

---------------------
-- local functions --
---------------------
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

	stack_hand = StackPanel:New{
		name='stack_hand',
		orientation = 'horizontal',
		width = hand_width,
		height = hand_height,
		resizeItems = false,
		padding = {0,10,0,0},
		itemPadding = {0,0,0,0},
		itemMargin = {0,0,0,0},
		children = {}
	}

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
			stack_hand,
		}
	}
	screen0:AddChild(window_hand)
end

local function HandChanged()
	stack_hand.children = {}
	for _, card in pairs(cards_in_hand) do
		table.insert(stack_hand.children,
			Button:New {
				caption = "",
				card = card,
				height = settings.cardsize_y + 20,
				width = settings.cardsize_x + 20,
				OnMouseUp = {
					function(self)
						spEcho(card.name)
					end
				},
				backgroundColor = color.game_bg,
				textColor = color.game_fg,
				children = { 
					Label:New {
						caption = card.name,
					},
					Image:New {
						file = card.img,
						width = settings.cardsize_x,
						height = settings.cardsize_y,
						keepAspect = false,
					},
				}
			})
	end
end

local function UpdateHand()
	if (cards_in_hand == old_cards_in_hand) then
	else
		old_cards_in_hand = cards_in_hand --TODO: Get current hand
		HandChanged()
	end
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

	--Testing card data
	cards_in_hand = {
		{name = "Metal"    , type = "Material", img = 'LuaUI/images/ibeam.png'},
		{name = "Metal"    , type = "Material", img = 'LuaUI/images/ibeam.png'},
		{name = "Metal"    , type = "Weapon"  , img = 'LuaUI/images/ibeam.png'},
		{name = "Fire"     , type = "Weapon"  , img = 'LuaUI/images/energy.png'},
		{name = "Lightning", type = "Weapon"  , img = 'LuaUI/images/energy.png'},
	}

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
	HandChanged()
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
	local x = x - window_hand.x
	local y = vsy - y
	y = y - window_hand.y
	return window_hand:HitTest(x, y)
end

local function oldAbove()
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
	local vsx, vsy = widgetHandler:GetViewSizes()
	local x = x - window_hand.x
	local y = vsy - y
	y = y - window_hand.y
	obj = window_hand:HitTest(x, y)
	if (obj.card) then -- If we are over a button with card data
		local name   = obj.card.name   or "Unknown"
		local type   = obj.card.type   or "Unknown"
		local health = obj.card.health or 0
		local range  = obj.card.range  or 0
		local damage = obj.card.damage or 0
		return WhiteStr  .. "Name: "   .. name   .. "\n" ..
			 GreyStr   .. "Type: "   .. type   .. "\n" ..
			 GreenStr  .. "Health: " .. health .. "\n" ..
			 OrangeStr .. "Range: "  .. range  .. "\n" ..
			 RedStr    .. "Damage: " .. damage	
	end
	return
end

function widget:MousePress(x, y, button)
end

function widget:Update()
	UpdateHand()
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
