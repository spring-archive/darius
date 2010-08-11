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

local decks = {}            -- Decks are stored as ana array of (cardName, amount) -pairs e.g. decks[2]["Fire"] = 3 Deck number 2 has 3 fire cards

local latestCard = {}       --Cache for the latest card fetched from the pool

local drawCardButton = false--Used by the UpdateDeckEditorUI to see when the card button needs to be drawn for the first time

local maxCardAmount = 0
local activatedPoolcard = ""  -- Name of the latest selected card in the pool
local activatedDeckCard = ""  -- Name of tha latest selected card in the selected deck
local selectedDeckIndex = 0   -- Index of the deck that is currently under edit
local cardLabelSpaceCount = 5
local maxDeckAmount = 10

local activatedDeckIndex1 = 0
local activatedDeckIndex2 = 0
local useNext = false

-- UI handles
local deckEditorStack = nil
local deckEditorWindow = nil
local cardPoolLabelStack = nil
local decksLabelStack = nil
local selectedCardButton = nil
local cardPoolLabels = {}
local selectedDeckLabels = {}
local decksLabels = {}
local activeDeckLabel = nil
local activeDeck1Label = nil
local activeDeck2Label = nil
local activeDeckInfoLabel = nil

-- Data flags
local poolHasChanged = false
local decksHaveChanged = false
local deckSelectingview = true -- Tells which view to draw: the deck selection view (true) or the deck editing view(false)
local decksAreOK = false -- Tells if the decks have been checked and found to be OK (true) or if there is something wrong with them(false)

-- Colours are pwetty!
local VFSMODE = VFS.RAW_FIRST
local file = LUAUI_DIRNAME .. "Configs/crudemenu_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color = confdata.color
local orange = {1,0.5,0,1}
local activeColour = "\255\255\128\10"
local acceptiveGreen = "\255\0\255\0"
local redOfDenial = "\255\255\0\0"


function table.tostring(t)
	str = "{"
	i = 0
	for k,v in pairs(t) do
		if (type(v) == "table") then --Next level needed for effects
			str = str .. k.. " = '" .. table.tostring(v) .. "', "
		elseif (type(v) == "function") then --kap89: needed to add this line because I couldn't run maps in main menu
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








function table.copy(t)
	if t == nil then
		return nil
	end

	r = {}
	for k, v in pairs(t) do
		r[k] = v
	end
	return r
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
local function FindLongestKey(t) -- FIXME Does not work (is this even needed?)
	local currentMax = 0

	for k, v in pairs(t) do
		if type(v) == 'table' then
			-- Recursion to subtables
			FindLongestKey(v)

		elseif type(k) == 'string' then
			-- If the key is a string check it's lenght and update the current max if necessary
			if string.len(k) > currentMax then
				currentMax = string.len(k)
			end
		end
	end

	return currentMax
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
				decksString = decksString .. cardName .. ","
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
	spSendLuaRulesMsg("SetDecks:" .. GenerateDecksString())
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
	end

	-- Re-draw decks
	decksHaveChanged = true
end

