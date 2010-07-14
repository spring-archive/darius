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
local spEcho = Spring.Echo

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

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

---------------------
-- Local Variables --
---------------------
local CardPool = gadget
GG.CardPool = CardPool


local cardData = {}

local test = 0
local pool = {}
local deck = {} --Collection of decks
deck[1] = {} --Deck 1; Stores the card tables themselves (for the cards in the deck)
deck[2] = {} --Deck 2; Stores the card tables themselves (for the cards in the deck)

---------------------
-- Local Functions --
---------------------
local function LoadCardsFromFiles()
	pool = {}
	deck[1] = {}
	deck[2] = {}
	deck[3] = {} -- Fake deck
	local materialFiles = VFS.DirList('cards/lua/material', '*.lua')
	local weaponFiles = VFS.DirList('cards/lua/weapon', '*.lua')
	local specialFiles = VFS.DirList('cards/lua/special', '*.lua')

	for i=1, #materialFiles do
		local card = VFS.Include(materialFiles[i])
		table.insert(cardData, card)
		table.insert(pool, card) --Temporary (player gets one of each card)
		table.insert(deck[1], card) --Temporary (puts the card into a deck once)
	end

	for i=1, #weaponFiles do
		local card = VFS.Include(weaponFiles[i])
		table.insert(cardData, card)
		table.insert(pool, card) --Temporary (player gets one of each card)
		table.insert(deck[2], card) --Temporary (puts the card into a deck once)
	end

	for i=1, #specialFiles do
		local card = VFS.Include(specialFiles[i])
		table.insert(cardData, card)
		table.insert(pool, card) --Temporary (player gets one of each card)
		table.insert(deck[3], card) --Temporary (puts the card into a deck once)
	end
end


local function GetCardDataByName(cardName)
	for i=1, #cardData do
		if cardData[i].name == cardName then
			return cardData[i]
		end
	end
	return nil
end


local function SendDecks()  -- Sends the decks to the instance game manager
	for i=1, #deck do
		for j=1, #deck[i] do
			Darius:AddCard(table.copy(deck[i][j]), i) --Card table must be copied to create unique instance
		end
	end
end

----------------------
-- Member Functions --
----------------------

function gadget:StartGame()
	if (not GG.Darius) then
		spEcho("Game failed to load properly")
		return
	end

	Darius = GG.Darius
	Darius:ClearGame() --Clear any previous/current game

	SendDecks()

	Darius:AddGreenballs(20)
	if(debug_message) then debug_message("Test = "..test) end
end




local function SendCardPoolToUnsynced()
end

local function SendDecsToUnsynced()
end

local function ParseDeck()
end

-------------------------
-- Card pool functions --
-------------------------
function CardPool:AddCardToPlayer(cardName, amount)
end

function CardPool:RemoveCardFromPlayer(cardName, amount)
end

function CardPool:GetCardDataByName(cardName)
end



--------------------
-- Synced Callins --
--------------------
function gadget:Initialize()
	if (debug_message) then debug_message("Initializing Card Pool System") end
	LoadCardsFromFiles()
	gadget:StartGame()
end

function gadget:SaveData()
	if (debug_message) then debug_message("Saving Player Data") end
	data = {}
	data.pool = {}
	for i=1, #pool do
		table.insert(data.pool, pool[i].name) --Get the names of the cards
	end
	data.deck = {}
	for i=1, #deck do
		data.deck[i] = {}
		for j=1, #deck[i] do
			table.insert(data.deck[i], deck[i][j].name) --Get the names of the cards
		end
	end
	data.test = test

	--TODO: save Table
end

function gadget:LoadData()
	--TODO: get Table
	data = {}
	pool = {}
	deck = {}
	if (debug_message) then debug_message("Loading Player Data") end
	if (data and type(data) == 'table') then
		if (type(data.pool) == 'table') then
			for i=1, #data.pool do
				table.insert(pool, GetCardDataByName(data.pool[i])) --Get the cards by name
			end
		end
		if (type(data.deck) == 'table') then
			for i=1, #data.deck do
				if (type(data.deck[i]) == 'table') then
					deck[i] = {}
					for j=1, #data.deck[i] do
						table.insert(deck[i], GetCardDataByName(data.deck[i][j])) --Get the cards by name
					end
				end
			end
		end
		test = data.test or 0
	end
end

function gadget:Shutdown()
	data = gadget:SaveData() --TODO: Save data correctly
end

function gadget:RecvLuaMsg(message, playerID)--Messaging between Deck Editor and the card pool

	if message == "get card pool" then
		SendCardPoolToUnsynced()

	elseif message == "get decs" then
		SendDecsToUnsynced()

	elseif message == "get card data by name" then--FIXME separate card name from the message
		SendCardDataToUnsynced()

	elseif message == "deck coming through..." then --FIXME separate the message from the deck data
		ParseDeck(message)

	end

end

------------------------------------------------
else --unsynced
------------------------------------------------

end -- End synced check
