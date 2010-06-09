unitDef = {
  unitname         = [[nest]],
  name             = [[Nest]],
  description      = [[Spawns Chickens]],
  acceleration     = 0,
  bmcode           = [[0]],
  brakeRate        = 0,
  buildAngle       = 4096,
  buildCostEnergy  = 0,
  buildCostMetal   = 0,
  builder          = true,

  buildoptions     = {
    [[chicken_drone]],
    [[chicken_pigeon]],
    [[chicken]],
    [[chicken_leaper]],
    [[chickens]],
    [[chicken_dodo]],
    [[chickenf]],
    [[chicken_digger]],
    [[chickena]],
    [[chickenr]],
    [[chicken_spidermonkey]],
    [[chickenc]],
    [[chicken_listener]],
    [[chicken_shield]],
    [[chicken_blimpy]],
    [[chickenq]],
  },

  buildPic         = [[roost.png]],
  buildTime        = 80,
  CanBeAssisted    = 0,
  canMove          = true,
  canPatrol        = true,
  canstop          = [[1]],
  category         = [[SINK UNARMED]],
  commander        = false,

  customParams     = {
    chickenFac = [[true]],
  },

  energyMake       = 0,
  energyStorage    = 50,
  energyUse        = 0,
  explodeAs        = [[NOWEAPON]],
  footprintX       = 6,
  footprintZ       = 6,
  iconType         = [[factory]],
  idleAutoHeal     = 5,
  idleTime         = 1800,
  mass             = 0,
  maxDamage        = 2000,
  maxSlope         = 15,
  maxVelocity      = 0,
  metalMake        = 0,
  metalStorage     = 50,
  minCloakDistance = 150,
  noAutoFire       = false,
  objectName       = [[roostfac]],
  power            = 600,
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
  workerTime       = 21,
  yardMap          = [[occcco occcco occcco occcco occcco occcco]],

  featureDefs      = {
  },

}

return lowerkeys({ nest = unitDef })
