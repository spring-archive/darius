-- System spoof --
gadget = {}
Spring = {}
gadgetHandler = {}
VFS = {}
GG = {}
GG.Darius = {}

---------------------
-- Table Functions --
---------------------
function table.copy(t) end --Defined in darius_card_pool
function table.tostring(t) end --Defined in darius_card_pool
function string.totable(s) end --Defined in darius_card_pool

function table.compare(t1, t2)
	if (t1 == t2) then return true end
	if (type(t1) ~= "table") then return false end
	if (type(t2) ~= "table") then return false end
	if (#t1 ~= #t2) then return false end
	for k,v in pairs(t1) do
		if (type(v) == "table") then
			if not (table.compare(v, t2[k])) then return false end
		else
			if (t2[k] ~= v) then return false end
		end
	end
	return true
end

------------------
-- Example Data --
------------------

local exampleMaterial = {
	name = "Stone",
	type = "Material",
	img = 'cards/images/stone.png',
	health =   1200,
	reloadTime = 0.5,
	range = 50,
	greenballs = 0,
	desc = "Creates tall stone towers with decent range and good amount of health,\n" ..
		"but due to tall design, adds additional weapon reloading time.",
}

local exampleWeapon = {
	name = "Fire",
	type = "Weapon",
	img = 'cards/images/fire.png',
	health =   1200,
	reloadTime = 0.5,
	range =  50,
	damage =  0,
	greenballs = 0,
	desc = "Creates tall stone towers with decent range and good amount of health,\n" ..
		"but due to tall design, adds additional weapon reloading time.",
}

local exampleEffect = {
	needsPos = false,
	needsUnit = false,
	effect = function() effect_called = true end,
	display = function() end,
	desc = "Freezes enemies in place",
}

local exampleSpecial = {
	name = "Freeze",
	type = "Special",
	img = 'cards/images/freeze.png',
	greenballs = 0,
	effect = exampleEffect,
	desc = "Creates tall stone towers with decent range and good amount of health,\n" ..
		"but due to tall design, adds additional weapon reloading time.",
}

-------------------------
-- Control Definitions -- System spoofing and return checking
-------------------------
local synced = true

local messages = {}
local cards = {}
local greenballs = 0
local savedTable = nil

local VFSdirlist_called = false
local VFSinclude_called = false
local cleargame_called = false

local lastLuaMessage = "" --Strores the lastest message sent with SendToUnsynced()

---------------------
-- Spoof functions --
---------------------
function table.save(t, file, header)
	savedTable = table.copy(t)
end

function gadgetHandler:IsSyncedCode() return synced end

function Spring.Echo(msg) table.insert(messages, msg) end
function debug_message(msg) table.insert(messages, msg) end

function VFS.DirList(dir, extension)
	VFSdirlist_called = true
	if (dir == 'cards/lua/material') then return {'material'} end
	if (dir == 'cards/lua/weapon') then return {'weapon'} end
	if (dir == 'cards/lua/special') then return {'special'} end
end

function VFS.Include(file)
	VFSinclude_called = true
	if (file == 'material') then return exampleMaterial end
	if (file == 'weapon') then return exampleWeapon end
	if (file == 'special') then return exampleSpecial end
end

function GG.Darius:ClearGame() cleargame_called = true end
function GG.Darius:AddGreenballs(balls) greenballs = greenballs + balls end
function GG.Darius:AddCard(card, deckID)
	card.deck = deckID
	table.insert(cards, card)
end

function SendToUnsynced(name, message, ...)
	name = name or "nil"
	message = message or "nil"

	lastLuaMessage = name .. message
end
----------------
-- Test Setup --
----------------

module( "enhanced", package.seeall, lunit.testcase )

function setup()
	synced = true
	dofile("../src/luarules/gadgets/darius_card_pool.lua")
end

function teardown()
	synced = true
	messages = {}
	cards = {}
	greenballs = 0
	savedTable = nil

	VFSdirlist_called = false
	VFSinclude_called = false
	cleargame_called = false
end

local function RunAsUnsynced()
	synced = false
	dofile("../src/luarules/gadgets/darius_card_pool.lua")
end

----------------------------
------ Test functions ------
----------------------------

---------------------
-- Table functions --
---------------------
function test_StringToTable_Empty()
	tableString = "{}"
	expected = {}
	t = string.totable(tableString)
	assert_equal("table", type(t))
	assert_equal(0, #t, table.tostring(messages))
	assert_true(table.compare(expected, t), table.tostring(t))
end

function test_StringToTable_Simple()
	tableString = "{Hello}"
	expected = {"Hello"}
	t = string.totable(tableString)
	assert_equal("table", type(t))
	assert_equal(1, #t, table.tostring(messages))
	assert_equal("Hello", t[1], table.tostring(messages))
	assert_true(table.compare(expected, t), table.tostring(t))
end

function test_StringToTable_Two()
	tableString = "{First,Second}"
	expected = {"First","Second"}
	t = string.totable(tableString)
	assert_equal("table", type(t))
	assert_equal(2, #t, table.tostring(messages))
	assert_equal("First", t[1], table.tostring(messages))
	assert_equal("Second", t[2], table.tostring(messages))
	assert_true(table.compare(expected, t), table.tostring(t))
end

function test_StringToTable_Explicit()
	tableString = "{hello = Hello}"
	expected = {hello = "Hello"}
	t = string.totable(tableString)
	assert_equal("table", type(t))
	assert_equal("Hello", t['hello'], table.tostring(t))
	assert_true(table.compare(expected, t), table.tostring(t))
end

function test_StringToTable_Nested()
	tableString = "{{first},{second}}"
	expected = {{"first"},{"second"}}
	t = string.totable(tableString)
	assert_equal("table", type(t))
	assert_equal(2, #t, table.tostring(messages))
	assert_equal("table", type(t[1]), table.tostring(messages))
	assert_equal("table", type(t[2]), table.tostring(messages))
	assert_true(table.compare(expected, t), table.tostring(t))
end

function test_StringToTable_ExplicitNested()
	tableString = "{{first = first},{first = second}}"
	expected = {{first = "first"},{first = "second"}}
	t = string.totable(tableString)
	assert_equal("table", type(t))
	assert_equal(2, #t, table.tostring(messages))
	assert_equal("table", type(t[1]), tostring(t[1]))
	assert_equal("table", type(t[2]), tostring(t[2]))
	assert_true(table.compare(expected, t), table.tostring(t))
end

--------------------
-- Initialization --
--------------------

function test_Info()
	assert_not_nil(gadget:GetInfo(), "GetInfo function broken")
	assert_table(gadget:GetInfo(), "GetInfo function broken")
end

function test_Initialization()
	gadget:Initialize()
	assert_equal("Initializing Card Pool System", messages[1], "Initialization function didn't run")
end

function test_InitialPoolEmpty()
end

function test_InitialDecksEmpty()
end

function test_CardDataLoading()
	gadget:Initialize()
	assert_true(VFSdirlist_called, "Data Loader didn't get File lists")
	assert_true(VFSinclude_called, "Data Loader didn't get card data from files")
end

---------------
-- StartGame --
---------------

function test_ClearsOldGame()
	gadget:StartGame()
	assert_true(cleargame_called, "Old Game not cleared")
end

function test_DeckSending_NoDecks()
	gadget:StartGame()
	assert_equal(0, #cards, "Should not have cards to send")
end

function test_DeckSending_ValidDecks()
	gadget:Initialize() --Loads data
	gadget:StartGame()
	gadget:ParseDecks("{{Fire,},{Stone,},}")
	assert_equal(2, #cards, "Should have cards to send")
end

function test_Greenballs_NoDecks()
	gadget:StartGame()
	assert_equal(0, greenballs, table.tostring(messages))
end

function test_Greenballs_ValidDecks()
	gadget:Initialize() --Loads data
	gadget:StartGame()
	gadget:ParseDecks("{{Fire,},{Stone,},}")
	assert_equal(20, greenballs, table.tostring(messages))
end

--------------------
-- Saving/Loading --
--------------------

function test_SavePlayerData()
	RunAsUnsynced()
	gadget:SaveData()
	assert_equal("Saving Player Data", messages[1])
	assert_equal("Saving to LuaUI/Config/Darius_data.lua", messages[2])
end

function test_LoadPlayerData()
	RunAsUnsynced()
	gadget:LoadData()
end


-----------------------
-- Interface Testing --
-----------------------

function test_AddCardToPlayer()
	gadget:Initialize()
	gadget:AddCardToPlayer(exampleMaterial.name)
	assert_true(string.find(lastLuaMessage, exampleMaterial.name) >= 0) --Checks that the unsynced card pool contains the card name
end

function test_AddManyCardsToPlayer()
	local amount = 10 --amount of cards to add
	local lastInstance = 1

	gadget:Initialize()
	gadget:AddCardToPlayer(exampleWeapon.name, amount)

	for i = 1, amount do
		lastInstance = string.find(lastLuaMessage, exampleWeapon.name, lastInstance)
		assert_true(lastInstance >= 0)
	end

end

function test_RemoveCardFromPLayer()
	gadget:Initialize()
	gadget:RemoveCardFromPlayer(exampleMaterial.name)
	gadget:RemoveCardFromPlayer(exampleWeapon.name)
	gadget:RemoveCardFromPlayer(exampleSpecial.name)
	gadget:RemoveCardFromPlayer(exampleEffect.name)

	assert_equal(lastLuaMessage, "cardpool{}")
end

function test_GetCardDataByName()
	gadget:Initialize()
	assert_equal(gadget:GetCardDataByName(exampleMaterial.name), exampleMaterial)
end



function test_Messaging()
	gadget:Initialize()

	gadget:RecvLuaMsg("UnsyncCardPool", 1)
	assert_true(string.find(lastLuaMessage, "cardpool") >= 0)

	gadget:RecvLuaMsg("UnsyncDecks", 1)
	assert_true(string.find(lastLuaMessage, "decksCollection") >= 0)

	gadget:RecvLuaMsg("UnsyncCard:" .. exampleWeapon.name, 1)
	assert_true(string.find(lastLuaMessage, "CardTable") >= 0)

end

--------------
-- Shutdown --
--------------

function test_Shutdown()
	gadget:Shutdown()
end