local function CheckDecks(deckID1, deckID2)

	-- Use the first deck as a base for the calculation (copy is needed, bacause we don't want to brake the existing deck)
	local cardTotals = table.copy(decks[deckID1])

	-- Counts the total amount of each card in the decks supplied
	for cardName, amount in pairs(decks[deckID2]) do

		if cardTotals[cardName] then
			-- The card totals allready has some of these cards => increase the amount
			cardTotals[cardName] = cardTotals[cardName] + amount
		else
			-- These are the first occurances of these cards => create a new value
			cardTotals[cardName] = amount
		end
	end

	-- Check that the card pool has enough cards to support the deck candidates
	for cardName, amount in pairs(cardTotals) do

		-- Check that the card is in the pool and that we have enough of them
		if not cardPool[cardName] or cardPool[cardName] < amount then
			-- Not enough cards to support the decks
			return false
		end

	end

	-- All checks were passed
	return true
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

local function GetLabelByCaption(labelArray, caption)

	for i = 1, #labelArray do

		if string.find(labelArray[i].caption, caption) then
			return labelArray[i]
		end
	end

	return nil
end
local function CheckActivatedDecks()

	-- Check that we have two active decks
	if activatedDeckIndex1 > 0 and activatedDeckIndex2 > 0 then

		-- Check if the decks are valid and save the result
		decksAreOK = CheckDecks(activatedDeckIndex1, activatedDeckIndex2)
	end
end
------------------
-- UI functions --
------------------
local function RunOnCardButtonClick(button)
	-- Only add cards in the deck editing view (this might be unnecessry since the card button should only be drawn in the deck editing view)
	if not deckSelectingview then
		AddCardToDeck(button.card.name, selectedDeckIndex, 1)
	end

end

local function UpdateDeckEditorUI()

	if deckSelectingview then

		-- Only update the deck labels when in deck selection view
		for i = 1, #decksLabels do

			-- Check that the deck has not been removed
			if decks[i] then

				if i == selectedDeckIndex then
					-- add colour for the active deck
					decksLabels[i].font:SetColor(orange)
				else
					decksLabels[i].font:SetColor(color.game_fg)
				end

				decksLabels[i]:SetCaption("" .. i)
			else
				decksLabels[i]:SetCaption("")
			end

			-- FIXME better text, deck names?
		end

		-- Update the labels showing the activated decks
		-- Only draw if a deck has been activated (activatedDeckIndex will be a positive number in this case)
		if activatedDeckIndex1 > 0 then
			activeDeck1Label:SetCaption(activatedDeckIndex1)
		end

		if activatedDeckIndex2 > 0 then
			activeDeck2Label:SetCaption(activatedDeckIndex2)
		end

		if decksAreOK then
			activeDeckInfoLabel:SetCaption(acceptiveGreen .. "You can play with these decks")
		else
			activeDeckInfoLabel:SetCaption(redOfDenial .. "You can't play with these decks")
		end
	end


	if poolHasChanged then -- Pool data has arrived => finish the UI

		poolHasChanged = false

		-- Remove old text
		for i = 1, #cardPoolLabels do
			cardPoolLabels[i].caption = ""
		end

		local i = 1 -- Used to index the cardPoolLabels-array

		for cardName, amount in pairs(cardPool) do

			if amount > 0 then
				if activatedPoolcard == cardName then
					-- Add colour for the active card
					cardPoolLabels[i]:SetCaption(activeColour .. GenerateCardLabelString(cardName, amount, cardLabelSpaceCount))
				else
					cardPoolLabels[i]:SetCaption(GenerateCardLabelString(cardName, amount, cardLabelSpaceCount))
				end

				i = i + 1
			end
		end

	end

	if decksHaveChanged and selectedDeckIndex then -- Rewrite the deck data

		decksHaveChanged = false

		-- Remove old captions
		for i = 1, #selectedDeckLabels do
			selectedDeckLabels[i]:SetCaption("")
		end

		--Check that the deck actually exists
		if decks[selectedDeckIndex] then

			-- Used for indexing the deck label array
			i = 1

			for cardName, amount in pairs(decks[selectedDeckIndex]) do

				-- Check that the card has not been removed from the deck
				if amount > 0 then

					if not deckSelectingview and cardName == activatedDeckCard then
						-- Add color for the active card only in the deck editing view
						selectedDeckLabels[i]:SetCaption(activeColour .. GenerateCardLabelString(cardName, amount, cardLabelSpaceCount))
					else
						selectedDeckLabels[i]:SetCaption(GenerateCardLabelString(cardName, amount, cardLabelSpaceCount))
					end

					i = i + 1
				end
			end
		end
	end

	if not deckSelectingview then
		-- The card button should only be drawn while in the deck editing view

		if table.isempty(latestCard) then

			--GetCard("Fire")
			drawCardButton = true

		else
			if selectedCardButton and selectedCardButton.card then
				-- The card button has been made => we need to only update it

					if selectedCardButton.card.name ~= latestCard.name then
						-- The name in the button is different from the one in the activated card => a new card has been activated and it needs to be updated
						selectedCardButton.card = latestCard
						selectedCardButton:UpdateCard(240, 400)
					else
						-- The names are the same => the active card has not changed => it's enough to update the old button
						selectedCardButton:UpdateCard(240, 400)
					end
			end


			if drawCardButton then
				-- The first card has been activated => generate the card button
				sideDataPanel:RemoveChild(selectedCardButton)
				drawCardButton = false
				selectedCardButton = Darius:GetCardButton(latestCard, 240, 400)

				selectedCardButton.OnMouseUp = {function(self)
													RunOnCardButtonClick(self)
												end
				}
				sideDataPanel:AddChild(selectedCardButton)
				selectedCardButton:Invalidate()
			end
		end
	end

	if deckEditorWindow then
		deckEditorWindow:Invalidate()
	end
end

local function ChangeDeckEditorView()

	-- Remove the old view (yes, it is necessary to remove the children individually)
	cardLabelStack:RemoveChild(decksLabelStack)
	cardLabelStack:RemoveChild(startDeckEditingButton)
	cardLabelStack:RemoveChild(selectedDeckLabelStack)
	cardLabelStack:RemoveChild(cardPoolLabelStack)
	cardLabelStack:RemoveChild(addCardToDeckButton)
	cardLabelStack:RemoveChild(removeCardFromDeckButton)
	cardLabelStack:RemoveChild(startDeckSelectionButton)
	cardLabelStack:RemoveChild(createNewDeckButton)
	cardLabelStack:RemoveChild(deleteDeckButton)
	cardLabelStack:RemoveChild(activateSelectedDeckButton)

	sideDataPanel:RemoveChild(selectedCardButton)
	sideDataPanel:RemoveChild(activeDeckLabel)
	sideDataPanel:RemoveChild(activeDeck1Label)
	sideDataPanel:RemoveChild(activeDeck2Label)
	sideDataPanel:RemoveChild(activeDeckInfoLabel)

	if deckSelectingview then
		-- Add the stuff required for the deck selection view
		cardLabelStack:AddChild(decksLabelStack)
		cardLabelStack:AddChild(startDeckEditingButton)
		cardLabelStack:AddChild(selectedDeckLabelStack)
		cardLabelStack:AddChild(createNewDeckButton)
		cardLabelStack:AddChild(deleteDeckButton)
		cardLabelStack:AddChild(activateSelectedDeckButton)

		sideDataPanel:AddChild(activeDeckLabel)
		sideDataPanel:AddChild(activeDeck1Label)
		sideDataPanel:AddChild(activeDeck2Label)
		sideDataPanel:AddChild(activeDeckInfoLabel)

		selectedDeckIndex = 0
		decksHaveChanged = true
	else
		-- Add the stuff for the deck editing view
		cardLabelStack:AddChild(cardPoolLabelStack)
		cardLabelStack:AddChild(addCardToDeckButton)
		cardLabelStack:AddChild(removeCardFromDeckButton)
		cardLabelStack:AddChild(startDeckSelectionButton)
		cardLabelStack:AddChild(selectedDeckLabelStack)

		sideDataPanel:AddChild(selectedCardButton)

		activatedPoolcard = ""
		activatedDeckCard = ""
		poolHasChanged = true
		decksHaveChanged = true
	end

	cardLabelStack:Invalidate() -- FIXME is this needed?
	UpdateDeckEditorUI()
end
local function RunOnCardPoolLabelClick(label)
	-- Extract the card name from the label caption
	local sep = string.find(label.caption, "     ")
	local cardName = string.sub(label.caption, 1, sep - 1)

	-- Fetch the card from the pool
	GetCard(cardName)

	-- Set the card as active
	activatedPoolcard = cardName

	poolHasChanged = true

	UpdateDeckEditorUI()
end

local function RunOnSelectedDeckLabelClick(label)

	if label and  label.caption ~= "" and not deckSelectingview  then

		-- Extract the card name from the label caption
		local sep = string.find(label.caption, "     ")
		local cardName = string.sub(label.caption, 1, sep - 1)

		-- Set the card as beign active
		activatedDeckCard = cardName
		decksHaveChanged = true

		UpdateDeckEditorUI()
	end
end

local function RunOnDecksLabelClick(label)
	if label.caption and label.caption ~= "" then
		selectedDeckIndex = tonumber(label.caption)

		decksHaveChanged = true
	end
end

local function RunOnRemoveCardFromDeckButtonClick()
	-- Checks that we have a card to remove, a selected deck, that the decks actually exists and that we have actually cards to remove in the deck
	if activatedDeckCard ~= "" and selectedDeckIndex and decks[selectedDeckIndex] and decks[selectedDeckIndex][activatedDeckCard] and decks[selectedDeckIndex][activatedDeckCard] >= 1 then
		RemoveCardFromDeck(activatedDeckCard, selectedDeckIndex, 1)
	end

	selectedDeckLabelStack:Invalidate()
	UpdateDeckEditorUI()
end
local function MakeDeckEditorUI()

	local vsx, vsy = widgetHandler:GetViewSizes()
	local windowWidth = 500
	local windowHeight = 500
	local posX = 300
	local posY = 10

	local labelFontSize = 10

	local label = nil

	-- Generate the side data panel labels
	activeDeckLabel = Label:New{

		caption = "Activated Decks:",
		textColor = color.sub_fg,
		align = "left",
		valign = "left",
		fontSize = labelFontSize,
	}

	activeDeck1Label = Label:New{

		caption = "",
		textColor = color.sub_fg,
		align = "left",
		valign = "left",
		fontSize = labelFontSize,
	}

	activeDeck2Label = Label:New{

		caption = "",
		textColor = color.sub_fg,
		align = "left",
		valign = "left",
		fontSize = labelFontSize,
	}

	activeDeckInfoLabel = Label:New{

		caption = "",
		textColor = color.sub_fg,
		align = "left",
		valign = "left",
		fontSize = labelFontSize,
	}

	-- Generate the card pool labels
	for i = 1, maxCardAmount do

		label = Label:New{
					caption = "",
					textColor = color.sub_fg,
					align = "left",
					valign = "left",
					fontSize = labelFontSize,

					OnMouseUp = {function (self)
									RunOnCardPoolLabelClick(self)
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

					OnMouseUp = {function(self)
									RunOnSelectedDeckLabelClick(self)
								end},
					}

		table.insert(selectedDeckLabels, i, label)
	end

	-- Generate the deck labels for all the decks
	for i = 1, maxDeckAmount do

		label = Label:New{
					caption = "",
					textColor = color.sub_fg,
					align = "left",
					valign = "left",
					fontSize = labelFontSize,

					OnMouseUp = {function(self)
									RunOnDecksLabelClick(self)
								end},

		}
		table.insert(decksLabels, label)
	end

	decksLabelStack = StackPanel:New{
		x = 1,
		y = 1,
		width = '100%',
		height = '50%',
		bottom = '50%',
		resizeItems = true,
		autosize = true,
		preserveChildrenOrder = true,

		children = decksLabels,
	}

	cardPoolLabelStack = StackPanel:New{
		x = 1,
		y = 1,
		width = '100%',
		height = '50%',
		bottom = '50%',
		resizeItems = true,
		autosize = true,
		preserveChildrenOrder = true,

		children = cardPoolLabels
	}

	selectedDeckLabelStack = StackPanel:New{
		x = 1,
		y = '62%',
		width = '100%',
		height = '50%',
		resizeItems = true,
		autosize = true,
		preserveChildrenOrder = true,

		children = selectedDeckLabels
	}

	selectedCardButton = Button:New{
		-- The actual card button is created elsewhere, this is just a dummy to prevent crashing
		x = 1,
		y = 1,

		width = 1,
		height = 1,

		caption = "",
	}

	addCardToDeckButton = Button:New{
		x = 1,
		y = '51%',

		width = '30%',
		height = '5%',

		caption = "Add",

		OnMouseUp = {function()
						if activatedPoolcard ~= "" and selectedDeckIndex and decks[selectedDeckIndex] then
							AddCardToDeck(activatedPoolcard, selectedDeckIndex, 1)
							UpdateDeckEditorUI()
						end
					end,},
	}

	removeCardFromDeckButton = Button:New{
		x = '32%',
		y = '51%',

		width = '30%',
		height = '5%',

		caption = "remove",

		OnMouseUp = {function()
						RunOnRemoveCardFromDeckButtonClick()
					end,},
	}

	startDeckSelectionButton = Button:New{
		x = '62%',
		y = '51%',

		width = '30%',
		height = '5%',

		caption = "Done",

		OnMouseUp = {function()
						CheckActivatedDecks() -- Check that the decks are valid even after the changes (the user might have edited an active deck)
						deckSelectingview = true --Set the mode for deck selection view
						ChangeDeckEditorView()
					end},
	}

	startDeckEditingButton = Button:New{
		x = 1,
		y = '51%',

		width = '35%',
		height = '5%',

		caption = "Edit deck",

		OnMouseUp = {function()
						if selectedDeckIndex and decks[selectedDeckIndex] then
							deckSelectingview = false -- Set the mode for deck editing view
							ChangeDeckEditorView()
						end
					end},
	}

	createNewDeckButton = Button:New{
		x = '38%',
		y = '51%',

		width = '35%',
		height = '5%',

		caption = "New deck",

		OnMouseUp = {function()
						-- Create a new deck to the decks table
						selectedDeckIndex = #decks + 1
						decks[selectedDeckIndex] = {}

						-- Chnage the view to the deck editing view
						deckSelectingview = false
						ChangeDeckEditorView()
					end},
	}

	deleteDeckButton = Button:New{
		x = 1,
		y = '57%',

		width = '35%',
		height = '5%',

		caption = "Delete deck",

		OnMouseUp = {function()
						if selectedDeckIndex and decks[selectedDeckIndex] then
							-- remove the deck
							table.remove(decks, selectedDeckIndex)

							-- remove deck selection
							selectedDeckIndex = 0

							-- Redraw
							decksHaveChanged = true
							UpdateDeckEditorUI()
						end
					end},
	}

	activateSelectedDeckButton = Button:New{
		x = '38%',
		y = '57%',

		width = '35%',
		height = '5%',

		caption = "Activate",

		OnMouseUp = {function()
						-- Only set the deck as active if it has not been activated before
						if selectedDeckIndex ~= activatedDeckIndex1 and selectedDeckIndex ~= activatedDeckIndex2 then

							-- Check if the first variable has been used before
							if activatedDeckIndex1 > 0 then

								--Check if the second variable has been used before
								if activatedDeckIndex2 > 0 then

									-- Check wich of the variables should be used next
									if useNext then
										activatedDeckIndex1 = selectedDeckIndex
									else
										activatedDeckIndex2 = selectedDeckIndex
									end

									useNext = not useNext


								else
									-- This is the first time the second variable is used
									activatedDeckIndex2 = selectedDeckIndex
								end

								-- Check if the decks are valid
								CheckActivatedDecks()

							else
								-- This is the first time the first variable is used
								activatedDeckIndex1 = selectedDeckIndex
							end
						end
					end
		}
	}

	cardLabelStack = StackPanel:New{
		x = 1,
		y = 1,
		width = '50%',
		height = '100%',
		resizeItems = true,
		autosize = true,
		preserveChildrenOrder = true,

		children = {},
	}

	sideDataPanel = StackPanel:New{
		x = 1,
		y = 1,
		width = '50%',
		height = '100%',
		resizeItems = false,
		autosize = true,
		preserveChildrenOrder = true,

		children = {},
	}

	-- Load the beginning view
	ChangeDeckEditorView()

	deckEditorStack = StackPanel:New{
		x = 1,
		y = 1,
		name='deckEditorStack',
		orientation = 'horizontal',
		width = '100%',
		height = '100%',
		resizeItems = true,

		children = {cardLabelStack, sideDataPanel,},

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
		children = {deckEditorStack,}
	}

	screen0:AddChild(deckEditorWindow)
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
end

function widget:Update()
	UpdateDeckEditorUI()
end

function widget:Shutdown()
	SendDecks()
	-- Check that the decks the user has selected are valid and only then activate them
	if decksAreOK then
		SendActivatedDecks(activatedDeckIndex1, activatedDeckIndex2)
	end
end
