function widget:GetInfo()
	return {
		name      = "The deck editor",
		desc      = "Used to edit and create the player's decks",
		author    = "Ziggurat",
		date      = "July 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = false,  --  loaded by default
	}
end


local spSendLuaRulesMsg = Spring.SendLuaRulesMsg
local spEcho = Spring.Echo

-- Data Storage
local cardPool = {}
local decks = {}--Cards are stored only by card name
local latestCard = {}--Cache for the latest card fetched from the pool
local drawCardButton = false --Used by the UpdateDeckEditorUI to see when the card button needs to be drawn for the first time
local maxCardAmount = 0

-- UI handles
local deckEditorStack = nil
local deckEditorWindow = nil
local cardPoolLabels = {}

-- Data flags
local poolReceived = false
local decksReceived = false

local VFSMODE      = VFS.RAW_FIRST
local file = LUAUI_DIRNAME .. "Configs/crudemenu_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color = confdata.color



function table.isempty(t)
	for k, v in pairs(t) do
		return false
	end

	return true
end

function string.totable(s)
	local t = {}        -- table to collect fields
	if (not s) then return t end
	--Strip outer brackets
	if (s:sub(1,1) == '{') then s = s:sub(2) end
	while (s:sub(-1,-1) == ',') do s = s:sub(1, -2) end
	if (s:sub(-1,-1) == "}") then s = s:sub(1, -2) end
	while (s:sub(-1,-1) == ',') do s = s:sub(1, -2) end
	s = s .. ','        -- add ending comma
	--if (debug_message) then debug_message("String to Table: " .. s) end
	local fieldstart = 1
	while (fieldstart < string.len(s)) do
		-- next field is table? (starts with '{'?)
		if (s:sub(fieldstart, fieldstart) == '{') then
			local i
			-- find closing bracket
			i = s:find("}", fieldstart+1) --NOTE: second table inside causes problems
			if not i then error('unmatched bracket') end

			local f = s:sub(fieldstart+1, i-1)
			table.insert(t, string.totable(f))
			fieldstart = s:find(",", i) + 1
		else -- find next comma
			local nexti = s:find(',', fieldstart)
			local f = s:sub(fieldstart, nexti-1)
			local k, v = f:match("(%w+) = (%w+)")
			if not v then
				--if (debug_message) then debug_message("field: " .. f) end
				if (f ~= "") then table.insert(t, f) end --TODO: Trim string
			else
				--if (debug_message) then debug_message("field: " .. f .. "=>" .. tostring(k) .. " = " .. tostring(v)) end
				t[k] = v -- => t['str'] = val.  TODO: Remove ''s
			end
			fieldstart = nexti + 1
		end
	end
	return t
end








local function GenerateOccuranceTable(t)
	local occuranceTable = {}

	for i = 1, #t do

		if occuranceTable[t[i]] == nil then
			--This is the first occurance of this card
			occuranceTable[t[i]] = 1
		else
			--Not the first occurance => increase the counter
			occuranceTable[t[i]] = occuranceTable[t[i]] + 1
		end
	end

	return occuranceTable
end

-----------------------
-- Interface helpers --
-----------------------
local function GenerateDecksString()
	local decksString = "{"

	for i = 1, #decks do

		decksString = decksString .. "{"

		for j = 1, #decks[i] do

			if decks[i][j] == nil then
				--The card name is nil => it has been removed from the deck => no operations required
			else
				--We have a card => append it to the deck string
				decksString = decksString .. decks[i][j] .. ","
			end
		end

		decksString = decksString .. "},"
	end

	decksString = decksString .. "}"

	return decksString
end

------------------------------------
-- Interfacing with the card pool --
------------------------------------
local function SendDecks()
	spSendLuaRulesMsg("SetDecks:", GenerateDecksString())
end

local function SendActivatedDecks(id1, id2)
	spSendLuaRulesMsg("SetActiveDecks:" .. id1 .. "," .. id2)
end


local function GetCard(cardName)
	spSendLuaRulesMsg("UnsyncCard:" .. cardName)
end

