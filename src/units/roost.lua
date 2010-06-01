unitDef = {
  unitname          = [[roost]],
  name              = [[Roost]],
  description       = [[Spawns Chicken]],
  acceleration      = 0,
  activateWhenBuilt = true,
  bmcode            = [[0]],
  brakeRate         = 0,
  buildAngle        = 4096,
  buildCostEnergy   = 340,
  buildCostMetal    = 340,
  builder           = false,
  buildPic          = [[roost.png]],
  buildTime         = 340,
  category          = [[UNARMED FLOAT]],
  explodeAs         = [[NOWEAPON]],
  footprintX        = 3,
  footprintZ        = 3,
  iconType          = [[special]],
  idleAutoHeal      = 0,
  idleTime          = 1800,
  levelGround       = false,
  mass              = 170,
  maxDamage         = 1800,
  maxSlope          = 36,
  maxVelocity       = 0,
  minCloakDistance  = 150,
  noAutoFire        = false,
  objectName        = [[roost]],
  seismicSignature  = 4,
  selfDestructAs    = [[NOWEAPON]],

  sfxtypes          = {

    explosiongenerators = {
      [[custom:dirt2]],
      [[custom:dirt3]],
    },

  },

  side              = [[ARM]],
  sightDistance     = 273,
  smoothAnim        = true,
  TEDClass          = [[ENERGY]],
  turnRate          = 0,
  upright           = false,
  waterline         = 0,
  workerTime        = 0,
  yardMap           = [[ooooooooo]],

  featureDefs       = {
  },

}

return lowerkeys({ roost = unitDef })
