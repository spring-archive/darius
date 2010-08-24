------ -- -
function widget:GetInfo()
	return {
	name = "Deck GUI",
	desc = "Two simple clickable decks",
	author = "kap89/xcompwiz",
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
local file = LUAUI_DIRNAME .. "Configs/gui_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color = confdata.color

--------------
-- settings --
--------------
local settings = {
	cardsize_x = 100,
	cardsize_y = 160,
	pos_x,
	pos_y,
	width,
	height,
}

local defaults = {
	pos_x = -1, --vsx,
	pos_y = -450,
	width = settings.cardsize_x * 2,
	height = settings.cardsize_y + 10,
}

----------------
-- local vars --
----------------
local window_deck
local stack_deck

---------------------
-- local functions --
---------------------
local function DrawFromDeck(deck)
	Spring.PlaySoundFile("sounds/ui/click2.wav")

	if not (Darius:CanDraw()) then
		spEcho("You need more Greenballs")
		Spring.PlaySoundFile("sounds/ui/error.wav")
		return
	end

	if (deck == 1) then
		--spEcho("Deck1")
		Darius:Draw(1)
	elseif (deck == 2) then
		--spEcho("Deck2")
		Darius:Draw(2)
	end
end

local function AdjustWindow()
	vsx, vsy, _, _ = Spring.GetViewGeometry()

	--Calculate card sizes
	if not (window_deck) then return end
	stack_deck.width = window_deck.width
	stack_deck.height = window_deck.height
	local max_width = (window_deck.width - 35)/2
	local max_height = window_deck.height - 35
	settings.cardsize_y = max_height
--	settings.cardsize_x = settings.cardsize_y * 0.6
--	if (settings.cardsize_x > max_width) then
		settings.cardsize_x = max_width
		--settings.cardsize_y = max_width / 0.6
--	end

	--Redraw buttons
	stack_deck:UpdateLayout()
	stack_deck:Invalidate()
	stack_deck.children[1]:UpdateCard(settings.cardsize_x, settings.cardsize_y)
	stack_deck.children[2]:UpdateCard(settings.cardsize_x, settings.cardsize_y)

	--Force window onto screen
	if (window_deck.x < 0) then
		window_deck.x = 0
	end
	if (window_deck.y < 0) then
		window_deck.y = 0
	end
	if (window_deck.x > vsx - window_deck.width) then
		window_deck.x = vsx - window_deck.width
	end
	if (window_deck.y > vsy - window_deck.height) then
		window_deck.y = vsy - window_deck.height
	end
	window_deck:Invalidate()
end

local function MakeWindow()

	if window_deck then
		window_deck:Dispose()
		window_deck = nil
	end

	stack_deck = StackPanel:New{
		name='stack_deck',
		orientation = 'horizontal',
		width = -1,
		height = -1,
		resizeItems = false,
		padding = {0,10,0,0},
		itemPadding = {0,0,0,0},
		itemMargin = {0,0,0,0},
		children = {
			Darius:GetCardButton(nil, settings.cardsize_x, settings.cardsize_y),
			Darius:GetCardButton(nil, settings.cardsize_x, settings.cardsize_y),
		},
	}

	window_deck = Window:New {  
		caption="carddeck",
		x = settings.pos_x or defaults.pos_x,
		y = settings.pos_y or defaults.pos_y,
		name = "deckwindow",
		width = settings.width or defaults.width,
		height = settings.height or defaults.height,
		minWidth  = 100,
		minHeight = 100,
		dockable = false,
		draggable = true,
		resizable = true,
		OnMouseUp = {},
		backgroundColor = color.main_bg,
		children = {
			stack_deck,
		},
	}
	stack_deck.children[1].OnMouseUp = {function(self) DrawFromDeck(1) end}
	stack_deck.children[2].OnMouseUp = {function(self) DrawFromDeck(2) end}
	screen0:AddChild(window_deck)
end

--------------
-- Call-ins --
--------------
function widget:Initialize()
	spEcho( "Deck widget ON" )

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

	MakeWindow()

	Darius:RegisterWidget(widget)
end

function widget:Update()
	AdjustWindow()
end

function widget:ViewResize(viewSizeX, viewSizeY)
	defaults.x = viewSizeX
end

function widget:GetConfigData()
	if (window_deck) then
		settings.pos_x = window_deck.x
		settings.pos_y = window_deck.y
		settings.width = window_deck.width
		settings.height = window_deck.height
	end
	return settings
end

function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		settings = data
	end
end

function widget:Shutdown()
	Darius:RemoveWidget(widget)

	spEcho( "Deck widget OFF" )
	if (window_deck) then
		screen0:RemoveChild(window_deck)
		window_deck:Dispose()
		window_deck = nil
	end
end

-----------------------------
-- Darius Message Handling --
-----------------------------

local function WrapScreen(point, vsa)
	if (point >= 0) then return point end
	return vsa + point
end

function widget:RcvMessage(message)
	if (message == "reset") then
		if (window_deck) then
			window_deck.x = WrapScreen(defaults.pos_x, vsx)
			window_deck.y = WrapScreen(defaults.pos_y, vsy)
			window_deck.width = WrapScreen(defaults.width, vsx)
			window_deck.height = WrapScreen(defaults.height, vsy)
		end
	elseif (message == "show") then
		if (window_deck) then screen0:AddChild(window_deck) end
	elseif (message == "hide") then
		if (window_deck) then screen0:RemoveChild(window_deck) end
	end
end
