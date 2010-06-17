------ -- -
function widget:GetInfo()
	return {
	name = "Deck GUI",
	desc = "Two simple clickable decks",
	author = "kap89",
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

--------------
-- settings --
--------------
local settings = {
	cardsize_x = 100,
	cardsize_y = 170,
	pos_x,
	pos_y,
}

----------------
-- local vars --
----------------
local window_deck
local stack_deck
local two_decks = {}
local hoveredCard

---------------------
-- local functions --
---------------------
local function MakeHandMenu()

	if window_deck then
		window_deck:Dispose()
		window_deck = nil
	end

	local vsx, vsy = widgetHandler:GetViewSizes()
	local deck_width = 400
	local deck_height = 300
	local deck_pos_x = settings.pos_x or 0.5 * vsx - deck_width * 0.5
	local deck_pos_y = settings.pos_y or 0.05 * vsy - deck_height * 0.5
	
	stack_deck = StackPanel:New{
		name='stack_deck',
		orientation = 'horizontal',
		width = deck_width,
		height = deck_height,
		resizeItems = false,
		padding = {-50,10,0,0},
		itemPadding = {10,0,0,0},
		itemMargin = {0,0,0,0},
		children = {}
	}

	window_deck = Window:New {  
		caption="Decks",
		x = deck_pos_x,
		y = deck_pos_y,
		dockable = true,
		name = "carddeck",
		width = deck_width,
		height = deck_height,
		draggable = true,
		resizable = true,
		OnMouseUp = {},
		backgroundColor = color.main_bg,
		
		children = {
			stack_deck,
		}

	}
	screen0:AddChild(window_deck)
end

local function SendCardToHand(button)
	if not (Darius:CanDraw()) then
		spEcho("You need more Greenballs")
		return
	end
	if (button.deck.name == "Deck1") then
		--spEcho("Deck1")
		Darius:Draw(1)
	elseif (button.deck.name == "Deck2") then
		--spEcho("Deck2")
		Darius:Draw(2)
	end
end

local function DrawDeck()
	if not (stack_deck) then
		return
	end
	stack_deck.children = {}

	if not (two_decks) then
		return
	end
	for _, deck in pairs(two_decks) do
		-- Create a button for deck
		table.insert(stack_deck.children,
			Button:New {
				caption = "",
				deck = deck,
				height = settings.cardsize_y + 20,
				width = settings.cardsize_x + 20,
				OnMouseUp = { 
					function(self)
						SendCardToHand(self)
					end
				},
				backgroundColor = color.game_bg,
				textColor = color.game_fg,
				children = { 
					Label:New {
						caption = deck.name,
					},
					--Image:New {
						--file = deck.img,
						--width = settings.cardsize_x,
						--height = settings.cardsize_y,
						--keepAspect = false,
					--},
				}
			})
	end
	--Force the window to be redrawn
	window_deck:Invalidate()
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

	 two_decks = { 
	 	{name = "Deck1"  , img = 'LuaUI/images/deck1.png'},
	 	{name = "Deck2"  , img = 'LuaUI/images/deck2.png'},
	 }
	 
	 
	MakeHandMenu()
	DrawDeck()
	widget:ViewResize(Spring.GetViewGeometry())
end

function widget:GetConfigData()
	if (window_deck) then
		settings.pos_x = window_deck.x
		settings.pos_y = window_deck.y
	end
	return settings
end

function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		settings = data
	end
end

function widget:ViewResize(viewSizeX, viewSizeY)
end

function widget:MousePress(x, y, button)
end

function widget:Update()
end

function widget:DrawScreen()
end

function widget:Shutdown()
	spEcho( "Deck widget OFF" )
	if (window_deck) then
		screen0:RemoveChild(window_deck)
		window_deck:Dispose()
	end
end

----------------------------------
--Turns out, Chili handles these--
----------------------------------
--function widget:IsAbove(x, y)
--	local vsx, vsy = widgetHandler:GetViewSizes()
--	local x = x - window_deck.x
--	local y = vsy - y
--	y = y - window_deck.y
--	hoveredCard = window_deck:HitTest(x, y)
--	return not (hoveredCard == nil)
--end

--function widget:GetTooltip(x, y)
--end

