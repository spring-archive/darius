function widget:GetInfo()
	return {
		name = "Card Hand GUI",
		desc = "Displays the players hand",
		author = "xcompwiz",
		date = "June 6, 2010",
		license = "GNU GPL, v2 or later",
		layer = 100,
		enabled = true
	}
end

--------------
-- Speed Up --
--------------
local spEcho = Spring.Echo

--------------
-- settings --
--------------
local settings = {
	cardsize_x = 120,
	cardsize_y = 200,
	pos_x,
	pos_y,
	width,
	height,
}

----------------
-- local vars --
----------------
local window_hand
local stack_hand

-- The cards in the player's hand
local cards_in_hand = {}

---------------------
-- local functions --
---------------------
local function AdjustWindow()
	vsx, vsy, _, _ = Spring.GetViewGeometry()
	if not (window_hand) then return end
	stack_hand.width = window_hand.width
	stack_hand.height = window_hand.height
	local max_width = (window_hand.width - 60)/#cards_in_hand
	local max_height = window_hand.height - 60
	settings.cardsize_y = max_height
	settings.cardsize_x = settings.cardsize_y * 0.6
	if (settings.cardsize_x > max_width) then
		settings.cardsize_x = max_width
		settings.cardsize_y = max_width / 0.6
	end

	if (window_hand.x < 0) then
		window_hand.x = 0
	end
	if (window_hand.y < 0) then
		window_hand.y = 0
	end
	if (window_hand.x > vsx - window_hand.width) then
		window_hand.x = vsx - window_hand.width
	end
	if (window_hand.y > vsy - window_hand.height) then
		window_hand.y = vsy - window_hand.height
	end

	-- Force redraw
	stack_hand:UpdateLayout()
	stack_hand:Invalidate()
end

local function MakeHandMenu()
	if (window_hand) then
		window_hand:Dispose()
		window_hand = nil
	end

	local vsx, vsy = widgetHandler:GetViewSizes()
	local hand_width = settings.width or settings.cardsize_x * 5
	local hand_height = settings.height or (settings.cardsize_y + 50)
	local hand_pos_x = settings.pos_x or 0.5 * vsx - hand_width * 0.5
	local hand_pos_y = settings.pos_y or 0.05 * vsy + hand_height * 0.5

	stack_hand = StackPanel:New{
		name='stack_hand',
		orientation = 'horizontal',
		width = -1,
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
		dockable = false,
		name = "hand_window",
		clientWidth = hand_width,
		clientHeight = hand_height,
		draggable = true,
		resizable = true,
		children = {
			stack_hand,
		}
	}
	screen0:AddChild(window_hand)
end

local function ActivateCard(button)
	Spring.PlaySoundFile("sounds/ui/click.wav")
	Darius:ActivateCard(button.card)
end

local function GetHand()
	return Darius:GetHand()
end

local function UpdateHand()
	--Update the local variables
	cards_in_hand    = GetHand()

	if not (stack_hand) then return end
	if not (cards_in_hand) then return end

	-- Decrease stack size to match the hand size if necessary
	while (#stack_hand.children > #cards_in_hand) do
		table.remove(stack_hand.children)
	end
	for index, card in pairs(cards_in_hand) do
		-- if the button doesn't exist, create a new one, otherwise update the existing one
		if not (stack_hand.children[index]) then
			local button = Darius:GetCardButton(card, settings.cardsize_x, settings.cardsize_y)
			button.OnMouseUp = {function(self) ActivateCard(self) end}
			table.insert(stack_hand.children, button)
		else
			stack_hand.children[index].card = card
			stack_hand.children[index]:UpdateCard(settings.cardsize_x, settings.cardsize_y)
		end
	end
	--Force the window to be redrawn
	window_hand:Invalidate()
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
	AdjustWindow()
	UpdateHand()
end

function widget:ViewResize(viewSizeX, viewSizeY)
end

function widget:GetConfigData()
	if (window_hand) then
		settings.height = window_hand.height - 25
		settings.width  = window_hand.width - 25
		settings.pos_x  = window_hand.x
		settings.pos_y  = window_hand.y
	end
	return settings
end

function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		settings = data
	end
end

function widget:Update()
	AdjustWindow()
	UpdateHand()
end

function widget:Shutdown()
	spEcho( "Hand widget OFF" )
	if (window_hand) then
		screen0:RemoveChild(window_hand)
		window_hand:Dispose()
		window_hand = nil
	end
end
