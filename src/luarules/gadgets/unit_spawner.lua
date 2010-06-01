-- $Id: unit_spawner.lua 4534 2009-05-04 23:35:06Z licho $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "Chicken Spawner",
    desc      = "Spawns burrows and chickens",
    author    = "quantum",
    date      = "April 29, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then
-- BEGIN SYNCED
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Speed-ups and upvalues
--

local Spring              = Spring
local math                = math
local Game                = Game
local table               = table
local ipairs              = ipairs
local pairs               = pairs

local random              = math.random

local CMD_FIGHT           = CMD.FIGHT
local spGiveOrderToUnit   = Spring.GiveOrderToUnit
local spGetTeamUnits      = Spring.GetTeamUnits
local spGetUnitTeam       = Spring.GetUnitTeam
local spGetUnitCommands   = Spring.GetUnitCommands
local spGetGameSeconds    = Spring.GetGameSeconds
local spGetGroundBlocked  = Spring.GetGroundBlocked
local spCreateUnit        = Spring.CreateUnit
local spGetUnitPosition   = Spring.GetUnitPosition
local spGetUnitDefID	  = Spring.GetUnitDefID

local emptyTable    = {}
local roamParam     = {2}

local queenID
local targetCache     
local luaAI  
local chickenTeamID
local burrows             = {}
local burrowSpawnProgress = 0
local commanders          = {}
local maxTries            = 100
local computerTeams       = {}
local humanTeams          = {}
local lagging             = false
local cpuUsages           = {}
local chickenBirths       = {}
local kills               = {}
local idleQueue           = {}
local turrets             = {}
local timeOfLastSpawn     = 0    
gameMode                  = Spring.GetModOption("camode")
local tooltipMessage      = "Kill chickens and collect their eggs to get metal."
local mexes = {
  "cormex", 
  "armmex"
}

local respawnBurrows = false	--the full respawn, not % respawn chance
local waveBonus = 0		--halved every wave
local waveBonusDelta = 0		--resets to zero every wave
local totalTimeReduction = 0

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Teams
--


local modes = {
    [0] = 0,
    [1] = 'Chicken: Very Easy',
    [2] = 'Chicken: Easy',
    [3] = 'Chicken: Normal',
    [4] = 'Chicken: Hard',
    [5] = 'Chicken Eggs: Easy',
    [6] = 'Chicken Eggs: Normal',
    [7] = 'Chicken Eggs: Hard',
	[8] = 'Chicken: Suicidal',
}
local defaultDifficulty = modes[2]

for i, v in ipairs(modes) do -- make it bi-directional
  modes[v] = i
end


local function CompareDifficulty(...)
  level = 1
  for _, difficulty in ipairs{...} do
    if (modes[difficulty] > level) then
      level = modes[difficulty]
    end
  end
  return modes[level]
end


if (not gameMode) then -- set human and computer teams
  humanTeams[0]    = true
  computerTeams[1] = true
  chickenTeamID    = 1
  luaAI            = 0 --defaultDifficulty
else
  local teams = Spring.GetTeamList()
  local highestLevel = 0
  for _, teamID in ipairs(teams) do
    local teamLuaAI = Spring.GetTeamLuaAI(teamID)
    -- check only for chicken AI teams
    if (teamLuaAI and teamLuaAI ~= "" and modes[teamLuaAI]) then
      luaAI = teamLuaAI
      highestLevel = CompareDifficulty(teamLuaAI, highestLevel)
      chickenTeamID = teamID
      computerTeams[teamID] = true
    else
      humanTeams[teamID]    = true
    end
  end
  luaAI = highestLevel
end


local gaiaTeamID          = Spring.GetGaiaTeamID()
computerTeams[gaiaTeamID] = nil
humanTeams[gaiaTeamID]    = nil

if (luaAI == 0) then
  return false
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Utility
--

local function SetToList(set)
  local list = {}
  for k in pairs(set) do
    table.insert(list, k)
  end
  return list
end


local function SetCount(set)
  local count = 0
  for k in pairs(set) do
    count = count + 1
  end
  return count
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Difficulty
--

do -- load config file
  local CONFIG_FILE = "LuaRules/Configs/spawn_defs.lua"
  local VFSMODE = VFS.RAW_FIRST
  local s = assert(VFS.LoadFile(CONFIG_FILE, VFSMODE))
  local chunk = assert(loadstring(s, file))
  setfenv(chunk, gadget)
  chunk()
end


