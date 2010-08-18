function gadget:GetInfo()
	return {
		name      = "Simple monster spawner",
		desc      = "Spawns monster at certain rate",
		author    = "Jammer & malloc",
		date      = "June 28, 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true
	}
end

--------------
-- Speed Up --
--------------

local spEcho = Spring.Echo
local spCreateUnit = Spring.CreateUnit
local spGetTeamUnits = Spring.GetTeamUnits
local spGetTeamStartPosition = Spring.GetTeamStartPosition
local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGetGameSeconds = Spring.GetGameSeconds
local spSetGameRulesParam = Spring.SetGameRulesParam
local spSendCommands = Spring.SendCommands
local spDestroyUnit = Spring.DestroyUnit

----------------
-- Local Vars --
----------------

local x_src, y_src, z_src
local x_dest, y_dest, z_dest

monsterTeamNumber = 0
monstersKilledTotal = 0
currentWave = 0

----------------------
-- Synced Functions --
----------------------
if (gadgetHandler:IsSyncedCode()) then

-- Presently used by the map scripts
function CreateWave(monsters)
	local wave = {class = "wave"}

	if not (type(monsters) == "table" and #monsters > 0) then
		spEcho("Spawner: Wave does not have any monsters")
		return nil
	end

	local a = #monsters

	for i = 1, a do
		m = monsters[i]

		if not (#m == 3 and type(m[1]) == "string" and type(m[2]) == "number" and type(m[3] == "number")) then
			spEcho("Spawner: Wave definition is not valid")
			return nil
		end

		wave[i] = {m[1], m[2], m[3]}
	end

	return wave
end

local function LoadMapData()
	--TODO:Get real map file name
	local mapfile = "maps/" .. "dunes" .. ".lua"

	--Load map file
	if not (VFS.FileExists(mapfile)) then return false end
	mapData = VFS.Include(mapfile)
	if not (type(mapData) == "table") then return false end
	if not (type(mapData.waves) == "table") then return false end
	if not (type(mapData.castleposition) == "table") then return false end
	if not (#mapData.castleposition) == 2) then return false end
	if not (type(mapData.spawningpoints) == "table") then return false end
	if (#mapData.spawningpoints) == 0) then return false end

	waves = mapData.waves.normal --TODO: Get correct wave per difficulty (easy, normal, hard)
	castleposition = mapData.castleposition
	spawningpoints = mapData.spawningpoints
end

local function InitWaves()
	waves[0] = CreateWave({
			{"chicken", 2, 3},
		})

	waves[1] = CreateWave({
			{"corthud", 2, 3},
		})

	waves[2] = CreateWave({
			{"armpw", 2, 3},
		})

	waves[3] = CreateWave({
			{"arm_venom", 2, 3},
		})

	waves[4] = CreateWave({
			{"corstorm", 2, 3},
		})

	waves[5] = CreateWave({
			{"corpyro", 2, 3},
		})

	waves[6] = CreateWave({
			{"armsptk", 2, 3},
		})

	waves[7] = CreateWave({
			{"chickena", 2, 3},
		})

	waves[8] = CreateWave({
			{"chicken_dodo", 2, 3},
		})

	waves[9] = CreateWave({
			{"chicken_sporeshooter", 2, 3},
		})

	waves[10] = CreateWave({
			{"cormortgold", 2, 3},
		})

	waves[11] = CreateWave({
			{"armwar", 2, 3},
		})

	waves[12] = CreateWave({
			{"chickenc", 2, 3},
		})

	waves[13] = CreateWave({
			{"armorco", 2, 3},
		})

	waves[14] = CreateWave({
			{"chickenq", 2, 3},
		})
end


local function SpawnMonsters()
	local monsters = waves[currentWave]
	if monsters ~= nil then
		for i, monster in ipairs(monsters) do
			if monster[3] > 0 then
				local unit = spCreateUnit(monster[1], x_src + i * 20, y_src, z_src, "south", monsterTeamNumber, false)
				spGiveOrderToUnit(unit, CMD.MOVE, {x_dest, y_dest, z_dest}, {})
				Spring.PlaySoundFile("sounds/ui/monster_spawn.wav")
				monster[3] = monster[3] - 1
			else
					currentWave = currentWave + 1
			end
		end
	end
end


function GameVictory()
	spSetGameRulesParam("gameWon", 1);

	--Kill all AI units, so that the player will win the game
	for _, unit in ipairs(spGetTeamUnits(monsterTeamNumber)) do
		spDestroyUnit(unit, false, true)
	end
end


function GadgetUpdate(f)
	if gameFinished == false then
		SpawnMonsters()
	else
		GameVictory()
	end
end


function UpdateStats()
	monstersKilledTotal = monstersKilledTotal + 1
	spSetGameRulesParam("monstersKilledTotal", monstersKilledTotal)
end


function SetLocations()
	x_src, y_src, z_src = spGetTeamStartPosition(0)
	x_dest, y_dest, z_dest = spGetTeamStartPosition(1)
end



--------------
-- Call-ins --
--------------

function gadget:Initialize()
	InitWaves()

	spSetGameRulesParam("gameWon", 0)
	spSetGameRulesParam("monstersKilledTotal", 0)
	
	gameFinished = false
end



function gadget:GameFrame(f)
	if (f%30 < 1) then
		GadgetUpdate(f);
	end
end



function gadget:GameStart()
	spSendCommands("cheat")
	spSendCommands("globallos")
	spEcho("Darius spawner: Enabled cheats to get rid of the Fog of War")

	SetLocations();
end



function gadget:UnitDestroyed(unitID, unitDefID, teamID, _)
	if teamID == monsterTeamNumber then
		UpdateStats()
	end
end



end -- end synced
