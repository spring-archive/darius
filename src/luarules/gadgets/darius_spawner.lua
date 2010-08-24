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
local spGetGroundHeight = Spring.GetGroundHeight

----------------
-- Local Vars --
----------------

local x_src, y_src, z_src
local x_dest, y_dest, z_dest
local waves

monsterTeamNumber = 0
monstersSpawnedTotal = 0
monstersKilledTotal = 0
currentWave = 0
nextWave = 0
spawning = true

----------------------
-- Synced Functions --
----------------------
if (gadgetHandler:IsSyncedCode()) then

local function LoadMapData()
	local mapname = string.gsub(Game.mapName,"\.smf$","") -- remove the .smf from the mapName string
	local mapfile = "maps/" .. mapname .. ".lua"

	--Load map file
	if not (VFS.FileExists(mapfile)) then return false end
	mapData = VFS.Include(mapfile)
	if not (type(mapData) == "table") then return false end
	if not (type(mapData.easy) == "table") then return false end
	if not (type(mapData.castleposition) == "table") then return false end
	if not (#mapData.castleposition == 2) then return false end
	if not (type(mapData.spawningpoints) == "table") then return false end
	if (#mapData.spawningpoints == 0) then return false end
	
	waves = mapData.easy --TODO: Get correct wave per difficulty (easy, normal, hard)

	castleposition = mapData.castleposition --{x, z}
	spawningpoints = mapData.spawningpoints --{{x, z},...}
	return true
end

local function InitWaves()
	LoadMapData()
	spSetGameRulesParam("numberOfWaves", #waves)
end

local function SpawnMonsters()
	-- Time for next wave
	if nextWave < Spring.GetGameSeconds() then
		currentWave = currentWave + 1
		local monsters = waves[currentWave]
		if monsters == nil then
			spawning = false
			return
		end	
		for i, monster in ipairs(monsters) do
			monster["nextSpawn"] = 0
		end
		nextWave = Spring.GetGameSeconds() + waves[currentWave].duration
		spSetGameRulesParam("NextWave", nextWave);
		spSetGameRulesParam("numOfCurrentWave", currentWave)
		Spring.PlaySoundFile("sounds/ui/chip.wav")
	end
	if currentWave == 0 then
		return
	end
	local monsters = waves[currentWave]
	for i, monster in ipairs(monsters) do
		if monster["amount"] > 0 and monster["nextSpawn"] < Spring.GetGameSeconds() then
			local src = spawningpoints[monster["location"]]
			local unit = spCreateUnit(monster["monster"], src[1], spGetGroundHeight(src[1],src[2]), src[2], "south", monsterTeamNumber, false)
			spGiveOrderToUnit(unit, CMD.MOVE, {x_dest, y_dest, z_dest}, {})
			--Spring.PlaySoundFile("sounds/ui/monster_spawn.wav")
			monster["amount"] = monster["amount"] - 1
			spEcho("Spawning:" .. monster["monster"] .. " amount left: " .. monster["amount"])
			monstersSpawnedTotal = monstersSpawnedTotal + 1
			spSetGameRulesParam("monstersSpawnedTotal", monstersSpawnedTotal)
			monster["nextSpawn"] = Spring.GetGameSeconds() + monster["interval"]
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
		if spawning then
			SpawnMonsters()
		end
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
	SetLocations()
end

function gadget:GameFrame(f)
	if (f%10 < 1) then
		GadgetUpdate(f);
	end
end

function gadget:GameStart()
	spSendCommands("cheat")
	spSendCommands("globallos")
	spEcho("Darius spawner: Enabled cheats to get rid of the Fog of War")
	SetLocations()
	LoadMapData()
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID, _)
	if teamID == monsterTeamNumber then
		UpdateStats()
		if not spawning and monstersKilledTotal == monstersSpawnedTotal then
			GameVictory()
		end
	end
end


end -- end synced
