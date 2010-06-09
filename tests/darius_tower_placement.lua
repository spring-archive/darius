gadget = {}
Spring = {} 
gadgetHandler = {}
CMD = {}
CMD.MOVE = 666
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
function Spring.CreateUnit(a,b,c,d,e,f,g) print("two"); units = units .. "," .. a; unit = unit + 1 end
function GG.Darius:GetTower() return "towertype" end
function GG.Darius:DiscardSelected() end


dofile("../src/luarules/gadgets/darius_tower_placement.lua")


function test_GadgetInfoReturnsTable()
	assert_table(gadget:GetInfo())
end

function test_SingleTowerIsSpawned()
	gadget:RecvLuaMsg("PlaceTower towertype 0 0 0");
	for i=0,500 do
		gadget:GameFrame(i)
	end
	assert_equal( 1, unit, "Incorrect amount of towers spawned")
end

function test_TowerTypeIsCorrect()
	gadget:RecvLuaMsg("PlaceTower towertype 0 0 0");
	for i=0,500 do
		gadget:GameFrame(i)
	end
	assert_equal( "towertype", units, "Incorrect type(s) spawned instead of tower");
end
