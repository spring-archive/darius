-- System spoof --
gadget = {}
Spring = {} 
gadgetHandler = {}
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

-------------------------
-- Control Definitions -- System spoofing and return checking
-------------------------
local messages = {}
local effect = nil
local selectedSpecial = nil

local get_selected_special_called = false

local synced = true

---------------------
-- Spoof functions --
---------------------
function gadgetHandler:IsSyncedCode() return synced end

function Spring.Echo(msg) table.insert(messages, msg) end
function debug_message(msg) table.insert(messages, msg) end

function GG.Darius:SetEffect(e) effect = e end
function GG.Darius:GetSelectedSpecial()
	get_selected_special_called = true
	return selectedSpecial
end

------------------
-- Example Data --
------------------

local exampleEffect = {
	name = "Freeze", 
	needsPos = false,
	needsUnit = false,
	effect = function() effect_called = true end, 
	desc = "Freezes enemies in place",
}

local exampleSpecial = {
	name = "Freeze",
	type = "Special",
	img = 'LuaUI/images/freeze.png',
	health = nil,
	reloadTime = nil,
	range =  nil,
	damage =  nil,
	greenballs = 0,
	desc = "",
	effect = exampleEffect,
}


----------------
-- Test Setup --
----------------
module( "enhanced", package.seeall, lunit.testcase )

function setup()
	synced = true
	dofile("../src/luarules/gadgets/darius_effect_logic.lua")
end

function teardown()
	messages = {}
	effect = nil
	selectedSpecial = nil
	get_selected_special_called = false
end

----------------------------
------ Test functions ------
----------------------------
function test_GadgetInfoReturnsTable()
	assert_table(gadget:GetInfo())
end

--------------------
-- Initialization --
--------------------
function test_Initialization()
	--assert_pass(gadget.Initialize(),gadget:Initialize())
end

---------------
-- GameFrame --
---------------
function test_GameFrame_NoDarius()
	oldDarius = GG.Darius
	GG.Darius = nil
	gadget:GameFrame(0)
	GG.Darius = oldDarius
	assert_false(get_selected_special_called, "Should not ask for selected Special")
	assert_nil(effect, "Effect should not be set")
end

function test_GameFrame_NoCard()
	gadget:GameFrame(0)
	assert_true(get_selected_special_called, "Should ask for selected Special")
	assert_nil(effect, "Effect should not be set")
end

function test_GameFrame_NoEffect()
	selectedSpecial = table.copy(exampleSpecial)
	selectedSpecial.effect = nil
	gadget:GameFrame(0)
	assert_true(get_selected_special_called, "Should ask for selected Special")
	assert_nil(effect, "Effect should not be set")
end

function test_GameFrame_InvalidEffect()
	selectedSpecial = table.copy(exampleSpecial)
	selectedSpecial.effect = "Hello"
	gadget:GameFrame(0)
	assert_true(get_selected_special_called, "Should ask for selected Special")
	assert_nil(effect, "Effect should not be set")
end

function test_GameFrame_Correct()
	selectedSpecial = exampleSpecial
	gadget:GameFrame(0)
	assert_true(get_selected_special_called, "Should ask for selected Special")
	assert_not_nil(effect, "Effect should be set")
	assert_equal(exampleEffect, effect, "Effect has been mangled")
end
