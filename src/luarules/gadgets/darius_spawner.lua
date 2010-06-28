function gadget:GetInfo()
	return {
		name      = "Simple monster spawner",
		desc      = "Spawns monster at certain rate",
		author    = "Jammer",
		date      = "June 2010",
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
	
rounds = {}



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
	local wave1 = CreateWave({
		{"chicken", 2, 2}
	})
	
	local wave2 = CreateWave({
		{"chicken", 2, 2}
	})
	
	local wave3 = CreateWave({
		{"chicken", 2, 2}
	})
	
	local round1 = CreateRound({wave1, wave2})
	
	rounds = {round1}
end




function GadgetUpdate(f)
	if gameGoing == true then
		if roundGoing == true then
			if waveGoing == true then -- wave is on

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
			else -- rest period
				gracePeriod = 20
				diff = spGetGameSeconds() - waveFinishedTime
				timeToNextWave = gracePeriod - diff
				spSetGameRulesParam("timeToNextWave", timeToNextWave)
			
				if (diff > gracePeriod) then
					currentWave = currentWave + 1
					spSetGameRulesParam("currentWave", currentWave)
					spSetGameRulesParam("timeToNextWave", -1)
					waveGoing = true
					spEcho("New wave started")
				end
			end
		else
			-- prepare
			currentRound = currentRound + 1
			spSetGameRulesParam("currentRound", currentRound)
			currentWave = 0
			spSetGameRulesParam("currentWave", currentWave)
			waveGoing = false
			roundGoing = true
			spEcho("New round started")
		end
	else
		spEcho("Congratulations. You Won.")
	end
end



--------------
-- Call-ins --
--------------

function gadget:Initialize()
	InitRoundsAndWaves()
	
	currentRound = 0
	currentWave = 0
	monstersLeftInTheWave = 0
	monsterTeamNumber = 0
	monstersKilledTotal = 0
	timeToNextWave = -1
	
	spSetGameRulesParam("monstersLeftInTheWave", monstersLeftInTheWave)
	spSetGameRulesParam("monstersTeam", monsterTeamNumber)
	spSetGameRulesParam("monstersKilledTotal", monstersKilledTotal)
	spSetGameRulesParam("currentRound", currentRound)
	spSetGameRulesParam("currentWave", currentWave)
	spSetGameRulesParam("timeToNextWave", timeToNextWave)
end



function gadget:GameFrame(f)
	if (f%30 < 1) then
		GadgetUpdate(f);
	end
end


function gadget:GameStart()
	spSendCommands("cheat")
	spSendCommands("globallos")
	spEcho("Spawner: Enabled cheats to get rid of Fog of War")
	
	x_src, y_src, z_src = spGetTeamStartPosition(0)
	x_dest, y_dest, z_dest = spGetTeamStartPosition(1)
	
	spSetGameRulesParam("currentRound", currentRound)
	spSetGameRulesParam("currentWave", currentWave)	
	
	gameGoing = true
	roundGoing = false
	waveFinishedTime = 0
end



function gadget:UnitDestroyed(unitID, unitDefID, teamID, _)
	if unitDefID == 54 then -- start point?? gets destroyed at start
		return
	end
	
	if teamID == monsterTeamNumber then
		monstersLeftInTheWave = monstersLeftInTheWave - 1
		spSetGameRulesParam("monstersLeftInTheWave", monstersLeftInTheWave)
		
		monstersKilledTotal = monstersKilledTotal + 1
		spSetGameRulesParam("monstersKilledTotal", monstersKilledTotal)
	end
	
	
	if (monstersLeftInTheWave == -1) then
		waveFinishedTime = spGetGameSeconds()
		waveGoing = false
		
		-- if round finished, move to the next round
		if (rounds[currentRound][currentWave + 1] == nil) then
			
			if	(rounds[currentRound + 1] == nil) then
				gameGoing = false
			end
			
			roundGoing = false
		end
	end
	
end

end -- end synced