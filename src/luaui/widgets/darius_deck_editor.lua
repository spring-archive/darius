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
local cardPool = {}         -- Card pool is stored as (cardName, amount) -pairs e.g. cardPool["Fire"] = 5 => The pool has five fire cards

local decks = {}            -- Decks are stored as an array of (cardName, amount) -pairs e.g. decks[2]["Fire"] = 3 => Deck number 2 has 3 fire cards

local latestCard = {}       -- Cache for the latest card fetched from the pool

local maxCardAmount = 0
local activatedPoolcard = ""  	-- Name of the latest selected card in the pool
local activatedDeckCard = ""  	-- Name of tha latest selected card in the selected deck
local selectedDeckIndex = 0   	-- Index of the deck that is currently under edit
local cardLabelLenght = 2		-- Currently not used
local minimumCardLabelSpaceCount = 2 -- The amount of spaces between the card name and it's amount on card labels (NOTE: this must be more than the amount of sequential spaces in the card names)
local maxDeckAmount = 10		-- The maximum amount of decks supported by the editor

local activatedDeckIndex1 = 0
local activatedDeckIndex2 = 0
local useNext = true

-- UI handles
local deckEditorStack 				= nil
local deckEditorWindow 				= nil
local cardPoolLabelStack 			= nil
local cardPoolScrollStack			= nil
local selectedDeckScrollStack		= nil
local selectedDeckLabelStack		= nil
local decksLabelStack 				= nil
local selectedCardButton 			= nil
local cardPoolLabels 				= {}
local selectedDeckLabels 			= {}
local decksLabels 					= {}
local conflictLabels				= {}
local conflictStack					= nil
local activeDeckLabel 				= nil
local activeDeck1Label				= nil
local activeDeck2Label				= nil
local activeDeckInfoLabel			= nil
local startDeckSelectionButton		= nil
local deleteDeckButton				= nil
local createNewDeckButton			= nil
local activateSelectedDeckButton	= nil

-- UI element sizes
local labelFontSize = 13
local cardButtonX = 240
local cardButtonY = 400
local settings = {}

local defaults = {
	windowMinWidth = 525,
	windowMinHeight = 525,
	windowWidth	= 525,
	windowHeight = 525,
	posX = 300,
	posY = 10,
}

-- Data flags
local poolHasChanged 		= false	-- Tells the update function to redraw card pool related data
local decksHaveChanged 		= false	-- Tells the update function to redraw deck related data
local deckSelectingview 	= true 	-- Tells which view to draw: the deck selection view (true) or the deck editing view(false)
local decksAreOK 			= false	-- Tells if the decks have been checked and found to be OK (true) or if there is something wrong with them(false)
local reCheckDecks 			= true 	-- Notifies the update function to re-check the validation of the activated decks

-- Colours are pwetty!
local VFSMODE 			= VFS.RAW_FIRST
local file 				= LUAUI_DIRNAME .. "configs/gui_conf.lua"
local confdata 			= VFS.Include(file, nil, VFSMODE)
local color 			= confdata.color
local orange 			= {1,0.5,0,1}
local activeColour 		= "\255\255\128\10"
local acceptiveGreen 	= "\255\0\255\0"
local redOfDenial 		= "\255\255\0\0"


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

local function FindLongestKey(t) -- Currently not used
	if not t or t == {} then
		return 0
	end

	local currentMax = 0

	for k, v in pairs(t) do
		if type(v) == 'table' then
			-- Recursion to subtables
			local v = FindLongestKey(v)

			if v > currentMax then
				currentMax = v
			end

		elseif type(k) == 'string' then
			-- If the key is a string check it's lenght and update the current max if necessary
			if string.len(k) > currentMax then
				currentMax = string.len(k)
			end
		end
	end

	return currentMax
end

local function GetSortedKeys(t)
	local cache = {}

	-- Copy the keys of the table given to an array
	for k,v in pairs(t) do
		table.insert(cache, k)
	end

	-- Sort the array with the keys in
	table.sort(cache, function(s1, s2) return s1 < s2 end)

	-- And return it
	return cache
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

local function GetDeckSelection()
	spSendLuaRulesMsg("UnsyncDeckSelection")
end

local function SetDecks(deckCollection)
	decks = {}
	-- Modify the data to the format used by the deck editor
	for i = 1, #deckCollection do
		-- Remove the possible empty decks received from the pool
		if not table.isempty(deckCollection[i]) then
			table.insert(decks, GenerateOccuranceTable(deckCollection[i]))
		end
	end

	-- Order the redraw of the deck data
	decksHaveChanged = true
