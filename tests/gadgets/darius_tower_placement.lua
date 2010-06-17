gadget = {}
Spring = {} 
gadgetHandler = {}
CMD = {}
CMD.MOVE = 666 -- fake value
GG = {}
GG.Darius = {}

module( "towerPlacement", package.seeall, lunit.testcase )

local unit
local units

function setup()
	unit = 0
	units = ""
end

function teardown()	
end

function gadgetHandler:IsSyncedCode() return true end
function Spring.CreateUnit(a,b,c,d,e,f,g) units = units .. "," .. a; unit = unit + 1 end
function Spring.Echo(e) end
function GG.Darius:GetTower() return 260 end
function GG.Darius:DiscardSelected() end


dofile("../src/luarules/gadgets/darius_tower_placement.lua")


function test_GadgetInfoReturnsTable()
	assert_table(gadget:GetInfo())
end

function test_SingleTowerIsSpawned()
	gadget:RecvLuaMsg("PlaceTower 260 0 0 0");
	for i=0,500 do
		gadget:GameFrame(i)
	end
	assert_equal( 1, unit, "Incorrect amount of towers spawned")
end

function test_TowerTypeIsCorrect()
	gadget:RecvLuaMsg("PlaceTower 260 0 0 0");
	for i=0,500 do
		gadget:GameFrame(i)
	end
	assert_equal( ",260", units, "Incorrect type(s) spawned instead of tower");
end
