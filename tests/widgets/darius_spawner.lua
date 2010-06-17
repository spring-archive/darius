
gadget = {}
Spring = {} 
gadgetHandler = {}
CMD = {}
CMD.MOVE = 666

module( "enhanced", package.seeall, lunit.testcase )

function setup()
	units = ""
	unit = 0
	ResetSpawner()
end

function teardown()	
end

function gadgetHandler:IsSyncedCode() return true end
function Spring.GetTeamStartPosition(f) startposition = true; return 0,0,0 end
function Spring.CreateUnit(a,b,c,d,e,f,g) units = units .. "," .. a; unit = unit + 1 end
function Spring.GiveOrderToUnit(a,b,c,d,e) end

dofile("../src/luarules/gadgets/darius_spawner.lua")


function test_SpawnerResetsCorrectly()
	gadget:GameFrame(0)
	assert_equal( 2, unit, "Incorrect amount of units spawned or spawned did not reset")
end

function test_CorrectUnitsAfter150Frames()
	local i = 0
	for i=0,150 do
		gadget:GameFrame(i)
	end
	assert_equal(",corcom,armcom,corcom", units, "Unit types spawned are not correct after 150 frames")
end

function test_CorrectUnitsAfter300Frames()
	local i = 0
	for i=0,300 do
		gadget:GameFrame(i)
	end
	assert_equal(",corcom,armcom,corcom,corcom,armcom", units, "Unit types spawned are not correct after 150 frames")
end

function test_RightAmountOfUnits()
	local i = 0
	for i=0,50000 do
		gadget:GameFrame(i)
	end
	assert_equal( 40, unit, "Not enough units spawned")
end

function test_NoUnitsSpawnedAtStartFrames()
	local i = 0
	for i=1,49 do
		gadget:GameFrame(i)
	end
	assert_equal( 0, unit, "Unit spawned too soon")
end

