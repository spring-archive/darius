function gadget:GetInfo()
	return {
		name      = "Simple monster spawner",
		desc      = "Spawns monster at certain rate",
		author    = "Jammer",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

local spEcho = Spring.Echo
local spCreateUnit = Spring.CreateUnit

local emptyTable = {}

if (not gadgetHandler:IsSyncedCode()) then
	return false -- no unsynced code
end

local monsters 

local x,y,z
local x2,y2,z2

function ResetSpawner()
	monsters = {
		{"corcom",150,20},
		{"armcom",300,20}
	}	
end

function gadget:Initialize()
	ResetSpawner()
end

function gadget:GameFrame(f)
	if f%50 == 0 then
		if x == nil then
			x,y,z = Spring.GetTeamStartPosition(0)
			x2,y2,z2 = Spring.GetTeamStartPosition(1)
		end
		for i, monster in pairs(monsters) do
			if (f%monster[2] == 0 and monster[3] > 0) then
				monster[3] = monster[3] - 1
				local unit = spCreateUnit(monster[1],x+i*200,y,z,"south",0,false)
				Spring.GiveOrderToUnit(unit,CMD.MOVE,{x2,y2,z2},emptyTable)
			end
		end
	end
end
