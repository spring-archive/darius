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
local cardPool = {}         -- Card pool is stored as (cardName, amount) -pairs e.g. cardPool["Fire"] = 5 The pool has five fire cards

local decks = {}            -- Decks are stored as ana array of (cardName, amount) -pairs e.g. decks[2]["Fire"] = 3 Deck number 2 has 3 fore cards

local latestCard = {}       --Cache for the latest card fetched from the pool

local drawCardButton = false--Used by the UpdateDeckEditorUI to see when the card button needs to be drawn for the first time

local maxCardAmount = 0
local selectedCardName = ""  -- Name of the latest selected card
local selectedDeckIndex = 1   -- Index of the deck that is currently under edit

-- UI handles
local deckEditorStack = nil
local deckEditorWindow = nil
local cardPoolLabels = {}
local selectedDeckLabels = {}

-- Data flags
local poolHasChanged = false
local decksHaveChanged = false


-- Colours are pwetty!
local VFSMODE      = VFS.RAW_FIRST
local file = LUAUI_DIRNAME .. "Configs/crudemenu_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color = confdata.color


function table.tostring(t)
	str = "{"
	i = 0
	for k,v in pairs(t) do
		if (type(v) == "table") then --Next level needed for effects
			str = str .. k.. " = '" .. table.tostring(v) .. "', "
		else
			str = str .. k.. " = '" .. v .. "', "
		end
	end
	str = str .. "}"
	return str
end
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
			--This is the first occurance => set amount to 1
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

		for cardName, amount in pairs(decks[i]) do

			for j = 1, amount do
				decksString = decksString .. cardName
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

	for i = 1, #deckCollection do
		table.insert(decks, i, GenerateOccuranceTable(deckCollection[i]))
	end

	decksHaveChanged = true
end
local function SetCardPool(pool)
	cardPool = GenerateOccuranceTable(pool)
	poolHasChanged = true
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
local function AddCardToDeck(cardName, deckID, amount)
	amount = amount or 1

	if decks[deckID][cardName] then
		-- Thare is already atleast one card of this type in the deck => increase it's amount
		decks[deckID][cardName] = decks[deckID][cardName] + amount

	else
		-- This is the first card of this kind to be added to the deck => insert it
		decks[deckID][cardName] = amount
	end

	-- Re-draw decks
	decksHaveChanged = true
end

local function RemoveCardFromDeck(cardName, deckID, amount)
	amount = amount or 1

	if decks[deckID][cardName] then
		-- The card is in the deck => decrease it's counter
		decks[deckID][cardName] = decks[deckID][cardName] - amount

		-- If the amount falls below zero remove the card all together
		if decks[deckID][cardName] <= 0 then
			decks[deckID][cardName] = nil
		end
	end

	-- Re-draw decks
	decksHaveChanged = true
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
local function RunOnCardPoolLabelClick(i)

	for i = 1, #cardPoolLabels do
		-- Remove the colouring from the other labels
		cardPoolLabels[i].font:SetColor(color.game_fg)
	end

	-- Extract the card name from the label caption
	local sep = string.find(cardPoolLabels[i].caption, " ")
	local cardName = string.sub(cardPoolLabels[i].caption, 1, sep - 1)

	-- Fetch the card from the pool
	GetCard(cardName)

	-- Color the label (current color is orange)
	cardPoolLabels[i].font:SetColor({1,0.5,0,1})

	-- Set the card as active
	selectedCardName = cardName
end

local function RunOnCardButtonClick(button)
	AddCardToDeck(button.card.name, selectedDeckIndex, 4)
end

local function MakeDeckEditorUI()

	local vsx, vsy = widgetHandler:GetViewSizes()
	local windowWidth = 500
	local windowHeight = 500
	local posX = 300
	local posY = 300

	local labelFontSize = 10

	local label = nil


	-- Generate the card pool labels
	for i = 1, maxCardAmount do

		label = Label:New{
					caption = "",
					textColor = color.sub_fg,
					align = "left",
					valign = "left",
					fontSize = labelFontSize,

					OnMouseUp = {function () --We must use a wrapper because we need to use i as a parameter
									RunOnCardPoolLabelClick(i)
								end},
					}

		table.insert(cardPoolLabels, i, label)
	end

	-- Generate the card labels for the activated deck
	for i = 1, maxCardAmount do

		label = Label:New{
					caption = "",
					textColor = color.sub_fg,
					align = "left",
					valign = "left",
					fontSize = labelFontSize,

					OnMouseUp = {function()

								end},
					}

		table.insert(selectedDeckLabels, i, label)
	end


	cardPoolLabelStack = StackPanel:New{
		x = 1,
		y = 1,
		width = '100%',
		height = maxCardAmount * labelFontSize,
		bottom = '50%',
		resizeItems = true,
		autosize = true,
		preserveChildrenOrder=true,
		children = cardPoolLabels
	}

	selectedDeckLabelStack = StackPanel:New{
		x = 1,
		y = '50%',
		width = '100%',
		height = maxCardAmount * labelFontSize,
		resizeItems = true,
		autosize = true,
		preserveChildrenOrder = true,
		children = selectedDeckLabels
	}

	cardLabelStack = StackPanel:New{
		x = 1,
		y = 1,
		width = '50%',
		height = '100%',
		resizeItems = true,
		autosize = true,
		preserveChildrenOrder = true,

		children = {cardPoolLabelStack, selectedDeckLabelStack,},
	}

	deckEditorStack = StackPanel:New{
		x = 1,
		y = 1,
		name='deckEditorStack',
		orientation = 'horizontal',
		width = '100%',
		height = '100%',
		resizeItems = true,

		children = {cardLabelStack,},

	}

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

	if poolHasChanged then -- Pool data has arrived => finish the UI

		poolHasChanged = false

		local i = 1 -- Used to index the cardPoolLabels-array

		for cardName, amount in pairs(cardPool) do

			cardPoolLabels[i]:SetCaption(GenerateCardLabelString(cardName, amount))

			i = i + 1
		end

	end

	if decksHaveChanged then -- Rewrite the deck data

		decksHaveChanged = false

		local i = 1

		for cardName, amount in pairs(decks[selectedDeckIndex]) do

			selectedDeckLabels[i]:SetCaption(GenerateCardLabelString(cardName, amount))

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
			-- The first card has been activated => generate the card button
			drawCardButton = false
			local cardButton = Darius:GetCardButton(latestCard, 240, 400)

			cardButton.OnMouseUp = {function(self)
										RunOnCardButtonClick(self)
									end
			}

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

	--AdjustWindow()
	--UpdateDeckEditorUI()
end

function widget:Update()
	--AdjustWindow()
	UpdateDeckEditorUI()
end


