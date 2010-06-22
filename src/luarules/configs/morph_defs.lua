-- $Id: morph_defs.lua 4643 2009-05-22 05:52:27Z carrepairer $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local devolution = false


local morphDefs = {

--[[
  blastwing = {
    into = 'cormine1',
    time = 25,
  }, 
--]]

--[[ // sample definition1 with multiple possible morphs... you nest arrays inside the definition
  armcom = {
    {
      into = 'armcomdgun',
      time = 20,
      metal = 10,
      energy = 10,
      tech = 1,
      xp = 0,
    },
    {
      into = 'corcom',
      time = 20,
      metal = 10,
      energy = 10,
      tech = 1,
      xp = 0,
    },
  }
]]--

--[[
  armdecom = {
    into = 'armcom',
    time   = 20,    -- game seconds
    metal  = 10000, -- metal cost
    energy = 60000, -- energy cost
		tech = 2,				-- tech level
		xp = 0.5,				-- required unit XP
  },
--]]

--[[
  cordecom = {
    into = 'corcom',
    time   = 20,    -- game seconds
    metal  = 10000, -- metal cost
    energy = 60000, -- energy cost
		tech = 2,				-- tech level
  },
--]]
  
--[[
  armcom = {
    {
      into = 'armcom_riot',
      time = 10,
      metal = 0,
      energy = 0,
      tech = 1,
      xp = 0,
    },
    {
      into = 'armcom_armored',
      time = 10,
      metal = 0,
      energy = 0,
      tech = 0,
      xp = 0,
    },
  },
--]]

--[[
  corcom = {
    {
      into = 'corcom_riot',
      time = 10,
      metal = 0,
      energy = 0,
      tech = 1,
      xp = 0,
    },
    {
      into = 'corcom_armored',
      time = 10,
      metal = 0,
      energy = 0,
      tech = 0,
      xp = 0,
    },
  },
--]]

--[[
  --// geos
  armgeo = {
    {
      into = 'amgeo',
      time = 90,
    },
   
    {
      into = 'armgmm',
      time = 120,
    },
  },
--]]


--[[
  amgeo = {
    {
      into = 'armgmm',
      time = 30,
    },
  },
--]]


--[[
  corgeo = {
    {
      into = 'cmgeo',
      time = 90,      
    },
	},
--]]
	
-- //support units
-- jammer
--[[
   armjamt = {
      into = 'armaser',
      time = 25,
    },
--]]

--[[ 
	armaser = {
      into = 'armjamt',
      time = 25,
    }, 
--]]	

--[[
	-- shield
	corjamt = {
      into = 'core_spectre',
      time = 25,
    },
--]]
 
--[[
	core_spectre = {
      into = 'corjamt',
      time = 25,
    }, 
--]]

--[[
	-- radar	
	armrad = {
      into = 'arm_marky',
      time = 12,
    },
--]]

--[[ 
	arm_marky = {
      into = 'armrad',
      time = 12,
    }, 
--]]
	
--[[
	corrad = {
      into = 'corvrad',
      time = 12,
    },
--]]
 
--[[
	corvrad = {
      into = 'corrad',
      time = 12,
    }, 

    {
      into = 'corbhmth',
      time = 130,
      tech = 2,
    },
--]] 

--[[
  cmgeo = {
    {
      into = 'corbhmth',
      time = 40,
      tech = 2,
    },
  },
--]]

--// fusions
--[[
  armfus = {
    into = 'aafus',
    time = 180,
    tech = 2
  },
--]]

--[[
  corfus = {
    into = 'cafus',
    time = 180,
    tech = 2,
  },
--]]
  
  --// storages
--[[  
  armmstor = {
    into = 'armuwadvms',
  },
  armestor = {
    into = 'armuwadves',
  },
  cormstor = {
    into = 'coruwadvms',
  },
  corestor = {
    into = 'coruwadves',
  },
--]]

  --// construction units
	
  --// combat units

  --// Evil4Zerggin: Revised time requirements. All rank requirements set to 3.
  --// Time requirements:
  --// To t1 unit: 10
  --// To t2 unit: 20
  --// To t1 structure: 30
  --// To t2 structure: 60

--[[
  --// arm kbots
  armflea = {
    { 
      into = 'armpw',
      time = 10,
      rank = 3,
    },
    {
      into = 'armfast',
      time = 20,
      rank = 3,
    }, 
  },
--]]
 
--[[ 
  armrock = {
      into = 'armsptk',
      time = 20,
      rank = 3,
  },
--]]

--[[
  armjeth = {
    into = 'armaak',
    time = 20,
    rank = 3,
  }, 
--]]  

--[[
  armpw = {
    {
      into = 'armwar',
      time = 10,
      rank = 3,
    },
    {
      into = 'armfast',
      time = 20,
      rank = 3,
    },
  },
--]]

--[[ 
  armwar = {
    into = 'armzeus',
    time = 20,
    rank = 3,
  },
--]]

--[[
  armzeus = {
    into = 'armcrabe',
    time = 20,
    rank = 3,
  },
--]]

--[[
  armcrabe = {
    {
      into = 'armraz',
      time = 30,
      rank = 3,
    },
    {
      into = 'armshock',
      time = 30,
      rank = 3,
    },
  },
--]]

--[[
  armraz = {
    into = 'armbanth',
    time = 90,
    rank = 3,
  },
--]]

--[[
  armbanth = {
    into = 'armorco',
    time = 180,
    rank = 3,
  },
--]]

--[[  
  -- core kbots
  corak = {
    {
      into = 'cormak',
      time = 10,
      rank = 3,
    },
    {
      into = 'corpyro',
      time = 20,
      rank = 3,
    },
  },
--]]

--[[
  cormak = {
    into = 'corcan',
    time = 20,
    rank = 3,
  },
--]]

--[[
  corcan = {
    into = 'corsumo',
    time = 20,
    rank = 3,
  },
--]]

--[[
  corsumo = {
    {
      into = 'corkarg',
      time = 30,
      rank = 3,
    },
    {
      into = 'armraven',
      time = 30,
      rank = 3,
    },
  },
--]]

--[[
  corkarg = {
    into = 'gorg',
    time = 90,
    rank = 3,
  },
--]]

--[[
  gorg = {
    into = 'corkrog',
    time = 180,
    rank = 3,
  },
--]]

--[[
  corstorm = {
      into = 'cormort',
      time = 20,
      rank = 3,
  },
--]]

--[[
  corthud = {			
    into = 'corcan',
    time = 20,
    rank = 3,
  },
--]]

--[[
  corcrash = {
    into = 'coraak',
    time = 20,
    rank = 3,
  },
--]]

--[[
  cormort = {
    into = 'cormortgold',
    time = 20,
    rank = 3,
  },
--]]

--// arm vehicles
--[[
  armflash = {
    into = 'armstump',
    time = 10,
    rank = 3,
  },
--]]

--[[ 
  armstump = {
    {
      into = 'armbull',
      time = 20,
      rank = 3,
    },
    {
      into = 'panther',
      time = 20,
      rank = 3,
    }, 
  },
--]]

--[[
  armfav = {
    into = 'armflash',
    time = 10,
    rank = 3,
  },
--]]

--[[ 
  tawf013 = {
    {
      into = 'armmerl',
      time = 20,
      rank = 3,
    }, 
  },
--]]

--[[ 
  armjanus = {
    into = 'tawf003',
    time = 20,
    rank = 3,
  },
--]]

--[[ 
  armsam = {
    into = 'armyork',
    time = 20,
    rank = 3,
  }, 
--]]

-- // core vehicles
--[[
  corfav = {
    into = 'corgator',
    time = 10,
    rank = 3,
  },
--]]

--[[
  corgator = {
    {
    into = 'corraid',
    time = 10,
    rank = 3,
    },
    {
    into = 'logkoda',
    time = 10,
    rank = 3,
    },
  },
--]]

--[[
  corraid = {
    into = 'correap',
    time = 20,
    rank = 3,
  },
--]]

--[[
  correap = {
    into = 'corgol',
    time = 20,
    rank = 3,   
  },
--]]

--[[
  corlevlr = {
    into = 'core_egg_shell',
    time = 20,
    rank = 3,   
  },
--]]

--[[
  corgarp = {
    {
      into = 'cormart',
      time = 20,
      rank = 3,   
    },
  },
--]]

--[[
  cormart = {
    {
      into = 'trem',
      time = 20,
      rank = 3,   
    },
  },
--]]

--[[
  cormist = {
    {
      into = 'corsent',
      time = 20,
      rank = 3,   
    },
  },
--]]
  
--// hovers and amphs
--[[
  armsh = {
    {
      into = 'armanac',
      time = 10,
      rank = 3,   
    },
  },
--]]

--[[
  corsh = {
    {
      into = 'nsaclash',
      time = 10,
      rank = 3,   
    },
  },
--]]

--//ships
--[[
  armpt = {
    {
      into = 'decade',
      time = 10,
      rank = 3,   
    },
  },
--]]

--[[
  decade = {
    {
      into = 'armroy',
      time = 10,
      rank = 3,   
    },
  },
--]]

--[[
  armroy = {
    {
      into = 'armcrus',
      time = 20,
      rank = 3,   
    },
  },
--]]

--[[
  armmls = {
    {
      into = 'armaas',
      time = 20,
      rank = 3,   
    },
  },
--]]

--[[
  corpt = {
    {
      into = 'coresupp',
      time = 10,
      rank = 3,   
    },
  },
--]]

--[[
  coresupp = {
    {
      into = 'corroy',
      time = 10,
      rank = 3,   
    },
  },
--]]

--[[
  corroy = {
    {
      into = 'corcrus',
      time = 20,
      rank = 3,   
    },
  },
--]]

--[[
  cormls = {
    {
      into = 'corarch',
      time = 20,
      rank = 3,   
    },
  },
--]]

--// land turrets
--[[  
  armllt = {
    {
      into = 'armartic',
      time = 30,
      rank = 3,
    },
    {
      into = 'armdeva',
      time = 30,
      rank = 3,
    },
  },
--]]

--[[
  armdeva = {
    into = 'armpb',
    time = 60,
    rank = 3,
  },
--]]

--[[
  corllt = {
    {
      into = 'corpre',
      time = 30,
      rank = 3,
    },
    {
      into = 'corgrav',
      time = 30,
      rank = 3,
    },
  },
--]]

--[[ 
  corpre = {
    into = 'corvipe',
    time = 60,
    rank = 3,
  },
--]]

--[[
  armhlt = {
    into = 'armanni',
    time = 60,
    rank = 3,
  },
--]]

--[[
  corhlt = {
    into = 'cordoom',
    time = 60,
    rank = 3,
  },
--]]

--[[
  armrl = {
    into = 'armarch',
    time = 30,
    rank = 3,
  },
--]]

--[[
  armarch = {
    into = 'armcir',
    time = 60,
    rank = 3,
  },
--]]

--[[
  corrl = {
    into = 'corrazor',
    time = 30,
    rank = 3,
  },
--]]

--[[
  corrazor = {
    into = 'corflak',
    time = 60,
    rank = 3,
  },
--]]

--[[
  armcir = {
    into = 'mercury',
    time = 60,
    rank = 3,
  },
--]]

--[[
  corflak = {
    into = 'screamer',
    time = 60,
    rank = 3,
  },
--]]

--// sea turrets
--[[
  armtl = {
    into = 'armatl',
    time = 60,
    rank = 3,
  },
--]]

--[[
  cortl = {
    into = 'coratl',
    time = 60,
    rank = 3,
  },
--]]

  
--// concept
--[[
  chicken_drone = {
    [1] = {
      into = 'chickend',
      time = 60,
      rank = 0,
    },
	
   [2] = {
      into = 'nest',
      time = 20,
      rank = 0,
    },
	
	[3] = {
      into = 'thicket',
      time = 3,
      rank = 0,
    },
  }, 
--]]

--[[
  chicken_drone_starter = {
	
   [1] = {
      into = 'nest',
      time = 1,
      rank = 0,
    },
	
  }, 
--]]

--[[
  armfacinabox = {
    [1] = {into = 'armavp', metal = 0, energy = 0, time = 10, facing = true,},
    [2] = {into = 'armalab', metal = 0, energy = 0, time = 10, facing = true,},
    [3] = {into = 'armap', metal = 0, energy = 0, time = 10, facing = true,},
    [4] = {into = 'armfhp', metal = 0, energy = 0, time = 10, facing = true,},
    [5] = {into = 'armcsa', metal = 0, energy = 0, time = 10, facing = true,},
    [6] = {into = 'armaap', metal = 0, energy = 0, time = 10, facing = true,},
    [7] = {into = 'armlab', metal = 0, energy = 0, time = 10, facing = true,},
    [8] = {into = 'armsy', metal = 0, energy = 0, time = 10, facing = true,},
    [9] = {into = 'armvp', metal = 0, energy = 0, time = 10, facing = true,},
  },
--]]

--[[
  corfacinabox = {
    [1] = {into = 'coravp', metal = 0, energy = 0, time = 10, facing = true,},
    [2] = {into = 'coralab', metal = 0, energy = 0, time = 10, facing = true,},
    [3] = {into = 'corap', metal = 0, energy = 0, time = 10, facing = true,},
    [4] = {into = 'corfhp', metal = 0, energy = 0, time = 10, facing = true,},
    [5] = {into = 'corcsa', metal = 0, energy = 0, time = 10, facing = true,},
    [6] = {into = 'coraap', metal = 0, energy = 0, time = 10, facing = true,},
    [7] = {into = 'corlab', metal = 0, energy = 0, time = 10, facing = true,},
    [8] = {into = 'corsy', metal = 0, energy = 0, time = 10, facing = true,},
    [9] = {into = 'corvp', metal = 0, energy = 0, time = 10, facing = true,},
  },
--]]
}


local modOptions
if (Spring.GetModOptions) then
  modOptions = Spring.GetModOptions()
end
--[[
if (modOptions and modOptions.commtype == 'advcomm') then
    morphDefs.corcom = {
   { into = 'corcomdgun2',
    time = 30,
    rank = 0,
  },
  {
    into = 'corcombuild2',
    time = 30,
    rank = 0,
  },
  {
    into = 'corcombattle2',
    time = 30,
    rank = 0,
  },
  }
      morphDefs.armcom = {
   { into = 'armcomdgun2',
    time = 30,
    rank = 0,
  },
  {
    into = 'armcombuild2',
    time = 30,
    rank = 0,
  },
  {
    into = 'armcombattle2',
    time = 30,
    rank = 0,
  },
}
end
--]]


--
-- Here's an example of why active configuration
-- scripts are better then static TDF files...
--

--
-- devolution, babe  (useful for testing)
--
if (devolution) then
  local devoDefs = {}
  for src,data in pairs(morphDefs) do
    devoDefs[data.into] = { into = src, time = 10, metal = 1, energy = 1 }
  end
  for src,data in pairs(devoDefs) do
    morphDefs[src] = data
  end
end


return morphDefs

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