local function SetGlobals(difficulty)
  for key, value in pairs(gadget.difficulties[difficulty]) do
    gadget[key] = value
  end
  gadget.difficulties = nil
end


SetGlobals(luaAI or defaultDifficulty) -- set difficulty


-- adjust for player and chicken bot count
local playerCount = SetCount(humanTeams)
local malus     = playerCount^playerMalus
burrowSpawnRate = burrowSpawnRate/malus/SetCount(computerTeams)
minBurrowsIncrease = minBurrowsIncrease * malus
minBurrowsMax	   = minBurrowsMax * malus
if minBurrowsMax > maxBurrows then minBurrowsMax = maxBurrows end

local function DisableBuildButtons(unitID, buildNames)
  for _, unitName in ipairs(buildNames) do
    if (UnitDefNames[unitName]) then
      local cmdDescID = Spring.FindUnitCmdDesc(unitID, -UnitDefNames[unitName].id)
      if (cmdDescID) then
        local cmdArray = {disabled = true, tooltip = tooltipMessage}
        Spring.EditUnitCmdDesc(unitID, cmdDescID, cmdArray)
      end
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Game Rules
--


local function SetupUnit(unitName)
  Spring.SetGameRulesParam(unitName.."Count", 0)
  Spring.SetGameRulesParam(unitName.."Kills", 0)
end


Spring.SetGameRulesParam("lagging",           0)
Spring.SetGameRulesParam("queenTime",        queenTime)

for unitName in pairs(chickenTypes) do
  SetupUnit(unitName)
end

for unitName in pairs(defenders) do
  SetupUnit(unitName)
end

SetupUnit(burrowName)
SetupUnit(queenName)




local difficulty = modes[luaAI or defaultDifficulty]
Spring.SetGameRulesParam("difficulty", difficulty)

--if tobool(Spring.GetModOptions().burrowrespawn) or forceBurrowRespawn then respawnBurrows = true end

