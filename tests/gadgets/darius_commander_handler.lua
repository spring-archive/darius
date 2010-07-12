Spring = {}
Spring.MoveCtrl = {}
gadgetHandler = {}
Game = {}
gadget = {}


module( "enhanced", package.seeall, lunit.testcase )

--Setting up the Spring environment with dummies:
function spEcho()
end

function Spring.GetTeamUnits(teamID)
	if teamID == 3 then
		return {100, 200, 300}
	else return {}
	end
end

function Spring.GetUnitDefID(unitID)
	if unitID % 100 == 0 then
		return 1
	elseif unitID % 7 == 0 then
		return 2
	elseif unitID % 9 == 0 then
		return 3
	end
end

function gadgetHandler:IsSyncedCode()
	return true
end



UnitDefs = {{isCommander = true}, {isCommander = false}, {isCommander = false}}
Game.mapSizeX = 0
Game.mapSizeZ = 0

local calls = 0
local function inc(...)
	calls = calls + 1
end

Spring.MoveCtrl.Enable = inc
Spring.MoveCtrl.SetNoBlocking = inc
Spring.MoveCtrl.SetPosition = inc
Spring.SetUnitCloak = inc
Spring.SetUnitHealth = inc
Spring.SetUnitNoDraw = inc
Spring.SetUnitStealth = inc
Spring.SetUnitNoSelect = inc
Spring.SetUnitNoMinimap = inc

local gadgetRemoved = false
function gadgetHandler:RemoveGadget()
	gadgetRemoved = true
end

maxHealthSet = 0
function Spring.SetUnitMaxHealth(unit, health)
	maxHealthSet = health
end

healthSet = 0
function Spring.SetUnitHealth(unit, a)
	if a.health then
		healthSet = a.health
	end
end


--Setup the file
function setup()
	dofile("../src/luarules/gadgets/darius_commander_handler.lua")
end

function teardown()
end

--Actual tests

--[[
--To run the following tests are for local functions, so if you want to run them you'll need to manually change the source file

function test_disable_Unit()
	DisableUnit()
	assert_equal(8, calls)
	calls = 0
end

function test_get_commanders()
	commanders = GetCommanders(3)
	assert_equal(commanders[1], 100)
	assert_equal(commanders[2], 200)
	assert_equal(commanders[3], 300)
end
--]]

function test_game_frame()
	gadget:GameFrame(7)
	assert_equal(8, calls)
	calls = 0
	assert_equal(maxHealthSet, healthSet)

	gadget:GameFrame(101)
	assert_equal(gadgetRemoved, true)
end

