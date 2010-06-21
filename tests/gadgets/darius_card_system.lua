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
	if (#t1 ~= #t2) then return false end
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

local called_AddSyncAction = false
local called_SendToUnsynced = false

local received -- For received messages and ref names
local tower
local effect
local hand
local card
local selectedMaterial
local selectedWeapon
local selectedSpecial
local greenballs

---------------------
-- Spoof functions --
---------------------

function Spring.Echo(msg)
	received = msg
end
function Spring.SendLuaRulesMsg(msg)
	received = msg
end

function gadgetHandler:IsSyncedCode()
	return synced
end
function gadgetHandler:AddSyncAction(onMsg, func)
	called_AddSyncAction = true
	syncActions[onMsg] = func
end

function SendToUnsynced(ref, ...)
	called_SendToUnsynced = true
	sentVars[ref] = arg[1]
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
function Script.LuaUI.UpdateCard(id, name, type, img, health, reloadTime, range, LOS, damage, weaponVelocity, desc)
	card = {id=id, name=name, type=type, img=img, health=health, reloadTime=reloadTime,
		range=range, LOS=LOS, damage=damage, weaponVelocity=weaponVelocity, desc=desc}
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

-- Make it so the Script.LuaUI('function name') returns true
metamethod = { __call = function() return true end }
setmetatable(Script.LuaUI, metamethod)

----------------
-- Test Setup --
----------------

module( "enhanced", package.seeall, lunit.testcase )

function setup()
	synced = true
	dofile("../src/luarules/gadgets/darius_card_system.lua")
end

function teardown()
	synced = true
	sentVars = {}
	syncActions = {}

	called_AddSyncAction = false
	called_SendToUnsynced = false

	received = nil
	tower = nil
	effect = nil
	hand = nil
	card = nil
	selectedMaterial = nil
	selectedWeapon = nil
	selectedSpecial = nil
	greenballs = nil
end

function RunAsUnsynced()
	synced = false
	dofile("../src/luarules/gadgets/darius_card_system.lua")
end

----------------------------
------ Test functions ------
----------------------------

--------------------
-- Initialization --
--------------------

function test_Accessible()
	assert_not_nil(GG.Darius, "Darius not accessible")
end

function test_Info()
	assert_not_nil(GG.Darius:GetInfo(), "GetInfo function broken")
end

function test_RegistersSyncActions()
	RunAsUnsynced()
	gadget:Initialize()
	assert_true(called_AddSyncAction, "AddSyncAction not called")
	assert_not_nil(syncActions)
	assert_not_nil(syncActions["CardHand"])
	assert_not_nil(syncActions["CardTable"])
	assert_not_nil(syncActions["TowerID"])
	assert_not_nil(syncActions["CardEffect"])
	assert_not_nil(syncActions["SelectedMaterialCard"])
	assert_not_nil(syncActions["SelectedWeaponCard"])
	assert_not_nil(syncActions["SelectedSpecialCard"])
	assert_not_nil(syncActions["Greenballs"])
end

function test_InitialDecksEmpty()
	assert_equal(0, GG.Darius:GetDeckSize(1), "Deck 1 has cards on Init")
	assert_equal(0, GG.Darius:GetDeckSize(2), "Deck 2 has cards on Init")
end

function test_InitialHandEmpty()
	assert_equal(0, #GG.Darius:GetHand(), "Hand non-empty in Init")
end

-------------------
-- Communication --
-------------------

function test_SendingTower()
	RunAsUnsynced()
	gadget:Initialize()
	syncActions["TowerID"]("", 123)
	assert_equal(123, tower, "Tower ID not sent properly")
end

function test_SendingEffect()
	RunAsUnsynced()
	gadget:Initialize()
	syncActions["CardEffect"]("", "Scream")
	assert_equal("Scream", effect, "Effect not sent properly")
end

function test_SendingSelectedMaterial()
	RunAsUnsynced()
	gadget:Initialize()
	syncActions["SelectedMaterialCard"]("", 0)
	assert_equal(0, selectedMaterial, "Selected Material Card not sent properly")
end

function test_SendingSelectedWeapon()
	RunAsUnsynced()
	gadget:Initialize()
	syncActions["SelectedWeaponCard"]("", 0)
	assert_equal(0, selectedWeapon, "Selected Weapon Card not sent properly")
end

function test_SendingSelectedSpecial()
	RunAsUnsynced()
	gadget:Initialize()
	syncActions["SelectedSpecialCard"]("", 0)
	assert_equal(0, selectedSpecial, "Selected Special Card not sent properly")
end

function test_SendingGreenballs()
	RunAsUnsynced()
	gadget:Initialize()
	syncActions["Greenballs"]("", 20)
	assert_equal(20, greenballs, "Greenballs not sent properly")
end

function test_SendingHand()
	RunAsUnsynced()
	gadget:Initialize()
	syncActions["CardHand"]("", "0 2 3")
	assert_not_nil(hand, "Hand not received")
	assert_equal(0, hand[1], "Hand not sent properly")
	assert_equal(2, hand[2], "Hand not sent properly")
	assert_equal(3, hand[3], "Hand not sent properly")
	assert_equal(3, #hand, "Hand not sent properly")
	assert_true(table.compare({0,2,3}, hand))
end

function test_SendingCard()
	local testCard = table.copy(exampleCard)
	testCard.id = 0
	RunAsUnsynced()
	gadget:Initialize()
	syncActions["CardTable"]("", testCard.id, testCard.name, testCard.type, testCard.img,
		testCard.health, testCard.reloadTime, testCard.range, testCard.LOS,
		testCard.damage, testCard.weaponVelocity, testCard.desc)
	assert_not_nil(card, "Card not received")
	assert_equal(testCard.id, card.id, "Card id mangled")
	assert_equal(testCard.name, card.name, "Card name mangled")
	assert_equal(testCard.type, card.type, "Card type mangled")
	assert_equal(testCard.img, card.img, "Card img mangled")
	assert_equal(testCard.health, card.health, "Card health mangled")
	assert_equal(testCard.reloadTime, card.reloadTime, "Card reloadTime mangled")
	assert_equal(testCard.range, card.range, "Card range mangled")
	assert_equal(testCard.LOS, card.LOS, "Card LOS mangled")
	assert_equal(testCard.damage, card.damage, "Card damage mangled")
	assert_equal(testCard.weaponVelocity, card.weaponVelocity, "Card weaponVelocity mangled")
	assert_equal(testCard.desc, card.desc, "Card description mangled")
end

function test_UnsyncTower()
	GG.Darius:SetTower(123)
	assert_true(called_SendToUnsynced, "SendToUnsynced not called")
	assert_equal(123, sentVars["TowerID"], "Tower ID not unsynced correctly")
end

function test_UnsyncEffect()
	GG.Darius:SetEffect("Bunnies Away")
	assert_true(called_SendToUnsynced, "SendToUnsynced not called")
	assert_equal("Bunnies Away", sentVars["CardEffect"], "Effect not unsynced correctly")
end

function test_UnsyncSelectedMaterial()
	local testCard = table.copy(exampleCard)
	testCard.type = "Material"
	testCard.id = 9
	GG.Darius:ActivateCard(testCard)
	assert_true(called_SendToUnsynced, "SendToUnsynced not called")
	assert_equal(9, sentVars["SelectedMaterialCard"], "Material Card ID not unsynced correctly")
end

function test_UnsyncSelectedWeapon()
	local testCard = table.copy(exampleCard)
	testCard.type = "Weapon"
	testCard.id = 6
	GG.Darius:ActivateCard(testCard)
	assert_true(called_SendToUnsynced, "SendToUnsynced not called")
	assert_equal(6, sentVars["SelectedWeaponCard"], "Weapon Card ID not unsynced correctly")
end

function test_UnsyncSelectedSpecial()
	local testCard = table.copy(exampleCard)
	testCard.type = "Special"
	testCard.id = 4
	GG.Darius:ActivateCard(testCard)
	assert_true(called_SendToUnsynced, "SendToUnsynced not called")
	assert_equal(4, sentVars["SelectedSpecialCard"], "Special Card ID not unsynced correctly")
end

function test_UnsyncGreenballs()
	GG.Darius:AddGreenballs(20)
	assert_true(called_SendToUnsynced, "SendToUnsynced not called")
	assert_equal(20, sentVars["Greenballs"], "Greenballs not unsynced correctly")
end

function test_UnsyncOneCardHand()
	GG.Darius:AddCard(table.copy(exampleCard), 1)
	GG.Darius:AddGreenballs(200)
	GG.Darius:DrawCard(1)
	assert_true(called_SendToUnsynced, "SendToUnsynced not called")
	assert_equal("1 ", sentVars["CardHand"], "Hand not unsynced correctly")
end

function test_UnsyncCard()
	local testCard = table.copy(exampleCard)
	GG.Darius:AddCard(testCard, 1)
	gadget:RecvLuaMsg("Send Card Data:"..testCard.id, 0)
	assert_true(called_SendToUnsynced, "SendToUnsynced not called")
	assert_equal(testCard.id, sentVars["CardTable"], "Card not unsynced correctly")
end

function test_Message_Activate_Existing()
	local testCard = table.copy(exampleCard)
	testCard.type = "Material"
	GG.Darius:AddCard(testCard, 1)
	gadget:RecvLuaMsg("Activate Card:"..testCard.id, 0)

	assert_equal(testCard, GG.Darius:GetSelectedMaterial(), "Card not selected")
end

function test_Message_Activate_Invalid()
	local testCard = table.copy(exampleCard)
	testCard.type = "Material"
	testCard.id = 9
	gadget:RecvLuaMsg("Activate Card:"..testCard.id, 0)

	assert_not_equal(testCard, GG.Darius:GetSelectedMaterial(), "Card selected")
end

function test_Message_Draw()
	local testCard = table.copy(exampleCard)
	GG.Darius:AddCard(testCard, 1)
	GG.Darius:AddGreenballs(200)
	gadget:RecvLuaMsg("Draw Card:1", 0)
	assert_equal(1, #GG.Darius:GetHand(), "Hand not correctly set up for test")
end

function test_Message_SendCard()
	local testCard = table.copy(exampleCard)
	GG.Darius:AddCard(testCard, 1)
	gadget:RecvLuaMsg("Send Card Data:"..testCard.id, 0)
	assert_true(called_SendToUnsynced, "SendToUnsynced not called")
end

function test_Message_SendAll()
	sentVars["CardHand"]             = "Fail"
	sentVars["TowerID"]              = "Fail"
	sentVars["CardEffect"]           = "Fail"
	sentVars["SelectedMaterialCard"] = "Fail"
	sentVars["SelectedWeaponCard"]   = "Fail"
	sentVars["SelectedSpecialCard"]  = "Fail"
	sentVars["Greenballs"]           = "Fail"

	gadget:RecvLuaMsg("Resend All", 0)
	assert_true(called_SendToUnsynced, "SendToUnsynced not called")
	assert_not_equal("Fail", sentVars["CardHand"], "Hand not unsynced")
	assert_not_equal("Fail", sentVars["TowerID"], "Tower ID not unsynced")
	assert_not_equal("Fail", sentVars["CardEffect"], "Effect not unsynced")
	assert_not_equal("Fail", sentVars["SelectedMaterialCard"], "Material Card ID not unsynced")
	assert_not_equal("Fail", sentVars["SelectedWeaponCard"], "Weapon Card ID not unsynced")
	assert_not_equal("Fail", sentVars["SelectedSpecialCard"], "Special Card ID not unsynced")
	assert_not_equal("Fail", sentVars["Greenballs"], "Greenballs not unsynced")
end

----------------------
-- Member functions --
----------------------

function test_SetTower()
	GG.Darius:SetTower(120)
	assert_equal(120, GG.Darius:GetTower(), "Tower ID not handled properly")
end

function test_SetTowerClearsEffect()
	GG.Darius:SetEffect("Boom")
	GG.Darius:SetTower(120)
	assert_equal(120, GG.Darius:GetTower(), "Tower ID not handled properly")
	assert_equal(nil, GG.Darius:GetEffect(), "Effect ID not cleared")
end

function test_SetEffect()
	GG.Darius:SetEffect("Boom")
	assert_equal("Boom", GG.Darius:GetEffect(), "Effect ID not handled properly")
end

function test_SetEffectClearsTower()
	GG.Darius:SetTower(120)
	GG.Darius:SetEffect("Boom")
	assert_equal(nil, GG.Darius:GetTower(), "Tower ID not cleared")
	assert_equal("Boom", GG.Darius:GetEffect(), "Effect ID not handled properly")
end

function test_AddGreenballs()
	local balls = GG.Darius:GetGreenballs()
	GG.Darius:AddGreenballs(20)
	assert_equal(balls + 20, GG.Darius:GetGreenballs(), "Balls not added correctly")
end

function test_DiscardSelectedWithNoneSelected()
	local testCard = table.copy(exampleCard)
	GG.Darius:AddCard(testCard, 1)
	GG.Darius:AddGreenballs(200)
	GG.Darius:DrawCard(1)
	assert_equal(1, #GG.Darius:GetHand(), "Hand not correctly set up for test")
	
	GG.Darius:DiscardSelected()
	assert_nil(testCard.used, "Card used")
	assert_equal(1, #GG.Darius:GetHand(), "Card removed from hand")
end

function test_DiscardSelected_Material()
	local testCard = table.copy(exampleCard)
	testCard.type = "Material"
	GG.Darius:AddCard(testCard, 1)
	GG.Darius:AddGreenballs(200)
	GG.Darius:DrawCard(1)
	assert_equal(1, #GG.Darius:GetHand(), "Hand not correctly set up for test")

	GG.Darius:ActivateCard(testCard)
	GG.Darius:DiscardSelected()
	assert_true(testCard.used, "Card not marked as used")
	assert_equal(0, #GG.Darius:GetHand(), "Card not removed from hand")
end

function test_DiscardSelected_Weapon()
	local testCard = table.copy(exampleCard)
	testCard.type = "Weapon"
	GG.Darius:AddCard(testCard, 1)
	GG.Darius:AddGreenballs(200)
	GG.Darius:DrawCard(1)
	assert_equal(1, #GG.Darius:GetHand(), "Hand not correctly set up for test")

	GG.Darius:ActivateCard(testCard)
	GG.Darius:DiscardSelected()
	assert_true(testCard.used, "Card not marked as used")
	assert_equal(0, #GG.Darius:GetHand(), "Card not removed from hand")
end

function test_DiscardSelected_Special()
	local testCard = table.copy(exampleCard)
	testCard.type = "Special"
	GG.Darius:AddCard(testCard, 1)
	GG.Darius:AddGreenballs(200)
	GG.Darius:DrawCard(1)
	assert_equal(1, #GG.Darius:GetHand(), "Hand not correctly set up for test")

	GG.Darius:ActivateCard(testCard)
	GG.Darius:DiscardSelected()
	assert_true(testCard.used, "Card not marked as used")
	assert_equal(0, #GG.Darius:GetHand(), "Card not removed from hand")
end

function test_ClearGame_Tower()
	GG.Darius:SetTower(123)
	GG.Darius:ClearGame()
	assert_nil(GG.Darius:GetTower(), "Tower Not Cleared")
end

function test_ClearGame_Effect()
	GG.Darius:SetEffect("Fire Ball")
	GG.Darius:ClearGame()
	assert_nil(GG.Darius:GetEffect(), "Tower Not Cleared")
end

function test_ClearGame_SelectedMaterial()
	local testCard = table.copy(exampleCard)
	testCard.type = "Material"
	GG.Darius:ActivateCard(testCard)
	GG.Darius:ClearGame()
	assert_nil(GG.Darius:GetSelectedMaterial(), "Selected Material Card Not Cleared")
end

function test_ClearGame_SelectedWeapon()
	local testCard = table.copy(exampleCard)
	testCard.type = "Weapon"
	GG.Darius:ActivateCard(testCard)
	GG.Darius:ClearGame()
	assert_nil(GG.Darius:GetSelectedWeapon(), "Selected Weapon Card Not Cleared")
end

function test_ClearGame_SelectedSpecial()
	local testCard = table.copy(exampleCard)
	testCard.type = "Special"
	GG.Darius:ActivateCard(testCard)
	GG.Darius:ClearGame()
	assert_nil(GG.Darius:GetSelectedSpecial(), "Selected Special Card Not Cleared")
end

function test_ClearGame_Greenballs()
	GG.Darius:AddGreenballs(200)
	GG.Darius:ClearGame()
	assert_equal(0, GG.Darius:GetGreenballs(), "Greenballs Not Cleared")
end

function test_ClearGame_Hand()
	local testCard = table.copy(exampleCard)
	GG.Darius:AddCard(testCard, 1)
	GG.Darius:AddGreenballs(200)
	GG.Darius:DrawCard(1)

	GG.Darius:ClearGame()
	assert_equal(0, #GG.Darius:GetHand(), "Hand Not Cleared")
end

--------------------------
-- Adding and Shuffling --
--------------------------

function test_AddCardToInvalidDeck()
	local card1 = table.copy(exampleCard)

	GG.Darius:AddCard(card1, 10) -- Add a valid card to deck 10 (does not exist)
	id = card1.id or 0
	assert_nil(card1.id, "Card should not have been added. (has id " .. id .. ")")
end

function test_AddedCardsHaveUniqueIDs()
	local cards = {}

	for i=1, 6 do
		cards[i] = table.copy(exampleCard)
		GG.Darius:AddCard(cards[i], i%2 + 1)
		assert_equal(i, cards[i].id, "First Card ID: " .. cards[i].id .. " != " .. i)
	end
end

function test_CardAddedToCorrectDeck()
	local card1 = table.copy(exampleCard)

	GG.Darius:AddCard(card1, 2) -- Add a valid card to deck 10 (does not exist)
	assert_equal(1, GG.Darius:GetDeckSize(2), "Deck 2 does not contain 1 card")
end

function test_CardsAddedToCorrectDeck_Deck1()
	local cards = {}

	for i=1, 6 do
		cards[i] = table.copy(exampleCard)
		GG.Darius:AddCard(cards[i], 1)
	end

	assert_equal(6, GG.Darius:GetDeckSize(1), "Deck 1 does not contain 6 cards")
	assert_equal(0, GG.Darius:GetDeckSize(2), "Deck 2 does not contain 0 cards")
end

function test_CardsAddedToCorrectDeck_Deck2()
	local cards = {}

	for i=1, 6 do
		cards[i] = table.copy(exampleCard)
		GG.Darius:AddCard(cards[i], 2)
	end

	assert_equal(0, GG.Darius:GetDeckSize(1), "Deck 1 does not contain 0 cards")
	assert_equal(6, GG.Darius:GetDeckSize(2), "Deck 2 does not contain 6 cards")
end

function test_CardsAddedToCorrectDeck_Split()
	local cards = {}

	for i=1, 6 do
		cards[i] = table.copy(exampleCard)
		GG.Darius:AddCard(cards[i], i%2 + 1)
	end

	assert_equal(3, GG.Darius:GetDeckSize(1), "Deck 1 does not contain 3 cards")
	assert_equal(3, GG.Darius:GetDeckSize(2), "Deck 2 does not contain 3 cards")
end

-------------
-- Drawing --
-------------

function test_CannotDrawWithoutBalls()
	assert_false(GG.Darius:CanDraw(), "Should not be able to draw yet")
end

function test_CanDrawWithBalls()
	GG.Darius:AddGreenballs(200)
	assert_true(GG.Darius:CanDraw(), "Should be able to draw now")
end

function test_DrawFromEmptyDeck()
	-- Add Greenballs
	GG.Darius:AddGreenballs(200)

	-- Attempt to draw when no cards exist
	GG.Darius:DrawCard(1)
	assert_equal(0, #GG.Darius:GetHand(), "Hand should not have increased (no cards should exist in deck 1)")
end

function test_DrawFromInvalidDeck()
	-- Add Greenballs
	GG.Darius:AddGreenballs(200)

	-- Attempt to draw from a non-existant deck
	GG.Darius:DrawCard(3)
	assert_equal(0, #GG.Darius:GetHand(), "Hand should not have increased (deck 3 is invalid)")
end

function test_DrawWithoutBalls()
	local card1 = table.copy(exampleCard)
	GG.Darius:AddCard(card1, 1)

	GG.Darius:DrawCard(1)
	assert_equal(0, #GG.Darius:GetHand(), "Hand should not have increased (not enough Greenballs)")
end

function test_DrawCard()
	-- Basic initial setup
	local card1 = table.copy(exampleCard)
	local card2 = table.copy(exampleCard)
	local card3 = table.copy(exampleCard)

	-- Add Greenballs
	GG.Darius:AddGreenballs(200)

	-- Add cards
	GG.Darius:AddCard(card1, 1)
	GG.Darius:AddCard(card2, 2)

	-- Draw
	GG.Darius:DrawCard(1)
	assert_equal(1, #GG.Darius:GetHand(), "Hand should have increased (should contain card)")
	GG.Darius:DrawCard(1)
	assert_equal(1, #GG.Darius:GetHand(), "Hand should not have increased")
	GG.Darius:DrawCard(2)
	assert_equal(2, #GG.Darius:GetHand(), "Hand should have increased")
	GG.Darius:DrawCard(2)
	assert_equal(2, #GG.Darius:GetHand(), "Hand should not have increased")
end
