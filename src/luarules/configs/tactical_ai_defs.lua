--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


-- swarm arrays
-- these are not strictly required they just help with inputting the units


local lowRangeSwarmieeArray = { 
	"armrock",
	"armham",
	"corstorm",
	"corthud",
  
	"armstump",
	"corraid",
  
	"armsptk",
	"armzeus",
	"armcrabe",
	"cormort",
	"cormortgold",
  
	"armbull",
	"armmanni",
	"correap",
	"corgol",
	"cormart",
  
	"armanac",
	"corseal",
	
	"hoverartillery",
	"hoverassault",
}

local medRangeSwarmieeArray = { 
	"armrock",
	"armham",
	"corstorm",
	"armsptk",
	"cormort",
	"cormortgold",
  
	"cormart",
	"hoverartillery",
	"hoverassault",
}

local longRangeSwarmieeArray = { 
	"cormart",
	
	"hoverartillery",
	"hoverassault",
}

-- skirm arrays
-- these are not strictly required they just help with inputting the units

local artyRangeSkirmieeArray = {
	"corcan",
	"armtick",
	"corroach",
	
	"armpw",
	"corak",
	"armfav",
	"corfav",
	"armflash",
	"corgator",
	"corpyro",
	"panther",
	"armst",
	"logkoda",
	
	"armcom",
	"armcomdgun",
	"corcom",
	"corcomdgun",
	
	"armwar",
	"armzues",
	"arm_venom",
	"cormak",
	"corlevlr",
	"armwar",
	"armstump",
	"corraid",
	"tawf003", -- mumbo
	"tawf114", -- banisher
	"corthud",
	
	"armrock",
	"corstorm",
	"armjanus",
	
	"armsptk",
	"cormort",
	"armsnipe",
	
	"armmist",
	"cormist",
	
	"hoverriot",
	"hoverassault",
	"nsaclash",
	"corsh",
}

local longRangeSkirmieeArray = {
	"corcan",
	"armtick",
	"corroach",
	
	"armpw",
	"corak",
	"armfav",
	"corfav",
	"armflash",
	"corgator",
	"corpyro",
	"panther",
	"armst",
	"logkoda",
	
	"armcom",
	"armcomdgun",
	"corcom",
	"corcomdgun",
	
	"armwar",
	"armzues",
	"arm_venom",
	"cormak",
	"corlevlr",
	"armwar",
	"armstump",
	"armbull",
	"correap",
	"corgol",
	"corraid",
	"tawf003", -- mumbo
	"tawf114", -- banisher
	"corthud",
	
	"armrock",
	"corstorm",
	"armjanus",
	
	"hoverriot",
	"hoverassault",
	"nsaclash",
	"corsh",
}

local medRangeSkirmieeArray = {
	"corcan",
	"armtick",
	"corroach",
	
	"armpw",
	"corak",
	"armfav",
	"corfav",
	"armflash",
	"corgator",
	"corpyro",
	"panther",
	"armst",
	"logkoda",
	
	"armcom",
	"armcomdgun",
	"corcom",
	"corcomdgun",
	
	"armwar",
	"armzues",
	"arm_venom",
	"cormak",
	"corlevlr",
	"tawf003", -- mumbo
	"tawf114", -- banisher
	"corthud",

	"armstump",
	"corraid",
	"armbull",
	"correap",
	"corgol",
	
	"hoverriot",
	"hoverassault",
	"corsh",
}

local riotRangeSkirmieeArray = {
	"corcan",
	"armtick",
	"corroach",
	
	"armcom",
	"armcomdgun",
	"corcom",
	"corcomdgun",
	
	"armpw",
	"corak",
	"armfav",
	"corfav",
	"armflash",
	"corgator",
	"corpyro",
	"panther",
	"armst",
	"logkoda",
	
	"corsh",
}

local raiderRangeSkirmieeArray = {
	"corcan",
	"armtick",
	"corroach",
}

-- skirms: the table of units that this unit will attempt to keep at max range
-- swarms: the table of units that this unit will jink towards and strafe
-- circleStrafe (defaults to false): when set to true the unit will run all around the target unit, false will cause the unit to jink back and forth
-- maxSwarmLeeway: (Weapon range - maxSwarmLeeway) = Max range that the unit will begin strafing targets while swarming
-- minSwarmLeeway (defaults to Weapon range): (Weapon range - minSwarmLeeway) = Range that the unit will attempt to move further away from the target while swarming
-- skirmLeeway: (Weapon range - skirmLeeway) = distance that the unit will try to keep from units while skirming
-- stoppingDistance (defaults to 0): (skirmLeeway - stoppingDistance) = max distance from target unit that move commands can be given while swarming
-- jinkTangentLength (default in config): component of jink vector tangent to direction to enemy
-- jinkParallelLength (default in config): component of jink vector parallel to direction to enemy
-- strafeOrderLength (default in config): length of move order while strafing
-- minCircleStrafeDistance (default in config): (weapon range - minCircleStrafeDistance) = distance at which the circle strafer will attempt to move away from target

