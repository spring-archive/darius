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

if (not gadgetHandler:IsSyncedCode()) then
	return false -- no unsynced code
end

local monsters = {
	{"corcom",150,20},
	{"armcom",300,20}
}

function gadget:GameFrame(f)
	if f%50 == 0 then
		local x,y,z = Spring.GetTeamStartPosition(1)
		for _, monster in pairs(monsters) do
			if (f%monster[2] == 0 and monster[3] > 0) then
				monster[3] = monster[3] - 1
				spCreateUnit(monster[1],x+monster[2],y,z,"south",0,false)
			end
		end
	end
end
