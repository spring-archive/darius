function gadget:GetInfo()
	return {
		name      = "Card Pool",
		desc      = "Stores the cards the player owns",
		author    = "xcompwiz",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true,  --  loaded by default
	}
end

--------------
-- Speed Up --
--------------
local spEcho            = Spring.Echo
local spSendLuaRulesMsg = Spring.SendLuaRulesMsg

--local debug_message = spEcho

---------------------
-- Table Functions --
---------------------
function table.copy(t)
	if (t == nil) then return nil end
	local t2 = {}
	for k,v in pairs(t) do
		if (type(v) == "table") then --Next level needed for effects
			t2[k] = table.copy(v)
		else
			t2[k] = v
		end
	end
	return t2
end

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

function string.totable(s) --Incomplete
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

-----------------------
-- Table Conversions -- (Decks and pool)
-----------------------
--[[
The string syntax for the decks collection is:
{{cardName1,cardName2,cardName3,cardName2,},{,cardName3,cardName2,cardName5,},}

That string would represent two different decks of which the first has 4 cards and the second has three.
--]]

local function CreatePoolString(pool)
	local poolString = "{"
	for i = 1, #pool do --Iterate all cards in pool
		if (type(pool[i]) == "table") then  -- For synced side (has card tables)
			poolString = poolString .. pool[i].name .. ","
		elseif (type(pool[i]) == "string") then  -- For synced side (has card tables)
			poolString = poolString .. pool[i] .. ","
		end
	end
	poolString = poolString .. "}"
	return poolString
end

local function CreateDecksString(decks)
	local decksString = "{"

	for i = 1, #decks do --Iterate all the decks
		decksString = decksString .. "{"

		for j = 1, #decks[i] do --Iterate all the cards in one deck
			if (type(decks[i][j]) == "table") then
				decksString = decksString .. decks[i][j].name .. ","
			elseif (type(decks[i][j]) == "string") then
				decksString = decksString .. decks[i][j] .. ","
			end
		end

		decksString = decksString .. "},"
	end
	decksString = decksString .. "}"
	return decksString
end

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

---------------------
-- Local Variables --
---------------------
local CardPool = gadget
GG.CardPool = CardPool

local cardData = {}

local pool = {}
local decks = {} --Collection of decks; Decks store references to the card datas

--Used to select which decks the player wants to use
local deck1Index = 1
local deck2Index = 2

-------------------
-- Communication --
-------------------

local function UnsyncCardPool()
	poolString = CreatePoolString(pool)
	SendToUnsynced("cardpool", poolString)
end

local function ParsePool(poolString)
	local newPool = string.totable(poolString)
	pool = {}
	for i = 1, #newPool do
		local card = gadget:GetCardDataByName(newPool[i])
		if (type(card) == "table") then --Makes sure data exists
			table.insert(pool, card)
		end
	end
	return pool
end

local function UnsyncDecks()
	decksString = CreateDecksString(decks)
	SendToUnsynced("decksCollection", decksString)
end

local function UnsyncDeckSelection()
	str = deck1Index .. "," .. deck2Index
	SendToUnsynced("deckSelection", str)
end

local function UnsyncCard(card)
	if not (card) then
		return
	end

	SendToUnsynced("UnsyncingCard",
		card.id,
		card.name,
		card.type,
		card.img,
		card.health,
		card.reloadTime,
		card.range,
		card.damage,
		card.greenballs,
		card.desc
	)
end

function gadget:ParseDecks(decksString)
	local newDecks = string.totable(decksString) -- => "local newDecks = {{..,},{..,},..,}"
	decks = {}
	for i = 1, #newDecks do
		if (debug_message) then debug_message("Creating deck " .. i .. ".") end
		deck = {}
		for j = 1, #newDecks[i] do
			if (debug_message) then debug_message("Adding card " .. newDecks[i][j] .. " to deck " .. i .. ".") end
			local card = gadget:GetCardDataByName(newDecks[i][j])
			if (type(card) == "table") then --Makes sure data exists
				table.insert(deck, card)
			end
		end
		decks[i] = deck
	end
	return decks
end

---------------------
-- Local Functions --
---------------------
local function LoadCardsFromFiles()
	local materialFiles = VFS.DirList('cards/lua/material', '*.lua')
	local weaponFiles = VFS.DirList('cards/lua/weapon', '*.lua')
	local specialFiles = VFS.DirList('cards/lua/special', '*.lua')

	startpool = {}
	startdecks = {{},{},{}}
	for i=1, #materialFiles do
		local card = VFS.Include(materialFiles[i])
		table.insert(cardData, card)
		table.insert(startpool, card) --Generates basic starting pool (This should be more controlled later)
		table.insert(startdecks[1], card) --Generates one of the basic starting decks (This should be more controlled later)
	end
	for i=1, #weaponFiles do
		local card = VFS.Include(weaponFiles[i])
		table.insert(cardData, card)
		table.insert(startpool, card) --Generates basic starting pool (This should be more controlled later)
		table.insert(startdecks[2], card) --Generates one of the basic starting decks (This should be more controlled later)
	end

	for i=1, #specialFiles do
		local card = VFS.Include(specialFiles[i])
		table.insert(cardData, card)
		table.insert(startpool, card) --Generates basic starting pool (This should be more controlled later)
		table.insert(startdecks[3], card) --Generates one of the basic starting decks (This should be more controlled later)
	end
	--If the player doesn't have a pool or any decks (possibly because the data hasn't been loaded yet) then give them the standard
