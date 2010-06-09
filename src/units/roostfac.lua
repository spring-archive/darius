unitDef = {
  unitname         = [[roostfac]],
  name             = [[Roost]],
  description      = [[Spawns Big Chickens]],
  acceleration     = 0,
  bmcode           = [[0]],
  brakeRate        = 0,
  buildAngle       = 4096,
  buildCostEnergy  = 0,
  buildCostMetal   = 0,
  builder          = true,

  buildoptions     = {
    [[chicken_drone]],
    [[chickenf]],
    [[chicken_blimpy]],
    [[chickena]],
    [[chickenc]],
    [[chickenq]],
    [[chicken_spidermonkey]],
    [[chicken_listener]],
  },

  buildPic         = [[roostfac.png]],
  buildTime        = 200,
  canMove          = true,
  canPatrol        = true,
  canstop          = [[1]],
  category         = [[SINK UNARMED]],
  commander        = false,

  customParams     = {
    chickenFac = [[true]],
  },

  energyMake       = 1.05,
  energyStorage    = 50,
  energyUse        = 0,
  explodeAs        = [[NOWEAPON]],
  footprintX       = 8,
  footprintZ       = 8,
  iconType         = [[factory]],
  idleAutoHeal     = 5,
  idleTime         = 1800,
  mass             = 0,
  maxDamage        = 8000,
  maxSlope         = 15,
  maxVelocity      = 0,
  metalMake        = 1.05,
  metalStorage     = 50,
  minCloakDistance = 150,
  noAutoFire       = false,
  objectName       = [[roostfac_big]],
  power            = 1000,
  seismicSignature = 4,
  selfDestructAs   = [[NOWEAPON]],

  sfxtypes         = {

    explosiongenerators = {
      [[custom:dirt2]],
      [[custom:dirt3]],
      [[custom:Nano]],
    },

  },

  showNanoSpray    = false,
  side             = [[THUNDERBIRDS]],
  sightDistance    = 273,
  smoothAnim       = true,
  TEDClass         = [[PLANT]],
  turnRate         = 0,
  workerTime       = 42,
  yardMap          = [[ooccccoo ooccccoo ooccccoo ooccccoo ooccccoo ooccccoo ooccccoo ooccccoo ]],

  featureDefs      = {
  },

}

return lowerkeys({ roostfac = unitDef })
