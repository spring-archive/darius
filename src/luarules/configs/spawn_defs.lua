-- $Id: spawn_defs.lua 3990 2009-02-24 02:50:27Z carrepairer $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local hardModifier   = 0.9	--0.75
spawnSquare          = 150       -- size of the chicken spawn square centered on the burrow
spawnSquareIncrement = 1         -- square size increase for each unit spawned
burrowName           = "roost"   -- burrow unit name
playerMalus          = 1         -- how much harder it becomes for each additional player, exponential (playercount^playerMalus = malus)
maxChicken           = 1000
lagTrigger           = 0.65       -- average cpu usage after which lag prevention mode triggers
triggerTolerance     = 0.05      -- increase if lag prevention mode switches on and off too fast
maxAge               = 5*60      -- chicken die at this age, seconds
queenName            = "chickenflyerqueen"
waveRatio            = 0.6       -- waves are composed by two types of chicken, waveRatio% of one and (1-waveRatio)% of the other
defenderChance       = 0.15       -- amount of turrets spawned per wave, <1 is the probability of spawning a single turret
quasiAttackerChance  = 0.6		--subtract defenderChance from this to get spawn chance if "defender" is tagged as a quasi-attacker
maxBurrows           = 40
minBurrows			 = 0	--extra burrows (half of deficit or half of malus, whichever is lower) spawn each wave if there are presently fewer than this
minBurrowsIncrease	 = 0.15	--increase each wave (multiplied by malus)
minBurrowsMax		 = 4    --multiplied by malus
--forceBurrowRespawn	 = false	-- burrows always respawn even if the modoption is set otherwise        
queenSpawnMult       = 3         -- how many times bigger is a queen hatch than a normal burrow hatch
alwaysVisible        = false     -- chicken are always visible
burrowSpawnRate      = 60        -- higher in games with many players, seconds
chickenSpawnRate     = 59
minBaseDistance      = 500      
maxBaseDistance      = 3000
gracePeriod          = 30       -- no chicken spawn in this period, seconds
burrowEggs           = 30        -- number of eggs each burrow spawns
queenTime            = 60*60     -- time at which the queen appears, seconds
burrowQueenTime		= 100		--how much killing a burrow shaves off the queen timer, seconds (divided by playercount)
burrowWaveBonus		= 0.2		--size of temporary bonus to add to next wave
burrowTechTime		= 10		--how many seconds each burrow deducts from the tech time per wave (divided by playercount)
burrowRespawnChance = 0.25

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function Copy(original)   -- Warning: circular table references lead to
  local copy = {}               -- an infinite loop.
  for k, v in pairs(original) do
    if (type(v) == "table") then
      copy[k] = Copy(v)
    else
      copy[k] = v
    end
  end
  return copy
end


local function TimeModifier(d, mod)
  for chicken, t in pairs(d) do
    t.time = t.time*mod
    if (t.obsolete) then
      t.obsolete = t.obsolete*mod
    end
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- times in minutes
local chickenTypes = {
  chicken        =  {time =  0,  squadSize =   3, obsolete = 30},
  chicken_pigeon =  {time =  7,  squadSize =   1.4, obsolete = 50},
  chickena       =  {time = 14,   squadSize = 0.5, obsolete = 50},
  chickens       =  {time = 21,  squadSize =   1, obsolete = 60},
  chicken_leaper       =  {time = 25,  squadSize =   1, obsolete = 60},
  chickenr       =  {time = 30,  squadSize = 1, obsolete = 60},
  chicken_sporeshooter =  {time = 35,  squadSize =   0.5},
  chicken_dodo   =  {time = 40,  squadSize =   2, obsolete = 70},
  chickenf       =  {time = 45,  squadSize = 0.5},
  chickenc       =  {time = 50,  squadSize = 0.5},
  chickenblobber =  {time = 55,  squadSize = 0.3},
  chicken_blimpy =  {time = 60,  squadSize = 0.2},
}

local defenders = {
  chickend =  {time = 20, squadSize = 0.65 },
  chickenspire =  {time = 50, squadSize = 0.35, quasiAttacker = true, },
  chicken_shield =  {time = 40, squadSize = 0.6, quasiAttacker = true, },
}
    
    
difficulties = {
  ['Chicken: Very Easy'] = {
    chickenSpawnRate = 180, 
    burrowSpawnRate  = 300,
    gracePeriod      = 300,
    firstSpawnSize   = 2,
    timeSpawnBonus   = .02,     -- how much each time level increases spawn size
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
	queenTime		 = 32*60,
	queenName        = "chickenbroodqueen",
	maxBurrows       = 6,	
	minBurrows		 = 0,
	minBurrowsIncrease = 0,
  },

  ['Chicken: Easy'] = {
    chickenSpawnRate = 60, 
    burrowSpawnRate  = 50,
    gracePeriod      = 60,
    firstSpawnSize   = 1.2,
    timeSpawnBonus   = .03,
    queenName        = "chickenqueenlite",
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
  },

  ['Chicken: Normal'] = {
    chickenSpawnRate = 50, 
    burrowSpawnRate  = 45,
    firstSpawnSize   = 1.4,
    timeSpawnBonus   = .04,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
  },

  ['Chicken: Hard'] = {
    chickenSpawnRate = 40, 
    burrowSpawnRate  = 45,
    firstSpawnSize   = 1.8,
    timeSpawnBonus   = .05,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
	--burrowQueenTime		= 70,
	burrowWaveBonus		= 0.3,
	burrowTechTime		= 12,
  },
  
  ['Chicken: Suicidal'] = {
    chickenSpawnRate = 30, 
    burrowSpawnRate  = 40,
    firstSpawnSize   = 2.4,
    timeSpawnBonus   = .05,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
	burrowQueenTime		= 75,
	burrowWaveBonus		= 0.3,
	burrowTechTime		= 15,
	burrowRespawnChance = 0.3
  },
}



-- minutes to seconds
for _, d in pairs(difficulties) do
  d.timeSpawnBonus = d.timeSpawnBonus/60
  TimeModifier(d.chickenTypes, 60)
  TimeModifier(d.defenders, 60)
end


--TimeModifier(difficulties['Chicken: Hard'].chickenTypes, hardModifier)
--TimeModifier(difficulties['Chicken: Hard'].defenders,    hardModifier)


difficulties['Chicken Eggs: Very Easy']   = Copy(difficulties['Chicken: Very Easy'])
difficulties['Chicken Eggs: Easy']   = Copy(difficulties['Chicken: Easy'])
difficulties['Chicken Eggs: Normal'] = Copy(difficulties['Chicken: Normal'])
difficulties['Chicken Eggs: Hard']   = Copy(difficulties['Chicken: Hard'])

difficulties['Chicken Eggs: Easy'].eggs   = true
difficulties['Chicken Eggs: Normal'].eggs = true
difficulties['Chicken Eggs: Hard'].eggs   = true

defaultDifficulty = 'Chicken: Normal'

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
