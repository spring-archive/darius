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

----------------
-- Local Vars --
----------------

local x_src, y_src, z_src
local x_dest, y_dest, z_dest

currentRound = 0
currentWave = 0
monsterTeamNumber = 0
monstersLeftInTheWave = 1 -- hack
monstersKilledTotal = -1 -- hack
timeToTheNextWave = -1
	
	

----------------------
-- Synced Functions --
----------------------
if (gadgetHandler:IsSyncedCode()) then



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

function CreateRound(waves)
	local round = {class = "round"}
	
	if not (type(waves) == "table" and #waves > 0) then
		spEcho("Spawner: Round does not have any waves")
		return nil
	end
	
	local a = #waves
	
	for i = 1,a do
		w = waves[i]
		
		if not (w["class"] == "wave") then
			spEcho("Spawner: Round defition is not valid")
			return nil
		end
		
		round[i] = w
	end
	
	return round
end

function InitRoundsAndWaves()
	-- should these be loaded from a config file?
	local wave1 = CreateWave({
		{"chicken", 2, 3}
		{"corthud", 2, 3}
		{"armpw", 2, 3}  
	})
	
	local wave2 = CreateWave({
		{"arm_venom", 2, 3}
		{"corstorm", 2, 3}
		{"corpyro", 2, 3}  
	})
	
	local wave3 = CreateWave({
		{"armsptk", 2, 3}
		{"chickena", 2, 3}
		{"chicken_dodo", 2, 3}  
	})
	
	local wave4 = CreateWave({
		{"chicken_leaper", 2, 3}
		{"chicken_sporeshooter", 2, 3}
		{"cormortgold", 2, 3}  
	})
	
	local wave5 = CreateWave({
		{"armwar", 2, 3}
		{"chickenc", 2, 3}
		{"corpyro_new", 2, 3}  
	})
	
	local wave6 = CreateWave({
		{"armorco", 2, 3}
		{"chickenq", 2, 3}
	})
	
	local wave7 = CreateWave({
		{"chicken_dodo", 2, 20},
		{"chicken_sporeshooter", 2, 2},
		{"chickena", 2, 2},
		{"chickenc", 2, 2},
	})
	
	local wave8 = CreateWave({
		{"chickenq", 2, 1}
	})
	
	local round1 = CreateRound({wave1, wave2, wave3, wave4, wave5, wave6, wave7, wave8})
	rounds = {round1}
end

function ShowGracePeriod(graceSeconds)
	diff = spGetGameSeconds() - waveFinishedTime
	timeToTheNextWave = graceSeconds - diff
	spSetGameRulesParam("timeToTheNextWave", timeToTheNextWave)

	if (diff > graceSeconds) then
		currentWave = currentWave + 1
		spSetGameRulesParam("currentWave", currentWave)
		spSetGameRulesParam("timeToTheNextWave", -1)
		waveUnfinished = true
		--spEcho("New wave started")
	end
end

function SpawnWaveMonsters()
	local monsters = rounds[currentRound][currentWave]
	if monsters ~= nil then
		for i, monster in ipairs(monsters) do
			if monster[3] > 0 then
				local unit = spCreateUnit(monster[1], x_src + i * 200, y_src, z_src, "south", monsterTeamNumber, false)
				spGiveOrderToUnit(unit, CMD.MOVE, {x_dest, y_dest, z_dest}, {})
				monstersLeftInTheWave = monstersLeftInTheWave + 1
				spSetGameRulesParam("monstersLeftInTheWave", monstersLeftInTheWave)
				monster[3] = monster[3] - 1
			end
		end
	end
end

function GameVictory()
	spSetGameRulesParam("gameWon", 1);
end

function StartNewRound()
	currentRound = currentRound + 1
	spSetGameRulesParam("currentRound", currentRound)
	
	currentWave = 0
	spSetGameRulesParam("currentWave", currentWave)
	
	waveUnfinished = false
	roundUnfinished = true
	--spEcho("New round started")
end

function GadgetUpdate(f)
	if gameUnfinished == true then
		if roundUnfinished == true then
			if waveUnfinished == true then
				SpawnWaveMonsters()
			else -- wave finished
				ShowGracePeriod(10)
			end
		else -- round finished
			StartNewRound()
		end
	else -- game finished
		GameVictory()
	end
end

function UpdateGameStatus()
	waveFinishedTime = spGetGameSeconds()

	-- if round is finished, move to the next round
	if (rounds[currentRound][currentWave + 1] == nil) then
		if	(rounds[currentRound + 1] == nil) then
			gameUnfinished = false	-- win
		end
		roundUnfinished = false -- next round
	end
	
	waveUnfinished = false -- next wave
end

function UpdateStats()
	monstersLeftInTheWave = monstersLeftInTheWave - 1
	monstersKilledTotal = monstersKilledTotal + 1
	spSetGameRulesParam("monstersLeftInTheWave", monstersLeftInTheWave)
	spSetGameRulesParam("monstersKilledTotal", monstersKilledTotal)
end

function SetSpawingAndGoalLocations()
	x_src, y_src, z_src = spGetTeamStartPosition(0)
	x_dest, y_dest, z_dest = spGetTeamStartPosition(1)
end



--------------
-- Call-ins --
--------------

function gadget:Initialize()
	InitRoundsAndWaves()
	
	spSetGameRulesParam("gameWon", 0)
	
	spSetGameRulesParam("monstersLeftInTheWave", monstersLeftInTheWave)
	spSetGameRulesParam("monstersTeam", monsterTeamNumber)
	spSetGameRulesParam("monstersKilledTotal", monstersKilledTotal)
	spSetGameRulesParam("currentRound", currentRound)
	spSetGameRulesParam("currentWave", currentWave)
	spSetGameRulesParam("timeToTheNextWave", timeToTheNextWave)
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
	
	SetSpawingAndGoalLocations();
	
	gameUnfinished = true
	roundUnfinished = false
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID, _)
	if unitDefID == 54 then -- start point?? gets destroyed at start
			return
	end

	if teamID == monsterTeamNumber then
		UpdateStats()
	end
	
	if (monstersLeftInTheWave == 0) then
		UpdateGameStatus()
	end
end



end -- end synced