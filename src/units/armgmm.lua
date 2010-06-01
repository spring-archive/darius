unitDef = {
  unitname          = [[armgmm]],
  name              = [[Prude]],
  description       = [[Produces Energy (80)]],
  acceleration      = 0,
  activateWhenBuilt = true,
  bmcode            = [[0]],
  brakeRate         = 0,
  buildAngle        = 16384,
  buildCostEnergy   = 1500,
  buildCostMetal    = 1500,
  builder           = false,
  buildPic          = [[ARMGMM.png]],
  buildTime         = 1500,
  category          = [[SINK UNARMED]],
  digger            = [[1]],
  energyMake        = 80,
  explodeAs         = [[BIG_BUILDINGEX]],
  footprintX        = 5,
  footprintZ        = 5,
  iconType          = [[energy2]],
  idleAutoHeal      = 5,
  idleTime          = 1800,
  mass              = 750,
  maxDamage         = 10000,
  maxSlope          = 255,
  maxVelocity       = 0,
  maxWaterDepth     = 0,
  minCloakDistance  = 150,
  noAutoFire        = false,
  objectName        = [[ARMGMM]],
  seismicSignature  = 4,
  selfDestructAs    = [[BIG_BUILDINGEX]],
  side              = [[ARM]],
  sightDistance     = 273,
  smoothAnim        = true,
  TEDClass          = [[METAL]],
  turnRate          = 0,
  workerTime        = 0,
  yardMap           = [[ooooo ooooo ooGoo ooooo ooooo]],
}

return lowerkeys({ armgmm = unitDef })