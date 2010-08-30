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
local spGetGameRulesParam = Spring.GetGameRulesParam
local spSendCommands = Spring.SendCommands
local spDestroyUnit = Spring.DestroyUnit
local spGetGroundHeight = Spring.GetGroundHeight
local spGetTeamUnits = Spring.GetTeamUnits
local spGetUnitDefID = Spring.GetUnitDefID

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
	if not (type(mapData.waves) == "table") then return false end
	if not (type(mapData.castleposition) == "table") then return false end
	if not (#mapData.castleposition == 2) then return false end
	if not (type(mapData.spawningpoints) == "table") then return false end
	if (#mapData.spawningpoints == 0) then return false end

	local difficulty = "easy"

	if (difficulty == "easy") then
		if not (type(mapData.waves.easy) == "table") then return false end
		waves = mapData.waves.easy
	elseif (difficulty == "normal") then
		if not (type(mapData.waves.normal) == "table") then return false end
		waves = mapData.waves.normal
	elseif (difficulty == "hard") then
		if not (type(mapData.waves.hard) == "table") then return false end
		waves = mapData.waves.hard
	end

	castleposition = mapData.castleposition --{x, z}
	castleposition[3] = castleposition[2]
	castleposition[2] = spGetGroundHeight(castleposition[1],castleposition[3])
	spawningpoints = mapData.spawningpoints --{{x, z},...}
	return true
end

local function SpawnMonsters()
	nextWave = spGetGameRulesParam("NextWave");
	if nextWave < Spring.GetGameSeconds() then
		-- Sending next wave
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
	local zeroMonsters = true
	for i, monster in ipairs(monsters) do
		if monster["amount"] > 0 then
			zeroMonsters = false
			if monster["nextSpawn"] < Spring.GetGameSeconds() then
				local src = spawningpoints[monster["location"]]
				local unit = spCreateUnit(monster["monster"], src[1], spGetGroundHeight(src[1],src[2]), src[2], "south", monsterTeamNumber, false)
				spGiveOrderToUnit(unit, CMD.MOVE, castleposition, {})
				--Spring.PlaySoundFile("sounds/ui/monster_spawn.wav")
				monster["amount"] = monster["amount"] - 1
				monstersSpawnedTotal = monstersSpawnedTotal + 1
				spSetGameRulesParam("monstersSpawnedTotal", monstersSpawnedTotal)
				monster["nextSpawn"] = Spring.GetGameSeconds() + monster["interval"]
			end
		end
	end
	if zeroMonsters then
		spSetGameRulesParam("allowSendingNextWave", 1)
	else
		spSetGameRulesParam("allowSendingNextWave", 0)
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
	if spawning then
		SpawnMonsters()
	else
		-- Bug fix for the game not properly ending after all the units have been destroyed
		-- We are not spwning anymore => check for a possible game end
		if monstersKilledTotal >= monstersSpawnedTotal and spGetGameRulesParam("gameWon") ~= 1 then
			GameVictory()
		end
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

local function GetCommanders(teamID) --Finds the commander IDs for the given team

	local units = spGetTeamUnits(teamID)
	local commanders = {}

	for _,unitID in ipairs(units) do
		if (UnitDefs[spGetUnitDefID(unitID)].isCommander) then
			--checks if the isCommander attribute is true in current unit's unitDef -file
			commanders[#commanders + 1] = unitID
		end
	end

	return commanders

end

function MoveCastle()
	Spring.MoveCtrl.Enable(GetCommanders(1)[1])
	Spring.MoveCtrl.SetPosition(GetCommanders(1)[1],castleposition[1],castleposition[2],castleposition[3])
end

-- If no more monsters are to be spawned in the current wave then this function will set the duration to zero causing the spawner to move to the next wave
function SendNextWave()
		local monsters = waves[currentWave]
		for i, monster in ipairs(monsters) do
			if (monster["amount"] > 0) then
				spEcho("Monsters still spawning in this wave!")
				return
			end
		end
		-- No monsters spawning so safe to set the wave duration to zero
		spSetGameRulesParam("NextWave", 0)
end

--------------
-- Call-ins --
--------------

function gadget:Initialize()
	LoadMapData()
	spSetGameRulesParam("numberOfWaves", #waves)
	
	spSetGameRulesParam("NextWave", 0)
	spSetGameRulesParam("gameWon", 0)
	spSetGameRulesParam("monstersKilledTotal", 0)
	
	SetLocations()
end

function gadget:RecvLuaMsg(msg, playerID)
	if string.find(msg, "SendNextWave") then
		SendNextWave()
	end
end

function gadget:GameFrame(f)
	if f%10 < 1 then
		GadgetUpdate(f);
	end
	if f == 7 then
		MoveCastle()
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
	end
end


end -- end synced