local function UpdateUnitCount()
  local teamUnitCounts = Spring.GetTeamUnitsCounts(chickenTeamID)

  --[[ if there are no more chickens of one type, the counter for this type
       is not updated anymore -> counter keeps last known quantity
       that's why we force to set all counters to zero first ]]
  for id, type in pairs(chickenTypes) do
    Spring.SetGameRulesParam(id.."Count", 0)
  end
  for id, type in pairs(defenders) do
    Spring.SetGameRulesParam(id.."Count", 0)
  end
  for unitDefID, count in pairs(teamUnitCounts) do
    if (unitDefID ~= "n") then
      Spring.SetGameRulesParam(UnitDefs[unitDefID].name.."Count", count)
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- CPU Lag Prevention
--

local function DetectCpuLag()
  local setspeed,actualspeed,paused = Spring.GetGameSpeed()
  if paused then return end
  local n = Spring.GetGameFrame()
  local players = Spring.GetPlayerList()
  for _, playerID in ipairs(players) do
    local _, active, spectator, _, _, _, cpuUsage = Spring.GetPlayerInfo(playerID)
    if (cpuUsage > 0) then
      cpuUsages[playerID] = {cpuUsage=math.min(cpuUsage, 1.2), frame=n}
    end
  end
  if (n > 30*10) then
    for playerID, t in pairs(cpuUsages) do
      if (n-t.frame > 30*60) then
        cpuUsages[playerID] = nil
      end
      local _, active = Spring.GetPlayerInfo(playerID)
      if (not active) then
        cpuUsages[playerID] = nil
      end
    end
    local cpuUsageCount = 0
    local cpuUsageSum   = 0
    for playerID, t in pairs(cpuUsages) do
      cpuUsageSum   = cpuUsageSum + t.cpuUsage
      cpuUsageCount = cpuUsageCount + 1
    end
    local averageCpu = (cpuUsageSum/cpuUsageCount) * (setspeed/actualspeed)
    if (averageCpu > lagTrigger+triggerTolerance) then
      if (not lagging) then
        Spring.SetGameRulesParam("lagging", 1)
      end
      lagging = true
    end
    if (averageCpu < lagTrigger-triggerTolerance) then
      if (lagging) then
        Spring.SetGameRulesParam("lagging", 0)
      end
      lagging = false
    end
  end
end


local function KillOldChicken()
  local now = spGetGameSeconds()
  for unitID, birthDate in pairs(chickenBirths) do
    local age = now - birthDate
    if (age > maxAge + random(10)) then
      Spring.DestroyUnit(unitID)
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Game End Stuff
--

local function KillAllChicken()
  local chickenUnits = spGetTeamUnits(chickenTeamID)
  for i=1,#chickenUnits do
    Spring.DestroyUnit(chickenUnits[i])
  end
end


local function KillAllComputerUnits()
  for teamID in pairs(computerTeams) do
    local teamUnits = spGetTeamUnits(teamID)
    for i=1,#teamUnits do
      Spring.DestroyUnit(teamUnits[i])
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Spawn Dynamics
--


local function IsPlayerUnitNear(x, z, r)
  for teamID in pairs(humanTeams) do   
    if (Spring.GetUnitsInCylinder(x, z, r, teamID)[1]) then
      return true
    end
  end
end


local function AttackNearestEnemy(unitID)
  local targetID = Spring.GetUnitNearestEnemy(unitID)
  if (targetID) then
    local tx, ty, tz  = spGetUnitPosition(targetID)
    spGiveOrderToUnit(unitID, CMD_FIGHT, {tx, ty, tz}, emptyTable)
  end
end


local function SpawnEggs(x, y, z)
  local choices,choisesN = {},0
  local now = spGetGameSeconds()

  for name in pairs(chickenTypes) do
    if (not chickenTypes[name].noegg and chickenTypes[name].time <= now) then
      choisesN = choisesN + 1
      choices[choisesN] = name
    end
  end
  for name in pairs(defenders) do
    if (not defenders[name].noegg and defenders[name].time <= now) then
      choisesN = choisesN + 1
      choices[choisesN] = name
    end
  end
  for i=1, burrowEggs do
    local choice = choices[random(choisesN)]
    local rx, rz = random(-30, 30), random(-30, 30)
    Spring.CreateFeature(choice.."_egg", x+rx, y, z+rz, random(-32000, 32000))
  end
end


local function ChooseTarget(unitID)
  local teamID
  if unitID then
	teamID = spGetUnitTeam(unitID)
  else
	local humanTeamList = SetToList(humanTeams)
	if (not humanTeamList[1]) then
	  return
	end
	teamID = humanTeamList[random(#humanTeamList)]
  end
  units  = spGetTeamUnits(teamID)
  local targetID
  if (units[2]) then
    targetID = units[random(#units)]
  else
    targetID = units[1]
  end
  return {spGetUnitPosition(targetID)}
end


local function ChooseChicken(units)
  local s = spGetGameSeconds()
  local units = units or chickenTypes
  local choices,choisesN = {},0
  for chickenName, c in pairs(units) do
    if (c.time <= s and (c.obsolete or math.huge) > s) then   
      local chance = math.floor((c.initialChance or 1) + 
                                (s-c.time) * (c.chanceIncrease or 0))
      for i=1, chance do
        choisesN = choisesN + 1
        choices[choisesN] = chickenName
      end
    end
  end
  if (choisesN==0) then
    return
  else
    return choices[random(choisesN)], choices[random(choisesN)]
  end
end


local function SpawnChicken(burrowID, spawnNumber, chickenName)
  local x, z
  local bx, by, bz    = spGetUnitPosition(burrowID)
  if (not bx or not by or not bz) then
    return
  end
  local tries         = 0
  local s             = spawnSquare
  local now           = spGetGameSeconds()
  local burrowTarget  = Spring.GetUnitNearestEnemy(burrowID, 20000, false)
  local tloc
  if (burrowTarget) then tloc = ChooseTarget(burrowTarget) end

  for i=1, spawnNumber do

    repeat
      x = random(bx - s, bx + s)
      z = random(bz - s, bz + s)
      s = s + spawnSquareIncrement
      tries = tries + 1
    until (not spGetGroundBlocked(x, z) or tries > spawnNumber + maxTries)
    local unitID = spCreateUnit(chickenName, x, 0, z, "n", chickenTeamID)
    spGiveOrderToUnit(unitID, CMD.MOVE_STATE, roamParam, emptyTable) --// set moveState to roam
    if (tloc) then spGiveOrderToUnit(unitID, CMD_FIGHT, tloc, emptyTable) end
    chickenBirths[unitID] = now 
  end
end


local function SpawnTurret(burrowID, turret)
  local temp = defenderChance
  defenderChance = defenderChance + (waveBonusDelta/playerCount)/2
  
  if turret then
	if defenders[turret].quasiAttacker then
		--Spring.Echo("Quasi attacker selected")
		defenderChance = quasiAttackerChance - defenderChance
		if defenderChance < 0 then defenderChance = 0 end
	end
	defenderChance = math.min(defenderChance * defenders[turret].squadSize, 0.8)
  end
	
  
  if (random() > defenderChance and defenderChance < 1 or not turret) then
    return
  end
  
  local x, z
  local bx, by, bz    = spGetUnitPosition(burrowID)
  local tries         = 0
  local s             = spawnSquare
  local spawnNumber   = math.max(math.floor(defenderChance), 1)
  local now           = spGetGameSeconds()
  local turretDef

  for i=1, spawnNumber do
    
    repeat
      x = random(bx - s, bx + s)
      z = random(bz - s, bz + s)
      s = s + spawnSquareIncrement
      tries = tries + 1
    until (not spGetGroundBlocked(x, z) or tries > spawnNumber + maxTries)
    
    local unitID = spCreateUnit(turret, x, 0, z, "n", chickenTeamID) -- FIXME
	turretDef = UnitDefs[spGetUnitDefID(unitID)]
    Spring.SetUnitBlocking(unitID, false)
    turrets[unitID] = now
	if turretDef.canMove then
		local burrowTarget  = Spring.GetUnitNearestEnemy(burrowID, 20000, false)
		if (burrowTarget) then
			local tloc = ChooseTarget(burrowTarget)
			spGiveOrderToUnit(unitID, CMD_FIGHT, tloc, emptyTable)
		end
    end
  end
  defenderChance = temp
end


local testBuilding = UnitDefNames["armestor"].id

local function SpawnBurrow(number)
  
  if (queenID) then
    return
  end

  local t     = spGetGameSeconds()
  local unitDefID = UnitDefNames[burrowName].id
    
  for i=1, (number or 1) do
    local x, z
    local tries = 0

  repeat
    x = random(spawnSquare, Game.mapSizeX - spawnSquare)
    z = random(spawnSquare, Game.mapSizeZ - spawnSquare)
    local y = Spring.GetGroundHeight(x, z)
    tries = tries + 1
    local blocking = Spring.TestBuildOrder(testBuilding, x, y, z, 1)
    if (blocking == 2) then
      local proximity = Spring.GetUnitsInCylinder(x, z, minBaseDistance)
      local vicinity = Spring.GetUnitsInCylinder(x, z, maxBaseDistance)
      local humanUnitsInVicinity = false
      local humanUnitsInProximity = false
      for i=1,vicinity['n'],1 do
        if (spGetUnitTeam(vicinity[i]) ~= chickenTeamID) then
          humanUnitsInVicinity = true
          break
        end
      end

      for i=1,proximity['n'],1 do
        if (spGetUnitTeam(proximity[i]) ~= chickenTeamID) then
          humanUnitsInProximity = true
          break
        end
      end

      if (humanUnitsInProximity or not humanUnitsInVicinity) then
        blocking = 1
      end
    end
  until (blocking == 2 or tries > maxTries)

    local unitID = spCreateUnit(burrowName, x, 0, z, "n", chickenTeamID)
    burrows[unitID] = true
    Spring.SetUnitBlocking(unitID, false)
  end
  
end


local function SpawnQueen()
  
  local x, z
  local tries = 0
  
  local testBuilding = UnitDefNames["corgant"].id
  
  repeat
    x = random(0, Game.mapSizeX)
    z = random(0, Game.mapSizeZ)
    local y = Spring.GetGroundHeight(x, z)
    tries = tries + 1
    local blocking = Spring.TestBuildOrder(testBuilding, x, y, z, 1)
  until (blocking == 2 or tries > maxTries)
  
  return spCreateUnit(queenName, x, 0, z, "n", chickenTeamID)
 
end


local function Wave()
  
  local t = spGetGameSeconds()
  
  if (Spring.GetTeamUnitCount(chickenTeamID) > maxChicken or lagging or t < gracePeriod) then
    return
  end
  
  local burrowCount = 0
  for burrowID in pairs(burrows) do
	burrowCount = burrowCount + 1
  end
  --Spring.Echo("Wave bonus delta this round: "..waveBonusDelta)
  --Spring.Echo("Wave bonus this round: "..waveBonus)
  --reduce all chicken appearance times
  local timeReduction = math.ceil((burrowTechTime * burrowCount)/playerCount)
  totalTimeReduction = totalTimeReduction + timeReduction
  for chickenName, c in pairs(chickenTypes) do
	c.time = c.time - timeReduction
	if c.obsolete then c.obsolete = c.obsolete - timeReduction end
	--if c.time < 0 then c.time = 0 end		--don't think these two lines are really needed
	--if c.obsolete and c.obsolete <0 then c.obsolete = 0 end
  end
  for chickenName, c in pairs(defenders) do
	c.time = c.time - timeReduction
	if c.obsolete then c.obsolete = c.obsolete - timeReduction end
  end
  Spring.Echo(burrowCount .. " burrows have reduced tech time by " .. timeReduction .. " seconds")
  Spring.Echo("Lifetime tech time reduction: " .. totalTimeReduction .. " seconds")
  
  --minburrow handling
  minBurrows = minBurrows + minBurrowsIncrease
  if minBurrows > minBurrowsMax then minBurrows = minBurrowsMax end
  if burrowCount < math.floor(minBurrows) then
	local moreBurrows = math.min(minBurrows - burrowCount, malus)
	moreBurrows = math.floor(moreBurrows/2)
	if moreBurrows < 1 then moreBurrows = 1 end
	for i=1,moreBurrows do SpawnBurrow() end
  end
  
  local chicken1Name, chicken2Name = ChooseChicken(chickenTypes)
  local turret = ChooseChicken(defenders)
  local squadNumber = t*timeSpawnBonus+firstSpawnSize+waveBonus
  --if queenID then squadNumber = squadNumber/2 end
  local chicken1Number = math.ceil(waveRatio * squadNumber * chickenTypes[chicken1Name].squadSize)
  local chicken2Number = math.floor((1-waveRatio) * squadNumber * chickenTypes[chicken2Name].squadSize)
  if (queenID) then
    SpawnChicken(queenID, chicken1Number*queenSpawnMult, chicken1Name)
    SpawnChicken(queenID, chicken2Number*queenSpawnMult, chicken2Name)
  end
  for burrowID in pairs(burrows) do
      SpawnChicken(burrowID, chicken1Number, chicken1Name)
      SpawnChicken(burrowID, chicken2Number, chicken2Name)
      if not queenID then SpawnTurret(burrowID, turret) end
  end
  waveBonus = waveBonus/2
  if waveBonus < 0.1 then waveBonus = 0 end
  waveBonusDelta = 0
  return chicken1Name, chicken2Name, chicken1Number, chicken2Number
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Get rid of the AI
--

local function DisableUnit(unitID)
  Spring.MoveCtrl.Enable(unitID)
  Spring.MoveCtrl.SetNoBlocking(unitID, true)
  Spring.MoveCtrl.SetPosition(unitID, Game.mapSizeX+4000, 0, Game.mapSizeZ+4000)
  Spring.SetUnitHealth(unitID, {paralyze=99999999})
  Spring.SetUnitNoDraw(unitID, true)
  Spring.SetUnitStealth(unitID, true)
  Spring.SetUnitNoSelect(unitID, true)
  commanders[unitID] = nil
end

local function DisableComputerUnits()
  for teamID in pairs(computerTeams) do
    local teamUnits = Spring.GetTeamUnits(teamID)
    for _, unitID in ipairs(teamUnits) do
      DisableUnit(unitID)
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Call-ins
--

function gadget:UnitCreated(unitID, unitDefID, unitTeam)
  local name = UnitDefs[unitDefID].name
  if (name == "armcom" or
      name == "corcom") then
    commanders[unitID] = true
  end
  if (chickenTeamID == unitTeam and name ~= "armcom" and name ~= "corcom" ) then
    local n = Spring.GetGameRulesParam(name.."Count") or 0
    Spring.SetGameRulesParam(name.."Count", n+1)
  end
  if (alwaysVisible and unitTeam == chickenTeamID) then
    Spring.SetUnitAlwaysVisible(unitID, true)
  end
  if (eggs) then
    DisableBuildButtons(unitID, mexes)
  end
end


function gadget:GameFrame(n)

  if (n == 1) then
    DisableComputerUnits()
  end
  
  if ((n+19) % (30 * chickenSpawnRate) < 0.1) then
    local args = {Wave()}
    if (args[1]) then
      _G.chickenEventArgs = {type="wave", unpack(args)}
      SendToUnsynced("ChickenEvent")
      _G.chickenEventArgs = nil
    end
  end
  
  if ((n+21) % 30 < 0.1) then

    DetectCpuLag()
    KillOldChicken()
    UpdateUnitCount()
    targetCache = ChooseTarget()

    if (targetCache) then
      local chickens = spGetTeamUnits(chickenTeamID) 
      for i=1,#chickens do
        local unitID = chickens[i]
        local cmdQueue = spGetUnitCommands(unitID)
        if  (not (cmdQueue and cmdQueue[1]))then
		  --AttackNearestEnemy(unitID)
          spGiveOrderToUnit(unitID, CMD_FIGHT, targetCache, {"shift"})
        end
      end
    end

    local t = spGetGameSeconds()

    if (t >= queenTime) then
      if (not queenID) then
        _G.chickenEventArgs = {type="queen"}
        SendToUnsynced("ChickenEvent")
        _G.chickenEventArgs = nil
        queenID = SpawnQueen()
        local xp = (malus or 1) - 1
        Spring.SetUnitExperience(queenID, xp)
      end
    end
    
    local burrowCount = SetCount(burrows)
    
    local timeSinceLastSpawn = t - timeOfLastSpawn
    local burrowSpawnTime = burrowSpawnRate*0.25*(burrowCount+1)
    
    if (burrowSpawnTime < timeSinceLastSpawn and 
        not lagging and burrowCount < maxBurrows) then
      SpawnBurrow()
      timeOfLastSpawn = t
      _G.chickenEventArgs = {type="burrowSpawn"}
      SendToUnsynced("ChickenEvent")
      _G.chickenEventArgs = nil
    end
    
  end
  
end


function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
  chickenBirths[unitID] = nil
  commanders[unitID] = nil
  turrets[unitID] = nil
  local name = UnitDefs[unitDefID].name
  if (unitTeam == chickenTeamID) then
    if (chickenTypes[name] or defenders[name] or (name == burrowName)) then
      local kills = Spring.GetGameRulesParam(name.."Kills")
      Spring.SetGameRulesParam(name.."Kills", kills + 1)
    end
    if (name == queenName) then
      KillAllComputerUnits()
      KillAllChicken()
    end
  end
  if (name == burrowName) then
    burrows[unitID] = nil
	queenTime = queenTime - (burrowQueenTime/playerCount)
	waveBonus = waveBonus + burrowWaveBonus
	waveBonusDelta = waveBonusDelta + burrowWaveBonus
	Spring.SetGameRulesParam("queenTime", queenTime)
    if (eggs) then
      SpawnEggs(spGetUnitPosition(unitID))
    end
	if (respawnBurrows) or (math.random() < burrowRespawnChance) then
		--Spring.Echo("Respawning burrow")
		SpawnBurrow()
	end
  end
  if (eggs and chickenTypes[name] and not chickenTypes[name].noegg) then
    local x, y, z = spGetUnitPosition(unitID)
    Spring.CreateFeature(name.."_egg", x, y, z, random(-32000, 32000))
  end
  if (eggs and defenders[name] and not defenders[name].noegg) then
    local x, y, z = spGetUnitPosition(unitID)
    Spring.CreateFeature(name.."_egg", x, y, z, random(-32000, 32000))
  end
end


--capturing a chicken counts as killing it
function gadget:AllowUnitTransfer(unitID, unitDefID, oldTeam, newTeam, capture)
	if capture then gadget:UnitDestroyed(unitID, unitDefID, oldTeam) end
	return true
end


function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponID, attackerID, attackerDefID, attackerTeam)
	if unitID == queenID then	--spSetUnitHealth(u, { health = spGetUnitHealth(u) + (damage * queenArmor) })
		damage = damage/malus
		--spEcho("Damage reduced to "..damage)
	end
	return damage
end


function gadget:TeamDied(teamID)
  humanTeams[teamID] = nil
  computerTeams[teamID] = nil
end


function gadget:AllowCommand(unitID, unitDefID, teamID,
                             cmdID, cmdParams, cmdOptions)
  if (eggs) then
    for _, mexName in pairs(mexes) do
      if (UnitDefNames[mexName] and UnitDefNames[mexName].id == -cmdID) then
        return false -- command was used
      end
    end
  end
  return true  -- command was not used
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
else
-- END SYNCED
-- BEGIN UNSYNCED
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local Script = Script
local SYNCED = SYNCED


function WrapToLuaUI()
  if (Script.LuaUI('ChickenEvent')) then
    local chickenEventArgs = {}
    for k, v in spairs(SYNCED.chickenEventArgs) do
      chickenEventArgs[k] = v
    end
    Script.LuaUI.ChickenEvent(chickenEventArgs)
  end
end


function gadget:Initialize()
  gadgetHandler:AddSyncAction('ChickenEvent', WrapToLuaUI)
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end
-- END UNSYNCED
--------------------------------------------------------------------------------