--	if not (#pool == 0) then
		pool = startpool
--	end
--	if not (#decks == 0) then
		decks = startdecks
		deck1Index = 1
		deck2Index = 2
--	end

	Spring.SetGameRulesParam("maximumcardamount", #cardData) -- Used by the deck editor. DO NOT remove
end

local function SendDecksToSession()  -- Sends the decks to the instance game manager

	if (not decks[deck1Index]) then return false end
	if (not decks[deck2Index]) then return false end

	for i=1, #decks[deck1Index] do
		Darius:AddCard(table.copy(decks[deck1Index][i]), 1) --Card table must be copied to create unique instance
	end

	for i=1, #decks[deck2Index] do
		Darius:AddCard(table.copy(decks[deck2Index][i]), 2)
	end

	return true
end

local function SetActiveDeckIndexes(index1, index2) --Sets and checks the decks the user wishes to use
	-- Actual deck checking moved to the deck editor
	deck1Index = index1
	deck2Index = index2
	UnsyncDeckSelection()
end

-------------------------
-- Card pool functions --
-------------------------
function gadget:StartGame()
	if (not GG.Darius) then
		spEcho("Game failed to load properly")
		return
	end

	Darius = GG.Darius
	Darius:ClearGame() --Clear any previous/current game data

	if not (SendDecksToSession()) then
		spEcho("Could not start game, decks are not valid ("..deck1Index..", "..deck2Index..")")
		return false
	end
	Darius:AddGreenballs(100)
	return true
end

function gadget:AddCardToPlayer(cardName, amount)

	--If no amount was given, add one card
	amount = amount or 1

	for i = 1, amount do
		table.insert(pool, gadget:GetCardDataByName(cardName))
	end

	UnsyncCardPool()
end

function gadget:RemoveCardFromPlayer(cardName, amount)

	--If no amount was given, remove one card
	amount = amount or 1

	--Index for the last seen instance of the card
	local previousInstance = 1

	--
	for i = 1, amount do

		for j = previousInstance, #pool do --We don't need to loop the whole pool, it's enough to continue from the last instance

			if pool[j].name == cardName then
				table.remove(pool, j)
				previousInstance = j
				break --Breaks the inner loop
			end
		end
	end

	UnsyncCardPool()
end

function gadget:GetCardDataByName(cardName)
	for i=1, #cardData do
		if cardData[i].name == cardName then
			return cardData[i]
		end
	end
	return nil
end

--------------------
-- Synced Callins --
--------------------
function gadget:Initialize()

	if (debug_message) then
		debug_message("Initializing Card Pool System")
	end

	LoadCardsFromFiles()
end

function gadget:GameFrame(f) --This is a temporary thing for testing
	--UnsyncCardPool()
	--UnsyncDecks()
end

function gadget:Shutdown()
end

function gadget:RecvLuaMsg(message, playerID)--Messaging between Deck Editor and the card pool
	if (not message) then return end
	if message == "UnsyncCardPool" then
		UnsyncCardPool()

	elseif message == "StartNewGame" then
		gadget:StartGame()

	elseif message == "UnsyncDecks" then
		UnsyncDecks()

	elseif message == "UnsyncDeckSelection" then -- The deck editor needs this to get the selected decks
		UnsyncDeckSelection()

	elseif string.find(message, "UnsyncCard:") then --Unsync Card data by name
		local cardName = message:gsub("UnsyncCard:","")
		local card = gadget:GetCardDataByName(cardName)
		UnsyncCard(card)

	elseif string.find(message, "SetCardPool:") then --Workaround for Loader in unsynced.  Can only be called once
		if (card_pool_loaded) then return end --TEST: Hopefully this works
		message = message:gsub("SetCardPool:", "")
		ParsePool(message)
		card_pool_loaded = true

	elseif string.find(message, "SetDecks:") then
		message = message:gsub("SetDecks:", "")
		if (debug_message) then debug_message("Received SetDecks:"..message) end
		gadget:ParseDecks(message)
		UnsyncDecks() -- Once the decks have been received from the editor, they also need to be saved (the editor would be kinda pointles otherwise)

	elseif string.find(message, "SetActiveDecks:") then --Sets which decks the player wants to use in the game by index
		message = message:gsub("SetActiveDecks:", "")
		local separatorIndex = message:find(",") -- The deck numbers should be separated by a comma
		local index1 = tonumber(message:sub(1, separatorIndex - 1))
		local index2 = tonumber(message:sub(separatorIndex + 1))
		SetActiveDeckIndexes(index1, index2)
	end

end

------------------------------------------------
else --unsynced
------------------------------------------------

---------------------
-- Unsynced Locals --
---------------------
local GAMEDATA_FILENAME = 'LuaUI/Config/Darius_data.lua'

pool = {} -- Stores names only
decks = {} -- Stores names only
selection = {1,2} -- Stores deck ids

-------------------------------
-- Unsynced Member Functions --
-------------------------------

function gadget:LoadData()
	if (debug_message) then debug_message("Loading Player Data") end
	--Get table by executing script file

	--TODO: Make sure exists
	if not (VFS.FileExists(GAMEDATA_FILENAME)) then return false end

	if (debug_message) then debug_message("Loading " .. GAMEDATA_FILENAME) end
	data = VFS.Include(GAMEDATA_FILENAME)

	if (not data) then return end
	if (type(data) == 'table') then
		if (data.pool and type(data.pool) == 'table') then
			poolString = CreatePoolString(data.pool)
			spSendLuaRulesMsg("SetCardPool:"..poolString)
			if (debug_message) then debug_message("Pool = " .. table.tostring(data.pool)) end
			pool = data.pool --Unsynced side
		end
		if (data.decks and type(data.decks) == 'table') then
			decksString = CreateDecksString(data.decks)
			spSendLuaRulesMsg("SetDecks:"..decksString)
			if (debug_message) then debug_message("Decks = " .. table.tostring(data.decks)) end
			if (debug_message) then debug_message("SetDecks:"..decksString) end
			decks = data.decks --Unsynced side
		end
		if (data.selection and type(data.selection) == 'table') then
			spSendLuaRulesMsg("SetActiveDecks:"..data.selection[1]..","..data.selection[2])
			selection = data.selection
			if (debug_message) then debug_message("SetActiveDecks:"..data.selection[1]..","..data.selection[2]) end
		end
	end
	return true
end


-------------------------------------
-- Sending data to the widget side --
-------------------------------------
local function RecvCardPool(_, str)
	if (debug_message) then debug_message("Unsynced:Receiving Pool: " .. str) end

	pool = string.totable(str)

	if (Script.LuaUI('SaveGameData')) then
		Script.LuaUI.SaveGameData(pool, decks, selection)
	end

	if (Script.LuaUI('SetDeckEditorCardPool')) then
		Script.LuaUI.SetDeckEditorCardPool(pool)--The name of the widget registered global
	end

end

local function RecvDecks(_, str)
	if (debug_message) then debug_message("Unsynced:Receiving Decks: " .. str) end

	decks = string.totable(str)

	if (Script.LuaUI('SaveGameData')) then
		Script.LuaUI.SaveGameData(pool, decks, selection)
	end

	if (Script.LuaUI('SetDeckEditorDecks')) then
		Script.LuaUI.SetDeckEditorDecks(decks)
	end
end

local function RecvDeckSelection(_, str)
	if (debug_message) then debug_message("Unsynced:Receiving Deck Indices: " .. str) end

	local separatorIndex = str:find(",") -- The deck numbers should be separated by a comma
	local index1 = tonumber(str:sub(1, separatorIndex - 1))
	local index2 = tonumber(str:sub(separatorIndex + 1))
	selection = {index1, index2}


	if (Script.LuaUI('SaveGameData')) then
		Script.LuaUI.SaveGameData(pool, decks, selection)
	end

	if (Script.LuaUI('SetDeckEditorDeckSelection')) then
		Script.LuaUI.SetDeckEditorDeckSelection(selection)
	end
end

local function RecvCard(_, ...)
	if Script.LuaUI('SetDeckEditorActiveCard') then
		Script.LuaUI.SetDeckEditorActiveCard(...)
	end
end

----------------------
-- Unsynced Callins --
----------------------
function gadget:Initialize() -- I believe that this is guaranteed to run after its synced side counterpart (though it might run concurrently)
	gadgetHandler:AddSyncAction("cardpool", RecvCardPool)--This is the one that gets called on the SendToUnsynced
	gadgetHandler:AddSyncAction("decksCollection", RecvDecks)
	gadgetHandler:AddSyncAction("deckSelection", RecvDeckSelection)
	gadgetHandler:AddSyncAction("UnsyncingCard", RecvCard)

	gadget:LoadData()
	spSendLuaRulesMsg("StartNewGame")
end

function gadget:Shutdown()
end

end -- End synced check
