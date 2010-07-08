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

local effect_called = false
local discard_called = false

local synced = true

---------------------
-- Spoof functions --
---------------------
function gadgetHandler:IsSyncedCode() return synced end

function gadget:Initialize() end

function Spring.Echo(msg) table.insert(messages, msg) end
function debug_message(msg) table.insert(messages, msg) end

function GG.Darius:GetEffect() return effect end
function GG.Darius:DiscardSelected() discard_called = true end

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

----------------
-- Test Setup --
----------------
module( "enhanced", package.seeall, lunit.testcase )

function setup()
	synced = true
	dofile("../src/luarules/gadgets/darius_effect_controller.lua")
end

function teardown()
	effect = nil
	messages = {}
	effect_called = false
	discard_called = false
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
	--assert_pass(gadget:Initialize(),gadget:Initialize())
end

---------------
-- GameFrame --
---------------
function test_GameFrame_NoDarius()
	effect = exampleEffect
	oldDarius = GG.Darius
	GG.Darius = nil
	gadget:GameFrame(0)
	GG.Darius = oldDarius
	assert_nil(messages[1], messages[1])
	assert_false(effect_called, "Effect should not be executed (inaccessible)")
end

function test_GameFrame_Simple()
	effect = exampleEffect
	gadget:GameFrame(0)
	assert_equal("Getting Effect", messages[2], "Did not get Effect")
	assert_equal("Effect is valid", messages[3], "Effect not valid")
	assert_equal("Calling Effect", messages[4], "Effect not called")
	assert_true(effect_called, "Effect should run")
end

function test_GameFrame_NoEffect()
	gadget:GameFrame(0)
	assert_false(effect_called, "Effect should not run (no effect)")
end

function test_GameFrame_RequirePos()
	effect = table.copy(exampleEffect)
	effect.needsPos = true
	gadget:GameFrame(0)
	assert_false(effect_called, "Effect should not run (needs pos)")
end

function test_GameFrame_RequireUnit()
	effect = table.copy(exampleEffect)
	effect.needsUnit = true
	gadget:GameFrame(0)
	assert_false(effect_called, "Effect should not run (needs unit)")
end

function test_GameFrame_BadEffect()
	effect = "This won't work"
	gadget:GameFrame(0)
	assert_false(effect_called, "Effect should not run (not table)")
end

function test_GameFrame_Discard()
	effect = exampleEffect
	gadget:GameFrame(0)
	assert_true(discard_called, "Card should be discarded")
end

----------------
-- RecvLuaMsg --
----------------
function test_RecvLuaMsg_SimplePos()
	gadget:RecvLuaMsg("EffectPos:3.0,4.0,5.0", 0)
	assert_equal("3.0,4.0,5.0", messages[1], "Coords string")
	assert_equal("3.0,4.0,5.0", messages[2], "Pos")
	assert_equal("3.0,4.0,5.0", messages[3], "Checked Pos")
end

function test_RecvLuaMsg_BadPos()
	gadget:RecvLuaMsg("EffectPos:4.0,5.0", 0)
	assert_equal("4.0,5.0", messages[1], "Coords string")
	assert_equal("4.0,5.0,nil", messages[2], "Pos")
	assert_equal("nil", messages[3], "Checked Pos")
end

function test_RecvLuaMsg_SimpleUnit()
	gadget:RecvLuaMsg("EffectUnit:5", 0)
	assert_equal("5", messages[1], "Unit ID")
end
function test_RecvLuaMsg_BadUnit()
	gadget:RecvLuaMsg("EffectUnit:", 0)
	assert_equal("nil", messages[1], "Unit ID")
end
