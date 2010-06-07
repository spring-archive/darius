------ -- -
function widget:GetInfo()
	return {
		name = "Card Hand GUI",
		desc = "Displays the players hand",
		author = "xcompwiz",
		date = "June 6, 2010",
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
	cardsize_x = 120,
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
local cards_in_hand = {}
local selectedMaterial = {}
local selectedWeapon = {}
local selectedSpecial = {}

---------------------
-- local functions --
---------------------
local function MakeHandMenu()
	if window_hand then
		window_hand:Dispose()
		window_hand = nil
	end

	-- TODO: Adjust based on ViewSize
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
		resizable = true,
		OnMouseUp = {},
		backgroundColor = color.main_bg,

		children = {
			stack_hand,
		}
	}
	screen0:AddChild(window_hand)
end

local function ActivateCard(button)
	Darius:ActivateCard(button.card)
end

local function GetHand()
	return Darius:GetHand()
end

local function GetSelectedMaterial()
	return Darius:GetSelectedMaterial()
end

local function GetSelectedWeapon()
	return Darius:GetSelectedWeapon()
end

local function GetSelectedSpecial()
	return Darius:GetSelectedSpecial()
end

local function UpdateHand()
	--Update the local variables
	cards_in_hand    = GetHand()
	selectedMaterial = GetSelectedMaterial()
	selectedWeapon   = GetSelectedWeapon()
	selectedSpecial  = GetSelectedSpecial()

	if not (stack_hand) then return end
	if not (cards_in_hand) then return end

	-- Decrease stack size to match the hand size if necessary
	while (#stack_hand.children > #cards_in_hand) do
		table.remove(stack_hand.children)
	end
	for index, card in pairs(cards_in_hand) do
		--Determine highlighting
		local background = color.game_bg
		if (card == selectedSpecial) then
			background = color.blue
		elseif (card == selectedMaterial or card == selectedWeapon) then
			background = color.game_fg
		end
		--Create tooltip
		local name   = card.name     or "Unknown"
		local type   = card.type     or "Unknown"
		local health = card.health   or 0
		local rate   = card.firerate or 0
		local range  = card.range    or 0
		local damage = card.damage   or 0
		local tooltip = WhiteStr  .. "Name: "     .. name   .. "\n" ..
				    GreyStr   .. "Type: "     .. type   .. "\n" ..
				    GreenStr  .. "Health: "   .. health .. "\n" ..
				    YellowStr .. "Firerate: " .. rate   .. "\n" ..
				    OrangeStr .. "Range: "    .. range  .. "\n" ..
				    RedStr    .. "Damage: "   .. damage
		-- if not enough buttons, create a new one
		if not (stack_hand.children[index]) then
			local image = Image:New{}
			table.insert(stack_hand.children, Button:New{children = {image}})
		end
		-- Get button for the card
		button = stack_hand.children[index]
		button.caption = ""
		button.card = card
		button.height = settings.cardsize_y + 20
		button.width = settings.cardsize_x + 20
		button.OnMouseUp = {
				function(self)
					ActivateCard(self)
				end
			}
		button.tooltip = tooltip
		button.backgroundColor = background
		button.textColor = color.game_fg
		if ((button.children[1].file ~= card.img) or
		    (button.children[1].width ~= settings.cardsize_x) or
		    (button.children[1].height ~= settings.cardsize_y)) then
			button.children[1] = Image:New {
				file = card.img,
				width = settings.cardsize_x,
				height = settings.cardsize_y,
				keepAspect = false,
			}
		end
	end
	--Force the window to be redrawn
	stack_hand:Invalidate()
end

local function oldUpdateHand()
	local new_hand = GetHand()
	local new_material = GetSelectedMaterial()
	local new_weapon = GetSelectedWeapon()
	local new_special = GetSelectedSpecial()
	if ((cards_in_hand ~= new_hand) or
	   (selectedMaterial ~= new_material) or
	   (selectedWeapon   ~= new_weapon  ) or
	   (selectedSpecial  ~= new_special )) then
		cards_in_hand    = new_hand
		selectedMaterial = new_material
		selectedWeapon   = new_weapon
		selectedSpecial  = new_special
		spEcho("Redrawing hand")
		--DrawHand()
	end
end

--------------
-- Call-ins --
--------------
function widget:Initialize()
	spEcho( "Hand widget ON" )

	if (not WG.Chili) or (not WG.Darius) then
		widgetHandler:RemoveWidget(widget)
		return
	end

	-- Setup Darius
	Darius = WG.Darius

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
	UpdateHand()
end

function widget:ViewResize(viewSizeX, viewSizeY)
	--TODO: Make adjust
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

function widget:Update()
	UpdateHand()
end

function widget:Shutdown()
	spEcho( "Hand widget OFF" )
	if (window_hand) then
		screen0:RemoveChild(window_hand)
		window_hand:Dispose()
	end
end
