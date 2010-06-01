unitDef = {
  unitname            = [[pioneer]],
  name                = [[Pioneer]],
  description         = [[Construction Vehicle, Builds at 6 m/s]],
  acceleration        = 0.06,
  brakeRate           = 1.5,
  buildCostEnergy     = 140,
  buildCostMetal      = 140,
  buildDistance       = 180,
  builder             = true,

  buildoptions        = {
  },

  buildTime           = 140,
  canAssist           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canreclamate        = [[1]],
  canstop             = [[1]],
  category            = [[LAND UNARMED]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Veículo de construç?o, constrói a 6 m/s]],
    description_es = [[vehículo para Construcción, construye a 6 m/s]],
    description_fr = [[Véhicule de Construction, Construit r 6 m/s]],
    description_it = [[Veicolo da Costruzzione, costruisce a 6 m/s]],
    helptext       = [[Nova's construction vehicle.]],
    helptext_bp    = [[O veículo de construç?o de NOVA]],
    helptext_es    = [[El Vehículo de construccion de los Nova.]],
    helptext_fr    = [[Le vehicule de construction des Nova. ]],
    helptext_it    = [[Il veicolo da costruzzione dei Nova.]],
  },

  defaultmissiontype  = [[Standby]],
  energyMake          = 0.15,
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[builder]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 70,
  maxDamage           = 1100,
  maxSlope            = 18,
  maxVelocity         = 2.4,
  maxWaterDepth       = 22,
  metalMake           = 0.15,
  minCloakDistance    = 75,
  movementClass       = [[TANK3]],
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  objectName          = [[pioneer]],
  onoffable           = false,
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],
  showNanoSpray       = false,
  side                = [[ARM]],
  sightDistance       = 512,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  terraformSpeed      = 300,
  trackOffset         = 12,
  trackStrength       = 5,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 15,
  turninplace         = 0,
  turnInPlace         = 0,
  turnRate            = 560,
  workerTime          = 6,

  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Pioneer]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2200,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 70,
      object           = [[pioneer_dead]],
      reclaimable      = true,
      reclaimTime      = 70,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Pioneer]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 70,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 70,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Pioneer]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 35,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 35,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ pioneer = unitDef })