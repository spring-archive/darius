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
YellowStr  = "\255\255\255\152"
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

local hoveredCard

-- The cards in the player's hand
local cards_in_hand = {}
local next_hand = { --For testing changing the hand
	{name = "Metal", type = "Material", img = 'LuaUI/images/ibeam.png'},
	{name = "Fire" , type = "Weapon"  , img = 'LuaUI/images/energy.png'},
	{name = "Heal" , type = "Special" , img = 'bitmaps/gpl/nano.tga'},
	{name = "Nuke" , type = "Special" , img = 'icons/nuke.dds'},
	{name = "Alien", type = "Special" , img = 'LuaUI/images/friendly.png'},
}
next_hand = nil

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
		name = "cardhand",
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

local active_material --TODO: These likely need to move to some backend system
local function ActivateMaterial(button)
	-- Change the currently activated card to normal and force it to be redrawn
	if (active_material) then
		active_material.backgroundColor = color.game_bg
		active_material:Invalidate()
	end

	if (active_material == button) then
		active_material = nil
	else
		active_material = button
	end

	-- Change the background of the selected card
	if (active_material) then
		active_material.backgroundColor = color.game_fg
	end
end

local active_weapon --TODO: These likely need to move to some backend system
local function ActivateWeapon(button)
	-- Change the currently activated card to normal and force it to be redrawn
	if (active_weapon) then
		active_weapon.backgroundColor = color.game_bg
		active_weapon:Invalidate()
	end

	if (active_weapon == button) then
		active_weapon = nil
	else
		active_weapon = button
	end

	-- Change the background of the selected card
	if (active_weapon) then
		active_weapon.backgroundColor = color.game_fg
	end
end

local function ActivateOther(button)
	button.backgroundColor = color.blue --TODO: Do something for the other cards (probably pass them to a syatem elsewhere)
end

local function ActivateCard(button)
	if (button.card) then  --assure the button has card data
	if (button.card.type) then --make sure the card is properly formed
		if (button.card.type == "Material") then
			ActivateMaterial(button)
		elseif (button.card.type == "Weapon") then
			ActivateWeapon(button)
		else
			ActivateOther(button)
		end
	end
	end
end

local function DrawHand()
	if not (stack_hand) then
		return
	end
	stack_hand.children = {}

	if not (cards_in_hand) then
		return
	end
	for _, card in pairs(cards_in_hand) do
		--Create tooltip
		local name   = card.name   or "Unknown"
		local type   = card.type   or "Unknown"
		local health = card.health or 0
		local rate   = card.rate   or 0
		local range  = card.range  or 0
		local damage = card.damage or 0
		local tooltip = 	WhiteStr  .. "Name: "   .. name   .. "\n" ..
					GreyStr   .. "Type: "   .. type   .. "\n" ..
					GreenStr  .. "Health: " .. health .. "\n" ..
					YellowStr .. "Rate: "   .. rate   .. "\n" ..
					OrangeStr .. "Range: "  .. range  .. "\n" ..
					RedStr    .. "Damage: " .. damage
		-- Create a button for the card
		table.insert(stack_hand.children,
			Button:New {
				caption = "",
				card = card,
				height = settings.cardsize_y + 20,
				width = settings.cardsize_x + 20,
				OnMouseUp = { 
					function(self)
						ActivateCard(self)
					end
				},
				tooltip = tooltip,
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
	--Force the window to be redrawn
	window_hand:Invalidate()
end

local function GetHand()
	local hand = next_hand or cards_in_hand
	next_hand = nil
	return hand
end

local function UpdateHand()
	local new_hand = GetHand()
	if (cards_in_hand == new_hand) then
	else
		cards_in_hand = new_hand
		DrawHand()
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
		{name = "Metal"    , type = "Material", img = 'LuaUI/images/ibeam.png' , health =   100, rate = -0.01, range =  10, damage =  0},
		{name = "Metal"    , type = "Material", img = 'LuaUI/images/ibeam.png' , health =   100, rate = -0.01, range =  10, damage =  0},
		{name = "Fire"     , type = "Weapon"  , img = 'LuaUI/images/energy.png', health =  - 10, rate =  1  , range =  50, damage =  5},
		{name = "Fire"     , type = "Weapon"  , img = 'LuaUI/images/energy.png', health =  - 10, rate =  1  , range =  50, damage =  5},
		{name = "Lightning", type = "Weapon"  , img = 'LuaUI/images/energy.png', health =     0, rate =  0.5, range = 100, damage = 10},
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
	DrawHand()
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
	hoveredCard = window_hand:HitTest(x, y)
	return not (hoveredCard == nil)
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
	if (hoveredCard) then
		return hoveredCard.tooltip
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