end

local function SetCardPool(pool)
	cardPool = GenerateOccuranceTable(pool)

	-- Order the redraw of the pool data
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

local function SetDeckSelection(selection)
	if selection and selection[1] and selection [2] then
		-- Save the selections
		activatedDeckIndex1 = selection[1]
		activatedDeckIndex2 = selection[2]

		-- Signal the update to re-check the deck validation
		reCheckDecks = true
	end
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

local function CheckDecks(deck1, deck2)
	-- Use the first deck as a base for the calculation (copy is needed, because we don't want to break the existing deck)
	local cardTotals = table.copy(deck1)

	-- Counts the total amount of each card in the decks supplied
	for cardName, amount in pairs(deck2) do

		if cardTotals[cardName] then
			-- The card totals allready has some of these cards => increase the amount
			cardTotals[cardName] = cardTotals[cardName] + amount
		else
			-- These are the first occurances of these cards => create a new value
			cardTotals[cardName] = amount
		end
	end
	
	-- Stores the conflicts found between the decks and the pool
	local conflicts = {}

	-- Check that the card pool has enough cards to support the deck candidates
	for cardName, amount in pairs(cardTotals) do

		-- Check that the card is in the pool and that we have enough of them
		if not cardPool[cardName] then
			-- There are no cards of this name in the pool (is this even possible...?) => add as a conflict
			conflicts[cardName] = amount
			
		elseif cardPool[cardName] < amount then
			-- The decks have too many cards of this name => add as a conflict
			conflicts[cardName] = amount - cardPool[cardName] -- The actual amount of cards conflicting
		end
	end

	-- return all the conflicts found
	return conflicts
end

local function CreateRandomDecks()
	-- Seed the random numbers
	math.randomseed(os.time())
	-- Empty decks, where we'll add the all the cards in the pool
	local deck1 = {}
	local deck2 = {}
	
	-- Loop through the pool
	for cardName, amount in pairs(cardPool) do
		-- Each card needs to be added seperately to a deck
		for i = 1, amount do
			-- Pick the deck where the card will be inserted randomly
			if math.random() < 0.5 then
				-- Check if the deck already has this card
				if deck1[cardName] then
					-- Increase the counter in this case
					deck1[cardName] = deck1[cardName] + 1
				else
					-- This is the first instance of this card => insert it
					deck1[cardName] = 1
				end
			else
				-- Same as above, but for the second deck
				if deck2[cardName] then
					deck2[cardName] = deck2[cardName] + 1
				else
					deck2[cardName] = 1
				end
			end
		end
	end

	return deck1, deck2
end
----------------
-- UI helpers --
----------------
local function GenerateCardLabelString(cardName, amount)
	local s = cardName

	for i = 1, minimumCardLabelSpaceCount do
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

local function GetLabelByCaption(labelArray, caption) -- Currently not used
	for i = 1, #labelArray do
		if string.find(labelArray[i].caption, caption) then
			return labelArray[i]
		end
	end

	return nil
end

local function CheckActivatedDecks()
	-- Check our activation status (if isActive == true we need to check that that decks is valid)
	local isActive1 = activatedDeckIndex1 > 0 and decks[activatedDeckIndex1]
	local isActive2 = activatedDeckIndex2 > 0 and decks[activatedDeckIndex2]
	
	local resultingConflicts = {}
	
	if isActive1 then
		if isActive2 then
			-- Check for conflicts with the activated decks
			resultingConflicts = CheckDecks(decks[activatedDeckIndex1], decks[activatedDeckIndex2])
		else
			-- Check for conflicts with just the one active deck
			resultingConflicts = CheckDecks(decks[activatedDeckIndex1], {})
		end
	else
		if isActive2 then
			-- Check for conflicts with just the one active deck
			resultingConflicts = CheckDecks(decks[activatedDeckIndex2], {})
		else
			-- No decks are active => the are no conflicts
			-- resultingConflicts = {} (this line is unnecessary)
		end
	end
	
	-- Check for conflicts (no conflicts means that the decks are OK)
	decksAreOK = table.isempty(resultingConflicts)
	
	return resultingConflicts
end
------------------
-- UI functions --
------------------
local function RunOnCardButtonClick(button)
	-- Only add cards in the deck editing view (this might be unnecessry since the card button should only be drawn in the deck editing view). Also check that a card has been activated.
	if not deckSelectingview and not table.isempty(latestCard) then
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

		-- Check if the activated decks need a re-check
		if reCheckDecks then
			reCheckDecks = false
			--Remove the old conflicts
			for i = 1, #conflictLabels do
				sideDataPanel:RemoveChild(conflictLabels[i])
			end
			-- Check for new conflicts
			local conflicts = CheckActivatedDecks()

			if conflicts then -- Conflictions were found
				local i = 1 -- Used to index the conflictLabels -array
				for cardName, amount in pairs(conflicts) do
					sideDataPanel:AddChild(conflictLabels[i])
					conflictLabels[i]:SetCaption(redOfDenial .. GenerateCardLabelString(cardName, amount)) 
					i = i + 1
				end
				-- An ugly hack which adds an extra label to the panel, so that the text in the last label will show properly
				sideDataPanel:AddChild(conflictLabels[i + 1])
				conflictLabels[i + 1]:SetCaption("")
			end
		end

		-- Update the labels showing the activated decks
		-- Check that the deck actually exists (this prevents a bug when the user deletes an active deck)
		if activatedDeckIndex1 > 0 and decks[activatedDeckIndex1] then
			activeDeck1Label:SetCaption(activatedDeckIndex1)
		else
			activeDeck1Label:SetCaption("")
		end

		if activatedDeckIndex2 > 0 and decks[activatedDeckIndex2] then
			activeDeck2Label:SetCaption(activatedDeckIndex2)
		else
			activeDeck2Label:SetCaption("")
		end

		-- Update the label showing the validnes of the activated decks
		if decksAreOK then
			activeDeckInfoLabel:SetCaption(acceptiveGreen .. "You can play with these decks")
		else
			activeDeckInfoLabel:SetCaption(redOfDenial .. "You can't play with these decks\nbecause you have exceeded\nthe card pool as follows:")
		end
	else --The deck editing view:

		-- Check if a card has been fetched fron the pool
		if not table.isempty(latestCard) then

			if selectedCardButton and selectedCardButton.card then
				-- The card button has been made => we need only to update it
				
				if selectedCardButton.card.name ~= latestCard.name then
					-- The name in the button is different from the one in the activated card => a new card has been activated and it needs to be updated
					selectedCardButton.card = latestCard
					selectedCardButton:UpdateCard(cardButtonX, cardButtonY)
				else
					-- The names are the same => the active card has not changed => it's enough to update the old button
					selectedCardButton:UpdateCard(cardButtonX, cardButtonY)
				end
			end
		end
	end

	if poolHasChanged then -- Pool data has changed => redraw

		poolHasChanged = false

		-- Remove the old labels
		for i = 1, #cardPoolLabels do
			cardPoolLabelStack:RemoveChild(cardPoolLabels[i])
		end

		local sortedKeys = GetSortedKeys(cardPool) -- Used to make the card list alphabetically sorted

		for j = 1, #sortedKeys do

			if cardPool[sortedKeys[j]] > 0 then -- FIXME: will the amount of cards in the pool be changeable? Can it be less than 0?

				-- Add a label for this entry
				cardPoolLabelStack:AddChild(cardPoolLabels[j])

				if activatedPoolcard == sortedKeys[j] then
					-- Add colour for the active card
					cardPoolLabels[j]:SetCaption(activeColour .. GenerateCardLabelString(sortedKeys[j], cardPool[sortedKeys[j]]))
				else
					cardPoolLabels[j]:SetCaption(GenerateCardLabelString(sortedKeys[j], cardPool[sortedKeys[j]]))
				end
			end
		end

		-- Update the height of the panel, so that the scroll bars will only be drawn if needed
		-- The +3 and + 10 only add some extra space to the panel, so that it won't be so crammed
		cardPoolLabelStack.height = (#sortedKeys + 3) * labelFontSize + 10

		-- Update the panels
		cardPoolLabelStack:UpdateClientArea()
		cardPoolScrollStack:UpdateLayout()
		cardPoolLabelStack:Invalidate()
		cardPoolScrollStack:Invalidate()
	end

	if decksHaveChanged then -- Rewrite the deck data

		decksHaveChanged = false

		-- Remove old labels
		for i = 1, #selectedDeckLabels do
			selectedDeckLabelStack:RemoveChild(selectedDeckLabels[i])
		end

		--Check that the deck actually exists
		if decks[selectedDeckIndex] then

			local deck = decks[selectedDeckIndex] -- Less writing this way

			local sortedKeys = GetSortedKeys(deck) -- Used to make the list alphabetically sorted

			for i = 1, #sortedKeys do

				-- Check that the card has not been removed from the deck (if it would, the amount would be 0 or less)
				if deck[sortedKeys[i]] > 0 then

					-- Add a label for this entry
					selectedDeckLabelStack:AddChild(selectedDeckLabels[i])

					if not deckSelectingview and sortedKeys[i] == activatedDeckCard then
						-- Add color for the active card only in the deck editing view
						selectedDeckLabels[i]:SetCaption(activeColour .. GenerateCardLabelString(sortedKeys[i], deck[sortedKeys[i]]))
					else
						selectedDeckLabels[i]:SetCaption(GenerateCardLabelString(sortedKeys[i], deck[sortedKeys[i]]))
					end
				end
			end
			-- Resize the panel, so that the scroll bars will only be drawn if needed
			-- The +5 and +10 only add some extra space to the panel, so that the labels won't be so crammed
			selectedDeckLabelStack.height = #sortedKeys * (labelFontSize + 5) + 10

		else
			selectedDeckLabelStack.height = 1 -- This is needed so that the scroll bars will not be drawn on an empty panel
		end

		-- Update the panels FIXME: are all these necessary?
		selectedDeckLabelStack:UpdateClientArea()
		selectedDeckScrollStack:UpdateLayout()
		selectedDeckLabelStack:Invalidate()
		selectedDeckScrollStack:Invalidate()
	end

	if deckEditorWindow then
		deckEditorWindow:Invalidate()
	end
end

local function ChangeDeckEditorView()

	-- Remove the old view (yes, it is necessary to remove the children individually)
	cardLabelStack:RemoveChild(decksLabelStack)
	cardLabelStack:RemoveChild(startDeckEditingButton)
	cardLabelStack:RemoveChild(selectedDeckScrollStack)
	cardLabelStack:RemoveChild(addCardToDeckButton)
	cardLabelStack:RemoveChild(removeCardFromDeckButton)
	cardLabelStack:RemoveChild(startDeckSelectionButton)
	cardLabelStack:RemoveChild(createNewDeckButton)
	cardLabelStack:RemoveChild(deleteDeckButton)
	cardLabelStack:RemoveChild(activateSelectedDeckButton)
	cardLabelStack:RemoveChild(cardPoolScrollStack)

	sideDataPanel:RemoveChild(selectedCardButton)
	sideDataPanel:RemoveChild(activeDeckLabel)
	sideDataPanel:RemoveChild(activeDeck1Label)
	sideDataPanel:RemoveChild(activeDeck2Label)
	sideDataPanel:RemoveChild(activeDeckInfoLabel)
	for i = 1, #conflictLabels do
		sideDataPanel:RemoveChild(conflictLabels[i])
	end

	if deckSelectingview then
		-- Add the stuff required for the deck selection view
		cardLabelStack:AddChild(decksLabelStack)
		cardLabelStack:AddChild(startDeckEditingButton)
		cardLabelStack:AddChild(selectedDeckScrollStack)
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
		cardLabelStack:AddChild(cardPoolScrollStack)
		cardLabelStack:AddChild(addCardToDeckButton)
		cardLabelStack:AddChild(removeCardFromDeckButton)
		cardLabelStack:AddChild(startDeckSelectionButton)
		cardLabelStack:AddChild(selectedDeckScrollStack)

		sideDataPanel:AddChild(selectedCardButton)

		activatedPoolcard = ""
		activatedDeckCard = ""
		poolHasChanged = true
		decksHaveChanged = true
	end

	UpdateDeckEditorUI()
end

local function RunOnCardPoolLabelClick(label)
	if label and label.caption and label.caption ~= "" then

		-- Extract the card name from the label caption
		local sep = string.find(label.caption, "  ")
		local cardName = string.sub(label.caption, 1, sep - 1)

		-- Fetch the card from the pool
		GetCard(cardName)

		-- Set the card as active
		activatedPoolcard = cardName

		poolHasChanged = true

		UpdateDeckEditorUI()
	end
end

local function RunOnSelectedDeckLabelClick(label)
	if label and  label.caption ~= "" and not deckSelectingview  then

		-- Extract the card name from the label caption
		local sep = string.find(label.caption, "  ")
		local cardName = string.sub(label.caption, 1, sep - 1)

		-- Set the card as beign active
		activatedDeckCard = cardName
		decksHaveChanged = true

		UpdateDeckEditorUI()
	end
end

local function RunOnDecksLabelClick(label)
	if label and label.caption and label.caption ~= "" then
		selectedDeckIndex = tonumber(label.caption)

		decksHaveChanged = true
	end
end

local function RunOnRemoveCardFromDeckButtonClick()
	-- Checks that we have a card to remove, a selected deck, that the decks actually exists and that we have actually cards to remove in the deck
	if activatedDeckCard ~= "" and selectedDeckIndex and decks[selectedDeckIndex] and decks[selectedDeckIndex][activatedDeckCard] and decks[selectedDeckIndex][activatedDeckCard] >= 1 then
		RemoveCardFromDeck(activatedDeckCard, selectedDeckIndex, 1)
	end

	UpdateDeckEditorUI()
end

local function RunOnDeletedDeckButtonClick()
	-- Check that we are removing an existing deck
	if selectedDeckIndex and decks[selectedDeckIndex] then
	
		-- Recheck the active decks if the user deleded an active deck, also remove the activation if this was the case
		if selectedDeckIndex == activatedDeckIndex1 then
			activatedDeckIndex1 = 0
			reCheckDecks = true
		end
		if selectedDeckIndex == activatedDeckIndex2 then
			activatedDeckIndex2 = 0
			reCheckDecks = true
		end
		-- remove the deck
		table.remove(decks, selectedDeckIndex)
		
		-- fix the indexes (removing a value from the table will decrease the table size)
		if selectedDeckIndex < activatedDeckIndex1 then
			activatedDeckIndex1 = activatedDeckIndex1 - 1
		end
		if selectedDeckIndex < activatedDeckIndex2 then
			activatedDeckIndex2 = activatedDeckIndex2 - 1
		end

		-- remove the deck selection
		selectedDeckIndex = 0

		-- Redraw
		decksHaveChanged = true
		UpdateDeckEditorUI()
	end
end

local function RunOnActivateSelectedDeckButtonClick()
	-- Only set the deck as active if it has not been activated before
	if selectedDeckIndex ~= activatedDeckIndex1 and selectedDeckIndex ~= activatedDeckIndex2 then

		-- Check if the first variable is used
		if activatedDeckIndex1 > 0 then

			--Check if the second variable is used
			if activatedDeckIndex2 > 0 then

				-- Check wich of the variables should be used next
				if useNext then
					activatedDeckIndex1 = selectedDeckIndex
				else
					activatedDeckIndex2 = selectedDeckIndex
				end

				useNext = not useNext
			else
				-- The second variable can be used
				activatedDeckIndex2 = selectedDeckIndex
			end
		else
			-- The first variable can be used
			activatedDeckIndex1 = selectedDeckIndex
		end
		-- Something has been changed => redraw
		reCheckDecks = true
		UpdateDeckEditorUI()
	end
end

local function RunOnCreateNewDeckButtonClick()
	-- Check that we have enough space for this deck
	if #decks <= maxDeckAmount then

		-- Create a new deck to the decks table
		selectedDeckIndex = #decks + 1
		decks[selectedDeckIndex] = {}

		-- Change the view to the deck editing view
		deckSelectingview = false
		ChangeDeckEditorView()
	end
end

local function RunOnActiveDeckLabelClick(label)
	if label and label.caption and label.caption ~= "" then
		-- Extract the active deck number
		local deck = tonumber(label.caption)
	
		-- Remove the deck selection
		if deck == activatedDeckIndex1 then
			activatedDeckIndex1 = 0
		end
		if deck == activatedDeckIndex2 then
			activatedDeckIndex2 = 0
		end
		-- Revalidate the active decks and redraw
		reCheckDecks = true
		UpdateDeckEditorUI()
	end
end

local function MakeDeckEditorUI()
	local label = nil -- A cache for the most recently generated label

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
		OnMouseUp = {function(self)
						RunOnActiveDeckLabelClick(self)
					end},
	}

	activeDeck2Label = Label:New{

		caption = "",
		textColor = color.sub_fg,
		align = "left",
		valign = "left",
		fontSize = labelFontSize,
		OnMouseUp = {function(self)
						RunOnActiveDeckLabelClick(self)
					end},
	}

	activeDeckInfoLabel = Label:New{

		caption = "",
		textColor = color.sub_fg,
		align = "left",
		valign = "left",
		fontSize = labelFontSize,
	}
	
	-- Generate the labels for the possible conflicts
	for i = 1, maxCardAmount + 1 do -- The +1 is because of an ugly hack used in the UpdateDeckEditorUI()-function
		label = Label:New{
					caption = "",
					textColor = color.sub_fg,
					align = "left",
					valign = "left",
					fontSize = labelFontSize,
					fontColor = redOfDenial,
					}
		table.insert(conflictLabels, label)
	end

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
		table.insert(cardPoolLabels, label)
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
		table.insert(selectedDeckLabels, label)
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
		height = 1, -- The actual height is determined by the UpdateDeckEditorUI() -function
		resizeItems = true,
		autosize = true,
		preserveChildrenOrder = true,

		children = {}
	}

	cardPoolScrollStack = ScrollPanel:New{
		x = 1,
		y = 1,
		width = '100%',
		height = '49%',
		bottom = '50%',
		autosize = true,
		preserveChildrenOrder = true,
		verticalSmartScroll = true,
		horizontalScrollbar = false,

		children = {cardPoolLabelStack,},
	}

	selectedDeckLabelStack = StackPanel:New{
		x = 1,
		y = 1,
		width = '100%',
		height = 1, -- The actual height needed is counted in the UpdateDeckEditorUI() -function
		resizeItems = true,
		autosize = true,
		preserveChildrenOrder = true,

		children = {} -- The labels will be added in the UpdateDeckEditorUI() -function
	}

	selectedDeckScrollStack = ScrollPanel:New{
		x = 1,
		y = '62%',
		width = '100%',
		height = '37%',
		resizeItems = true,
		autosize = true,
		verticalSmartScroll = true,
		horizontalScrollbar = false,
		preserveChildrenOrder = true,

		children = {selectedDeckLabelStack,},
	}

	selectedCardButton = Darius:GetCardButton(nil, cardButtonX, cardButtonY)
	selectedCardButton.OnMouseUp = {function(self) RunOnCardButtonClick(self) end}


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
						reCheckDecks = true -- Force the revalidation of the activated decks (the user might have edited an active deck)
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
						RunOnCreateNewDeckButtonClick()
					end},
	}

	deleteDeckButton = Button:New{
		x = 1,
		y = '57%',
		width = '35%',
		height = '5%',
		caption = "Delete deck",

		OnMouseUp = {function()
						RunOnDeletedDeckButtonClick()
					end},
	}

	activateSelectedDeckButton = Button:New{
		x = '38%',
		y = '57%',
		width = '35%',
		height = '5%',
		caption = "Activate",

		OnMouseUp = {function()
						RunOnActivateSelectedDeckButtonClick()
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
		caption = "Deck Editor",
		x = settings.posX or defaults.posX,
		y = settings.posY or defaults.posY,
		dockable = false,
		name = "deckEditorWindow",
		width = settings.windowWidth or defaults.windowWidth,
		height = settings.windowHeight or defaults.windowHeight,
		minWidth = defaults.windowMinWidth,
		minHeight = defaults.windowMinHeight,
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
	widgetHandler:RegisterGlobal("SetDeckEditorDeckSelection", SetDeckSelection)

	maxCardAmount = Spring.GetGameRulesParam("maximumcardamount") --Fetch the amount of cards from the pool. Yes, it is *necessary* to do it like this.
	if not (maxCardAmount) then maxCardAmount = 0 end --Minor bug fix for if the card pool fails

	-- Obtain the required data from the card pool
	GetDecks()
	GetPool()
	GetDeckSelection()

	SetUpHandles()
	MakeDeckEditorUI()
end

function widget:Update()
	UpdateDeckEditorUI()
end

function widget:Shutdown()
	-- Check that the decks the user has selected are valid and only then activate them
	if decksAreOK then
		-- If the user is using only one deck (or no decks at all) add an empty deck as the other deck(to make the card pool work properly)
		if activatedDeckIndex1 == 0 or not decks[activatedDeckIndex1] then
			decks[#decks + 1] = {}
			activatedDeckIndex1 = #decks
		end
		if activatedDeckIndex2 == 0 or not decks[activatedDeckIndex2] then
			decks[#decks + 1] = {}
			activatedDeckIndex2 = #decks
		end
		-- Send the data to the card pool
		SendDecks()
		SendActivatedDecks(activatedDeckIndex1, activatedDeckIndex2)
	end
end

function widget:GetConfigData()
	if (deckEditorWindow) then
		settings.windowHeight = deckEditorWindow.height
		settings.windowWidth  = deckEditorWindow.width
		settings.posX  = deckEditorWindow.x
		settings.posY  = deckEditorWindow.y
	end
	return settings
end

function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		settings = data
	end
end