--- Array loaded into gadget 
local behaviourConfig = { 
	
	defaultJinkTangentLength = 80,
	defaultJinkParallelLength = 150,
	defaultStrafeOrderLength = 100,
	defaultMinCircleStrafeDistance = 40,
	
	-- swarmers
	["armtick"] = {
		skirms = {}, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 40, 
		jinkTangentSize = 140, 
		skirmLeeway = -30, 
	},
	
	["corroach"] = {
		skirms = {}, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 40, 
		jinkTangentLength = 140, 
		skirmLeeway = -30, 
	},
  
	["armpw"] = {
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 35, 
		skirmLeeway = -50, 
		jinkTangentLength = 140, 
		stoppingDistance = 15,
	},
	
	["armflea"] = {
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 5, 
		skirmLeeway = -30, 
		stoppingDistance = 0,
		strafeOrderLength = 100,
		minCircleStrafeDistance = 20,
	},
	
	["corak"] = {
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 35, 
		skirmLeeway = -30, 
		jinkTangentLength = 140, 
		stoppingDistance = 15,
		minCircleStrafeDistance = 10,
	},

	["armfav"] = { -- jeffy
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 40, 
		skirmLeeway = -40, 
		stoppingDistance = 15,
		minCircleStrafeDistance = 50,
	},
	
	["corfav"] = { -- weasel
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 40, 
		skirmLeeway = -40, 
		stoppingDistance = 15,
		minCircleStrafeDistance = 50,
	},
  
	["armflash"] = {
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 40, 
		skirmLeeway = -40, 
		stoppingDistance = 8
	},
	
	["corgator"] = {
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 40, 
		skirmLeeway = -40, 
		stoppingDistance = 8
	},
  
	["armfast"] = {
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 40, 
		skirmLeeway = -30, 
		stoppingDistance = 8
	},
	
	["corpyro"] = {
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 160, 
		skirmLeeway = -30, 
		stoppingDistance = 8
	},
	
	["armst"] = {
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 40, 
		skirmLeeway = -30, 
		stoppingDistance = 8
	},
	
	["logkoda"] = {
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 40, 
		skirmLeeway = -30, 
		stoppingDistance = 8
	},
  
	["panther"] = {
		skirms = raiderRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		circleStrafe = true, 
		maxSwarmLeeway = 40, 
		skirmLeeway = -50, 
		stoppingDistance = 15
	},
	
	-- riots
	["armwar"] = {
		skirms = riotRangeSkirmieeArray, 
		swarms = {}, 
		maxSwarmLeeway = 0, 
		skirmLeeway = 0, 
	},
	["arm_venom"] = {
		skirms = riotRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		maxSwarmLeeway = 0,
		skirmLeeway = 0, 
	},
	["cormak"] = {
		skirms = riotRangeSkirmieeArray, 
		swarms = {}, 
		maxSwarmLeeway = 0, 
		skirmLeeway = 0, 
	},
	["corlevlr"] = {
		skirms = riotRangeSkirmieeArray, 
		swarms = {}, 
		maxSwarmLeeway = 0, 
		skirmLeeway = -30, 
		stoppingDistance = 5
	},
	["tawf003"] = {
		skirms = riotRangeSkirmieeArray, 
		swarms = lowRangeSwarmieeArray, 
		maxSwarmLeeway = 0, 
		skirmLeeway = -30, 
		stoppingDistance = 5
	},
	["tawf114"] = {
		skirms = riotRangeSkirmieeArray, 
		swarms = {}, 
		maxSwarmLeeway = 0, 
		skirmLeeway = -30, 
		stoppingDistance = 10
		},
	
	-- med range skirms
	["armrock"] = {
		skirms = medRangeSkirmieeArray, 
		swarms = medRangeSwarmieeArray, 
		maxSwarmLeeway = 30, 
		minSwarmLeeway = 130, 
		skirmLeeway = 10, 
	},
	["corstorm"] = {
		skirms = medRangeSkirmieeArray, 
		swarms = medRangeSwarmieeArray, 
		maxSwarmLeeway = 30, 
		minSwarmLeeway = 130, 
		skirmLeeway = 10, 
	},
	["armjanus"] = {
		skirms = medRangeSkirmieeArray, 
		swarms = medRangeSwarmieeArray, 
		maxSwarmLeeway = 30, 
		minSwarmLeeway = 130, 
		skirmLeeway = 30, 
	},
	
	-- long range skirms
	["armsptk"] = {
		skirms = longRangeSkirmieeArray, 
		swarms = longRangeSwarmieeArray, 
		maxSwarmLeeway = 10, 
		minSwarmLeeway = 130, 
		skirmLeeway = 10, 
	},
	["armsnipe"] = {
		skirms = longRangeSkirmieeArray, 
		swarms = longRangeSwarmieeArray, 
		maxSwarmLeeway = 10,
		minSwarmLeeway = 130, 
		skirmLeeway = 10, 
	},
	["cormort"] = {
		skirms = longRangeSkirmieeArray, 
		swarms = longRangeSwarmieeArray, 
		maxSwarmLeeway = 10, 
		minSwarmLeeway = 130, 
		skirmLeeway = 10, 
	},
	
	-- arty range skirms
	["corhrk"] = {
		skirms = artyRangeSkirmieeArray, 
		swarms = longRangeSwarmieeArray, 
		maxSwarmLeeway = 10, 
		minSwarmLeeway = 130, 
		skirmLeeway = 10, 
	},
	["armham"] = {
		skirms = artyRangeSkirmieeArray, 
		swarms = longRangeSwarmieeArray, 
		maxSwarmLeeway = 10, 
		minSwarmLeeway = 130, 
		skirmLeeway = 10, 
	},
	
}

return behaviourConfig

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
