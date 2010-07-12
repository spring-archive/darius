Spring = {}
Spring.MoveCtrl = {}
gadgetHandler = {}
Game = {}


module( "enhanced", package.seeall, lunit.testcase )

function setup()
end

function teardown()
end

--Setting up the Spring environment with dummies:
function spEcho()
end



function spGetTeamUnits(teamID)
	if teamID == 3 then
		return {100, 200, 300}
	else return {}
	end
end

function spGetUnitDefID(unitID)
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

UnitDefs = {true, false, false}

local calls = 0
local function inc()
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

local maxHealthSet = 0
function Spring.SetUnitMaxHealth(health)
	maxHealthSet = health
end

local healthSet = 0
function Spring.SetUnitHealth(array)
	healthSet = array[health]
end



--Actual tests
function test_disable_Unit()
	DisableUnit()
	assert_equal(calls, 9)
	calls = 0
end

function test_get_commanders()
	commanders = GetCommanders(3)
	assert_equal(commanders[1], 100)
	assert_equal(commanders[2], 200)
	assert_equal(commanders[3], 300)
end

function test_game_frame()

	assert_equal(gadgetRemoved, true)
	assert_equal(calls, 9)
	assert_equal(maxHealthSet, healthSet)
end

