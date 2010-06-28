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

local emptyTable = {}
local speed = 50 -- spawner does it's thing every X frames

local x,y,z
local x2,y2,z2

local currentRound = 0;
local currentWave = 0;
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
	for i=1,a do
		m = monsters[i]
		if not (#m == 3 and type(m[1]) == "string" and type(m[2]) == "number" and type(m[3] == "number")) then
			spEcho("Spawner: Wave definition is not valid")
			return nil
		end
		wave[i] = {m[1],m[2],m[3]}
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
	for i=1,a do
		w = waves[i]
		if not (w["class"] == "wave") then
			spEcho("Spawner: Round defition is not valid")
			return nil
		end
		round[i] = w
	end
	return round
end

function ResetSpawner()
	local wave1 = CreateWave({
		{"chicken",1,20},
		{"armpw",1,15},
	})
	local wave2 = CreateWave({
		{"cormortgold",2,5},
		{"chicken_dodo",1,30}
	})
	local wave3 = CreateWave({
		{"armwar",2,10},
		{"armorco",3,3}
	})
	local round1 = CreateRound({wave1,wave2,wave3})
	rounds = {round1}
end

function NextRound()
	currentRound = currentRound + 1
	currentWave = 0
	spSetGameRulesParam("round",currentRound)
end

function NextWave()
	if rounds[currentRound][currentWave + 1] == nil then
		-- The new wave is nil
		return
	end
	if rounds[currentRound][currentWave + 2] == nil then
		-- The wave after the new wave is nil, set time for the next wave internally so the spawner does not stop too early
		nextWave = spGetGameSeconds() + 40
		spSetGameRulesParam("nextWave",0)
	else
		nextWave = spGetGameSeconds() + 40
		spSetGameRulesParam("nextWave",nextWave)
	end
	currentWave = currentWave + 1
	spSetGameRulesParam("wave",currentWave)
end

function SpawnMonsters(f)
	if rounds ~= nil and rounds[currentRound] ~= nil then
		local roundData = rounds[currentRound]
		local monsters = roundData[currentWave]
		if monsters ~= nil then
			for i, monster in ipairs(monsters) do
				if f%(speed*monster[2]) == 0 and monster[3] > 0 then
					monster[3] = monster[3] - 1
					monstersLeft = monstersLeft + 1
					spSetGameRulesParam("monstersLeft",monstersLeft)
					local unit = spCreateUnit(monster[1],x+i*200,y,z,"south",monsterTeam,false)
					spGiveOrderToUnit(unit,CMD.MOVE,{x2,y2,z2},emptyTable)
				end
			end
		end
	end
end



--------------
-- Call-ins --
--------------

function gadget:Initialize()
	ResetSpawner()
	monstersLeft = 0
	spSetGameRulesParam("monstersLeft",monstersLeft)
	monsterTeam = 0
	spSetGameRulesParam("monstersTeam",monsterTeam)
	monstersKilled = 0
	spSetGameRulesParam("monstersKilled",monstersKilled)
end

function gadget:GameFrame(f)
	if f%speed == 0 then
		if x == nil then
			x,y,z = spGetTeamStartPosition(0)
			x2,y2,z2 = spGetTeamStartPosition(1)
		end
		if nextWave < spGetGameSeconds() then
			NextWave()
		end
		SpawnMonsters(f)
	end
end

function gadget:GameStart()
	spSendCommands("cheat")
	spSendCommands("globallos")
	spEcho("Spawner: Enabled cheats to get rid of Fog of War")
	currentRound = 0
	NextRound()
	NextWave()
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID, _)
	if unitDefID == 54 then -- start point?? gets destroyed at start
		return
	end
	if teamID == monsterTeam then
		monstersLeft = monstersLeft - 1
		spSetGameRulesParam("monstersLeft",monstersLeft)
		monstersKilled = monstersKilled + 1
		spSetGameRulesParam("monstersKilled",monstersKilled)
	end
end

end -- end synced