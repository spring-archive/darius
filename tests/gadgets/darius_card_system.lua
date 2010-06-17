-- System spoof --
Spring = {}
gadget = {}
gadgetHandler = {}
Script = {}
Script.LuaUI = {}
GG = {}

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
	for k,v in pairs(t1) do
		if (t2[k] ~= v) then return false end
	end
	return true
end

------------------
-- Example Data --
------------------

local exampleCard = {
	name = "Stone", 
	type = "Material", 
	img = 'LuaUI/images/stone.png',
	health =   1200,
	reloadTime = 0.5,
	range =  50,
	LOS = 500,
	damage =  0,
	weaponVelocity = 0,
	desc = "Creates tall stone towers with decent range and good amount of health,\n" ..
		"but due to tall design, adds additional weapon reloading time.",
}

-------------------------
-- Control Definitions -- System spoofing and return checking
-------------------------
-- Return vars --
local synced = true
local sentVars = {}
local syncActions = {}

local received = nil -- For received messages and ref names
local tower
local effect
local hand = {}
local card = {}
local selectedMaterial
local selectedWeapon
local selectedSpecial
local greenballs

function gadgetHandler:IsSyncedCode()
	return synced
end
function gadgetHandler:AddSyncAction(onMsg, func)
	table.insert(syncActions[onMsg], func)
end
function Spring.Echo(msg)
	received = msg
end
function Spring.SendLuaRulesMsg(msg)
	received = msg
end
function SendToUnsynced(ref, msg)
	sentVars[ref] = msg
	received = ref
end
function Script.LuaUI.SetTower(id)
	tower = id
end
function Script.LuaUI.SetCardEffect(arg)
	effect = arg
end
function Script.LuaUI.SetCardHand(str)
	local new_hand = {}
	for id in string.gmatch(str, "%d+") do
		id = 0 + id
		table.insert(new_hand, id)
	end
	hand = new_hand
end
function Script.LuaUI.UpdateCard(id, img, name, type, health, reloadTime, range, LOS, damage, weaponVelocity, desc)
	card = {id, img, name, type, health, reloadTime, range, LOS, damage, weaponVelocity, desc}
end
function Script.LuaUI.SetSelectedMaterialCard(id)
	selectedMaterial = id
end
function Script.LuaUI.SetSelectedWeaponCard(id)
	selectedWeapon = id
end
function Script.LuaUI.SetSelectedSpecialCard(id)
	selectedSpecial = id
end
function Script.LuaUI.SetGreenballs(balls)
	greenballs = balls
end

----------------
-- Test Setup --
----------------

module( "enhanced", package.seeall, lunit.testcase )

function setup()
	sentVars = {}
	received = nil
	synced = true
	dofile("../src/luarules/gadgets/darius_card_system.lua")
end

function teardown()
end

----------------------------
------ Test functions ------
----------------------------

-----------
-- Basic --
-----------

function test_Accessible()
	assert_not_nil(GG.Darius, "Darius not accessible")
end

-------------------
-- Communication --
-------------------

function test_SendingTower()
end

function test_SendingEffect()
end

function test_SendingSelected()
end

function test_SendingGreenballs()
end

function test_SendingHand()
end

function test_SendingCard()
	
end

-------------
-- Getters --
-------------

function test_CanDraw()
	assert_false(GG.Darius:CanDraw(), "Should not be able to draw yet")
	GG.Darius:AddGreenballs(200)
	assert_true(GG.Darius:CanDraw(), "Should be able to draw now")
end

----------------------
-- Member functions --
----------------------

function test_AddCard()
	local card1 = table.copy(exampleCard)
	local cards = {}
	assert_equal(0, GG.Darius:GetDeckSize(1), "Deck 1 has cards entering test!")
	assert_equal(0, GG.Darius:GetDeckSize(2), "Deck 2 has cards entering test!")

	GG.Darius:AddCard(card1, 3)
	id = card1.id or 0
	assert_nil(card1.id, "Card should not have been added. (has id " .. id .. ")")

	for i=1, 6 do
		cards[i] = table.copy(exampleCard)
		GG.Darius:AddCard(cards[i], i%2 + 1)
		assert_equal(i, cards[i].id, "First Card ID: " .. cards[i].id .. " != " .. i)
	end

	assert_equal(3, GG.Darius:GetDeckSize(1), "Deck 1 does not contain 3 cards")
	assert_equal(3, GG.Darius:GetDeckSize(2), "Deck 2 does not contain 3 cards")
end

function test_Towers()
	GG.Darius:SetEffect("Boom")
	GG.Darius:SetTower(120)
	assert_equal(120, GG.Darius:GetTower(), "Tower ID not handled properly")
	assert_equal(nil, GG.Darius:GetEffect(), "Effect ID not cleared")
end

function test_Effects()
	GG.Darius:SetTower(120)
	GG.Darius:SetEffect("Boom")
	assert_equal(nil, GG.Darius:GetTower(), "Tower ID not cleared")
	assert_equal("Boom", GG.Darius:GetEffect(), "Effect ID not handled properly")
end

function test_Greenballs()
	local balls = GG.Darius:GetGreenballs()
	GG.Darius:AddGreenballs(20)
	assert_equal(balls + 20, GG.Darius:GetGreenballs(), "Balls not added correctly")
end

function test_DrawCard()
	-- Basic initial setup
	local card1 = table.copy(exampleCard)
	local card2 = table.copy(exampleCard)
	local card3 = table.copy(exampleCard)
	assert_equal(0, #GG.Darius:GetHand(), "Hand wrong size going into test")
	
	-- Add Greenballs
	GG.Darius:AddGreenballs(200)

	-- Attempt to draw when no cards exist
	GG.Darius:DrawCard(1)
	assert_equal(0, #GG.Darius:GetHand(), "Hand should not have increased (no cards should exist)")

	-- Add cards
	GG.Darius:AddCard(card1, 1)
	GG.Darius:AddCard(card2, 2)

	-- Attempt to draw from a non-existant deck
	GG.Darius:DrawCard(3)
	assert_equal(0, #GG.Darius:GetHand(), "Hand should not have increased (deck 3 is invalid)")

	-- Draw
	GG.Darius:DrawCard(1)
	assert_equal(1, #GG.Darius:GetHand(), "Hand should have increased (should contain card)")
	GG.Darius:DrawCard(1)
	assert_equal(1, #GG.Darius:GetHand(), "Hand should not have increased")
	GG.Darius:DrawCard(2)
	assert_equal(2, #GG.Darius:GetHand(), "Hand should have increased")
	GG.Darius:DrawCard(2)
	assert_equal(2, #GG.Darius:GetHand(), "Hand should not have increased")

	-- Remove all Greenballs, add a card, and try to draw
	GG.Darius:AddGreenballs(-200)
	GG.Darius:AddCard(card3, 1)
	GG.Darius:DrawCard(1)
	assert_equal(2, #GG.Darius:GetHand(), "Hand should not have increased (not enough Greenballs)")
end

function test_CardSelection()
end

function test_DiscardSelected()
end

function test_ClearGame()
end
