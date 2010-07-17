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

local debug_message = spEcho

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
			str = str .. k.. " = " .. table.tostring(v) .. ", "
		else
			str = str .. k.. " = " .. v .. ", "
		end
	end
	str = str .. "}"
	return str
end

function string.totable(s) --Incomplete
--	t = {}
--	for tablestr in s:gmatch("%{(%w+)%}") do --Get Subtables
--		table.insert(t, string.totable(tablestr))
--	end
--	for word in s:gmatch("(%w+)%,") do --Get
--		table.insert(t, word)
--	end
--	return t
	--Remove outer brackets
	if (s:sub(1) == '{') then s = s:sub(2) end
	if (s:sub(-1) == ',') then s = s:sub(-2, 1) end
	if (s:sub(-1) == '{') then s = s:sub(-2, 1) end
	s = s .. ','        -- ending comma
	local t = {}        -- table to collect fields
	local fieldstart = 1
	while (fieldstart < string.len(s)) do
		-- next field is table? (start with '{'?)
		if (s[fieldstart] == '{') then
			local i
			-- find closing bracket
			i = string.find(s, '}', fieldstart+1) --NOTE: second table inside causes problems
			if not i then error('unmatched bracket') end

			local f = string.sub(s, fieldstart+1, i-1)
			table.insert(t, string.totable(f))
			fieldstart = string.find(s, ',', i) + 1
		else -- find next comma
			local nexti = string.find(s, ',', fieldstart)
			table.insert(t, string.sub(s, fieldstart, nexti-1))
			fieldstart = nexti + 1
		end
	end
	return t
end

---------------------------
-- Table to String Funcs --
---------------------------
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

---------------------
-- Local Functions --
---------------------
local function LoadCardsFromFiles()
	pool = {}
	decks[1] = {}
	decks[2] = {}
	decks[3] = {} -- Fake deck
	local materialFiles = VFS.DirList('cards/lua/material', '*.lua')
	local weaponFiles = VFS.DirList('cards/lua/weapon', '*.lua')
	local specialFiles = VFS.DirList('cards/lua/special', '*.lua')

	for i=1, #materialFiles do
		local card = VFS.Include(materialFiles[i])
		table.insert(cardData, card)
		table.insert(pool, card) --Temporary (player gets one of each card)
		table.insert(decks[1], card) --Temporary (puts the card into a deck once)
	end

	for i=1, #weaponFiles do
		local card = VFS.Include(weaponFiles[i])
		table.insert(cardData, card)
		table.insert(pool, card) --Temporary (player gets one of each card)
		table.insert(decks[2], card) --Temporary (puts the card into a deck once)
	end

	for i=1, #specialFiles do
		local card = VFS.Include(specialFiles[i])
		table.insert(cardData, card)
		table.insert(pool, card) --Temporary (player gets one of each card)
		table.insert(decks[3], card) --Temporary (puts the card into a deck once)
	end
end

local function SendDecksToSession()  -- Sends the decks to the instance game manager

	if (not decks[deck1Index]) then return false end
	if (not decks[deck2Index]) then return false end

	for i=1, #decks[deck1Index] do
		Darius:AddCard(table.copy(decks[deck1Index][i]), i) --Card table must be copied to create unique instance
	end

	for i=1, #decks[deck2Index] do
		Darius:AddCard(table.copy(decks[deck2Index][i]), i)
	end

	return true
end

local function SetActiveDeckIndexes(index1, index2) --Sets the decks the user wishes to use
	deck1Index = index1
	deck2Index = index2
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

	if (SendDecksToSession()) then
		Darius:AddGreenballs(20)
	else
		spEcho("Could not start game, decks are not valid ("..deck1Index..", "..deck2Index..")")
	end
end

-------------------
-- Communication --
-------------------

local function UnsyncCardPool()
	poolString = CreatePoolString(pool)
	SendToUnsynced("cardpool", poolString)
end

local function ParsePool(poolString)
	local newPool = string.totable(poolString)
	newPool = {"Stone", "Fire",}
	pool = {}
	for i = 1, #newPool do
		table.insert(pool, gadget:GetCardDataByName(newPool[i]))
	end
end

local function UnsyncDecks()
	decksString = CreateDecksString(decks)
	SendToUnsynced("decksCollection", decksString)
end

local function ParseDecks(decksString)
	local newDecks = string.totable(decksString) -- => "local newDecks = {{..,},{..,},..,}"
	newDecks = {{"Stone",},{"Fire",},}
	decks = {}
	for i = 1, #newDecks do
		decks[i] = {}
		for j = 1, #newDecks[i] do
			table.insert(decks[i], gadget:GetCardDataByName(newDecks[i][j]))
		end
	end	
end

-- Requires actual card
local function UnsyncCard(card)
	if not (card) then return end
	--if (debug_message) then debug_message("Unsyncing card [" .. card.id .. "]") end
	SendToUnsynced("CardTable",
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

-------------------------
-- Card pool functions --
-------------------------
function gadget:AddCardToPlayer(cardName, amount)
	UnsyncCardPool()
end

function gadget:RemoveCardFromPlayer(cardName, amount)
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
		ParseDecks(message)

	elseif string.find(message, "SetActiveDecks:") then --Sets which decks the player wants to use in the game by index
		message = message:gsub("SetActiveDecks:", "")
		local separatorIndex = message:find(",") -- The deck numbers should be separated by a ,
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
local LUAUI_DIRNAME = 'LuaUI/'
local GAMEDATA_FILENAME = LUAUI_DIRNAME .. 'Config/Darius_data.lua'
VFS.Include(LUAUI_DIRNAME .. 'savetable.lua')

pool = {} -- Stores names only
decks = {} -- Stores names only

----------------------
-- Unsynced Callins --
----------------------

function gadget:Initialize() -- I believe that this is guaranteed to run after its synced side counterpart
	gadget:LoadData()
	spSendLuaRulesMsg("StartNewGame")
end

function gadget:LoadData()
	if (debug_message) then debug_message("Loading Player Data") end
	--Get table by executing script file
	--TODO: Make sure exists (Minor issue, as it fails gently)
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
			decks = data.decks --Unsynced side
		end
	end
end

function gadget:SaveData()
	if (debug_message) then debug_message("Saving Player Data") end
	data = {}
	data.pool = pool
	data.decks = decks
	if (debug_message) then debug_message("Saving to "..GAMEDATA_FILENAME) end
	--Save Table as script file
	table.save(data, GAMEDATA_FILENAME, '-- Darius Game Data')
end

function gadget:Shutdown()
	gadget:SaveData()
end

end -- End synced check