local function GetDecks()
	spSendLuaRulesMsg("UnsyncDecks")
end

local function GetPool()
	spSendLuaRulesMsg("UnsyncCardPool")
end


local function SetDecks(deckCollection)
	decks = deckCollection
	decksReceived = true
end
local function SetCardPool(pool)
	cardPool = GenerateOccuranceTable(pool)
	spEcho("!!!!!!!!!!Current card pool")
	spEcho(cardPool)
	poolReceived = true
end

local function SetActiveCard(id, name, type, img, health, reloadTime, range, damage, greenballs, desc)
	local newCard = {}

	newCard.id = id
	newCard.name = name
	newCard.type = type
	newCard.img = img
	newCard.health = health
	newCard.reloadTime = reloadTime
	newCard.range = range
	newCard.damage = damage
	newCard.greenballs = greenballs
	newCard.desc = desc

	latestCard = newCard
end

-----------------------
-- Deck Manipulation --
-----------------------
local function AddCardToDeck(cardName, deckID)
	--Add the card to the last place in the deck
	--decks[deckID][#decks[deckID] + 1] = cardName
	table.insert(decks[deckID], cardName)
end

local function RemoveCardFromDeck(cardName, deckID)
	for i = 1, #decks[deckID] do
		--Loops the cards in the specified deck

		if decks[deckID][i] == cardName then
			--The card to be removed was found => set the "card name" as nil
			decks[deckID][i] = nil
			break
		end
	end
end







----------------
-- UI helpers --
----------------
local function GenerateCardLabelString(cardName, amount, space)
	local s = cardName
	space = space or 1

	for i = 1, space do
		s = s .. " "
	end

	s = s .. amount

	return s
end

local function GenerateUIDeckString(deckID)

	local maxNameLenght = 0 --The length of the longest card name in the deck
	local deckString = ""
	local separatingSpaces = 5 --The amount of space between the cardname and amount
	local occuranceTable = GenerateOccuranceTable(decks[deckID]) --Stores (cardName, amount) pairs

	--Find the longest card name:
	for k, _ in pairs(occuranceTable) do
		if string.len(k) > maxNameLenght then
			maxNameLenght = string.len(k)
		end
	end

	--TODO sort the occurance table alphabetically


	--Generate the actual string:
	for cardName, amount in pairs(occuranceTable) do
		deckString = deckString .. cardName

		for i = string.len(cardName), maxNameLenght + separatingSpaces do
			deckString = deckString .. " "
		end

		deckString = deckString .. amount .. "\n"
	end

	return deckString
end

local function SetUpHandles()
	-- Obtain Darius handle
	Darius = WG.Darius

	-- Obtain Chili handles
	Chili = WG.Chili
	Button = Chili.Button
	Label = Chili.Label
	Window = Chili.Window
	ScrollPanel = Chili.ScrollPanel
	StackPanel = Chili.StackPanel
	Grid = Chili.Grid
	TextBox = Chili.TextBox
	Image = Chili.Image
	Checkbox = Chili.Checkbox
	screen0 = Chili.Screen0
end


------------------
-- UI functions --
------------------
local function TestFunction(i)

	for i = 1, #cardPoolLabels do
		cardPoolLabels[i].font:SetColor(color.game_fg)


	end
	sep = string.find(cardPoolLabels[i].caption, " ")
	GetCard(string.sub(cardPoolLabels[i].caption, 1, sep - 1))


	cardPoolLabels[i].font:SetColor({1,0.5,0,1})
end

local function MakeDeckEditorUI()

	local vsx, vsy = widgetHandler:GetViewSizes()
	local windowWidth = 400
	local windowHeight = 400
	local posX = 300
	local posY = 300

	local labelFontSize = 10

	local label = nil
	local i = 1 -- The index of the label in the cardPoolLabels-array

	for i = 1, maxCardAmount do

		label = Label:New{
					caption = "",
					textColor = color.sub_fg,
					align = "left",
					valign = "left",
					fontSize = labelFontSize,

					OnMouseUp = { function () --We must use a wrapper because we need to use parameters
									TestFunction(i)
								end},
					}

		table.insert(cardPoolLabels, i, label)

		i = i + 1
	end

	cardPoolStack = StackPanel:New{
		x = 1,
		y = 1,
		height = maxCardAmount * labelFontSize,
		name = 'cardPoolstack',
		orientation = 'vertical',

		children = cardPoolLabels,
	}

	selectedDeckStack = StackPanel:New{
		name = 'selectedDeckStack',
		orientation = 'vertical',

		children = {-- TODO add card labels for the cards in the deck
		},
	}

	cardLabelStack = StackPanel:New{
		x = 1,
		y = 1,
		name = 'cardLabelStack',
		orientation = 'vertical',

		children = {
		},
	}
	cardLabelStack:AddChild(cardPoolStack)
	cardLabelStack:AddChild(cardLabelStack)

	deckEditorStack = StackPanel:New{
		name='deckEditorStack',
		orientation = 'horizontal',
		width = windowWidth,
		height = windowHeight,
		resizeItems = true,
		padding = {0,10,0,0},
		itemPadding = {0,0,0,0},
		itemMargin = {0,0,0,0},
		children = {
		}

	}
	deckEditorStack:AddChild(cardLabelStack)

	deckEditorWindow = Window:New {
		caption="Deck Editor",
		x = posX,
		y = posY,
		dockable = false,
		name = "deckEditorWindow",
		clientWidth = windowWidth,
		clientHeight = windowHeight,
		draggable = true,
		resizable = true,
		children = {
			deckEditorStack,
		}
	}
	screen0:AddChild(deckEditorWindow)
end


local function UpdateDeckEditorUI()

	if decksReceived and poolReceived then -- Both the deck and pool data have arrived => finish the UI

		decksReceived = false
		poolReceived = false

		i = 1 -- Used to index the cardPoolLabels-array

		for cardName, amount in pairs(cardPool) do

			cardPoolLabels[i]:SetCaption(GenerateCardLabelString(cardName, amount))

			i = i + 1
		end

	end


	if table.isempty(latestCard) then

		GetCard("Fire")
		drawCardButton = true

	else
		for i = 1, #deckEditorStack.children do

			if deckEditorStack.children[i].card then
				-- The child has a card => we assume this is the card button

				if deckEditorStack.children[i].card.name ~= latestCard.name then
					-- The name in the button is different from the one in the activated card => a new card has been activated and it needs a new button

						deckEditorStack.children[i].card = latestCard
						deckEditorStack.children[i]:UpdateCard(240, 400)

				else
					-- The names are the same => the active card has not changed => it's enough to update the old button
					deckEditorStack.children[i]:UpdateCard(240, 400)
				end
			end
		end

		if drawCardButton then
			--The first time the card button needs to be drawn for the first time
			drawCardButton = false
			local cardButton = Darius:GetCardButton(latestCard, 240, 400)
			deckEditorStack:AddChild(cardButton)
		end
	end

	if deckEditorWindow then
		deckEditorWindow:Invalidate()
	end
end

local function AdjustWindow()
	if deckEditorWindow then
		deckEditorStack.height = deckEditorWindow.height
		deckEditorStack.widh = deckEditorWindow.widh
	end
end



---------------------
-- Widget call-ins --
---------------------
function widget:Initialize()
	widgetHandler:RegisterGlobal("SetDeckEditorCardPool" , SetCardPool)--This is the one the gadget should call
	widgetHandler:RegisterGlobal("SetDeckEditorDecks", SetDecks)
	widgetHandler:RegisterGlobal("SetDeckEditorActiveCard", SetActiveCard)

	maxCardAmount = Spring.GetGameRulesParam("maximumcardamount") --Fetch the amount of cards from the pool. Yes, it is *necessary* to do it like this.
	GetDecks()
	GetPool()


	SetUpHandles()
	MakeDeckEditorUI()

	AdjustWindow()
	--UpdateDeckEditorUI()
end

function widget:Update()
	AdjustWindow()
	UpdateDeckEditorUI()
end


