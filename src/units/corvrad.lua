unitDef = {
  unitname            = [[corvrad]],
  name                = [[Informant]],
  description         = [[Radar Vehicle]],
  acceleration        = 0.036,
  activateWhenBuilt   = true,
  bmcode              = [[1]],
  brakeRate           = 0.015,
  buildCostEnergy     = 100,
  buildCostMetal      = 100,
  builder             = false,
  buildPic            = [[CORVRAD.png]],
  buildTime           = 100,
  canAttack           = false,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND UNARMED]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Veículo radar]],
    description_fr = [[Véhicule Radar]],
    helptext       = [[The Informant provides radar coverage on the battlefield.]],
    helptext_bp    = [[]],
    helptext_fr    = [[Le Informant est un peu comme tous les radars mobiles, aussi indispensable que faible.]],
  },

  defaultmissiontype  = [[Standby]],
  energyUse           = 1.5,
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[vehicleradar]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 50,
  maxDamage           = 500,
  maxSlope            = 18,
  maxVelocity         = 2.5,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[TANK2]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  objectName          = [[corvrad.S3O]],
  onoffable           = true,
  radarDistance       = 1800,
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],
  side                = [[CORE]],
  sightDistance       = 800,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  trackOffset         = -7,
  trackStrength       = 5,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 26,
  turninplace         = 0,
  turnInPlace         = 0,
  turnRate            = 231,
  workerTime          = 0,

  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Informant]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 50,
      object           = [[corspy2_dead]],
      reclaimable      = true,
      reclaimTime      = 50,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Informant]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 50,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 50,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Informant]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 25,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 25,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corvrad = unitDef })