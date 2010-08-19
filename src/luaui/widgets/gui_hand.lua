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

local defaults = {
	width = settings.cardsize_x * 5 + 35,
	height = settings.cardsize_y + 35,
	x = 0, --0.5 * vsx - defaults.width * 0.5,
	y = 0, --0.05 * vsy + defaults.height * 0.5,
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
	if not (window_hand) then return end
	vsx, vsy, _, _ = Spring.GetViewGeometry()

	if (window_hand.width > vsx) then
		window_hand.width = vsx
	end
	if (window_hand.height > vsy) then
		window_hand.height = vsy
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

	stack_hand.width = window_hand.width
	stack_hand.height = window_hand.height
	local max_width = (window_hand.width - 35)/#cards_in_hand
	local max_height = window_hand.height - 35
	settings.cardsize_y = max_height
	settings.cardsize_x = settings.cardsize_y * 0.6
	if (settings.cardsize_x > max_width) then
		settings.cardsize_x = max_width
		settings.cardsize_y = max_width / 0.6
	end

	-- Force redraw
	stack_hand:UpdateLayout()
	stack_hand:Invalidate()
	window_hand:Invalidate()
end

local function MakeHandMenu()
	if (window_hand) then
		window_hand:Dispose()
		window_hand = nil
	end

	local hand_width = settings.width or defaults.width
	local hand_height = settings.height or defaults.height
	local hand_pos_x = settings.pos_x or defaults.x
	local hand_pos_y = settings.pos_y or defaults.y

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
		width = hand_width,
		height = hand_height,
		minWidth  = 400,
		minHeight = 100,
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

	Darius:RegisterWidget(widget)
end

function widget:GetConfigData()
	if (window_hand) then
		settings.height = window_hand.height
		settings.width  = window_hand.width
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
	Darius:RemoveWidget(widget)

	spEcho( "Hand widget OFF" )
	if (window_hand) then
		screen0:RemoveChild(window_hand)
		window_hand:Dispose()
		window_hand = nil
	end
end

-----------------------------
-- Darius Message Handling --
-----------------------------

function widget:RcvMessage(message)
	if (message == "reset") then
		if (window_hand) then
			window_hand.x = defaults.x
			window_hand.y = defaults.y
			window_hand.width = defaults.width
			window_hand.height = defaults.height
		end
	elseif (message == "show") then
		if (window_hand) then screen0:AddChild(window_hand) end
	elseif (message == "hide") then
		if (window_hand) then screen0:RemoveChild(window_hand) end
	end
end
