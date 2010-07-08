-- System spoof --
gadget = {}
Spring = {} 
gadgetHandler = {}
GG = {}
GG.Darius = {}
UnitDefs = {}

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
local tower = nil
local selectedMaterial = nil
local selectedWeapon = nil

local get_selected_material_called = false
local get_selected_weapon_called = false

local synced = true

---------------------
-- Spoof functions --
---------------------
function gadgetHandler:IsSyncedCode() return synced end

function Spring.Echo(msg) table.insert(messages, msg) end
function debug_message(msg) table.insert(messages, msg) end

function GG.Darius:SetTower(t) tower = t end
function GG.Darius:GetSelectedMaterial() 
	get_selected_material_called = true
	return selectedMaterial
end
function GG.Darius:GetSelectedWeapon()
	get_selected_weapon_called = true
	return selectedWeapon
end

------------------
-- Example Data --
------------------

UnitDefs[1] = {name = "StoneFire"}

local exampleMaterial = {
	name = "Stone",
	type = "Material",
	img = 'LuaUI/images/stone.png',
	health =   1200,
	reloadTime = 0.5,
	range =  50,
	damage =  0,
	greenballs = 0,
	desc = "Creates tall stone towers with decent range and good amount of health,\n" ..
		"but due to tall design, adds additional weapon reloading time.",
}

local exampleWeapon = {
	name = "Fire",
	type = "Weapon",
	img = 'LuaUI/images/fire.png',
	health =   -100,
	reloadTime = 0.1,
	range =  50,
	damage =  100,
	greenballs = 0,
	desc = "",
}

----------------
-- Test Setup --
----------------
module( "enhanced", package.seeall, lunit.testcase )

function setup()
	synced = true
	dofile("../src/luarules/gadgets/darius_tower_logic.lua")
end

function teardown()
	messages = {}
	tower = nil
	selectedMaterial = nil
	selectedWeapon = nil
	get_selected_material_called = false
	get_selected_weapon_called = false
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
	oldDarius = GG.Darius
	GG.Darius = nil
	gadget:GameFrame(0)
	GG.Darius = oldDarius
	assert_false(get_selected_material_called, "Should not ask for selected Material")
	assert_false(get_selected_weapon_called, "Should not ask for selected Weapon")
	assert_nil(tower, "Tower should not be set")
end

function test_GameFrame_NoWeapon()
	selectedMaterial = exampleMaterial
	gadget:GameFrame(0)
	assert_true(get_selected_material_called, "Should ask for selected Material")
	assert_true(get_selected_weapon_called, "Should ask for selected Weapon")
	assert_nil(tower, "Tower should not be set")
end

function test_GameFrame_NoMaterial()
	selectedWeapon = exampleWeapon
	gadget:GameFrame(0)
	assert_true(get_selected_material_called, "Should ask for selected Material")
	assert_true(get_selected_weapon_called, "Should ask for selected Weapon")
	assert_nil(tower, "Tower should not be set")
end

function test_GameFrame_InvalidName()
	selectedMaterial = exampleMaterial
	selectedWeapon = table.copy(exampleWeapon)
	selectedWeapon.name = "badName"
	gadget:GameFrame(0)
	assert_true(get_selected_material_called, "Should ask for selected Material")
	assert_true(get_selected_weapon_called, "Should ask for selected Weapon")
	assert_nil(tower, "Tower should not be set")
end

function test_GameFrame_Correct()
	selectedMaterial = exampleMaterial
	selectedWeapon = exampleWeapon
	gadget:GameFrame(0)
	assert_true(get_selected_material_called, "Should ask for selected Material")
	assert_true(get_selected_weapon_called, "Should ask for selected Weapon")
	assert_not_nil(tower, "Tower should be set")
end
