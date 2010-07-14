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
function table.copy(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end

function table.compare(t1, t2)
	if (#t1 ~= #t2) then return false end
	for k,v in pairs(t1) do
		if (t2[k] ~= v) then return false end
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

local VFSdirlist_called = false
local VFSinclude_called = false
local cleargame_called = false

---------------------
-- Spoof functions --
---------------------
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

function test_ClearOldGame()
	gadget:StartGame()
	assert_true(cleargame_called, "Old Game not cleared")
end

function test_SetGreenballs()
	gadget:StartGame()
	assert_equal(20, greenballs)
end

function test_DeckSending()
	gadget:StartGame()
	assert_equal(0, #cards, "Should not have games to send")
end

function test_DeckSending_Loaded()
	gadget:Initialize()
	assert_equal(3, #cards, "Wrong number of cards sent")
	assert_equal(1, cards[1].deck, "Material Card not added to deck correctly")
	assert_equal(2, cards[2].deck, "Weapon Card not added to deck correctly")
	assert_equal(3, cards[3].deck, "Special Card not added to deck correctly")
end

--------------------
-- Saving/Loading --
--------------------

function test_SavePlayerData()
	gadget:SaveData()
end

function test_LoadPlayerData()
	gadget:LoadData()
end

--------------
-- Shutdown --
--------------

function test_Shutdown()
	gadget:Shutdown()
end