unitDef = {
  unitname          = [[corestor]],
  name              = [[Energy Storage]],
  description       = [[Stores Energy (500)]],
  acceleration      = 0,
  activateWhenBuilt = true,
  bmcode            = [[0]],
  brakeRate         = 0,
  buildAngle        = 8196,
  buildCostEnergy   = 150,
  buildCostMetal    = 150,
  builder           = false,
  buildPic          = [[corestor.png]],
  buildTime         = 150,
  category          = [[SINK UNARMED]],
  corpse            = [[DEAD]],
  energyStorage     = 500,
  explodeAs         = [[ESTOR_BUILDINGEX]],
  footprintX        = 3,
  footprintZ        = 3,
  iconType          = [[energy1]],
  idleAutoHeal      = 5,
  idleTime          = 1800,
  mass              = 75,
  maxDamage         = 1000,
  maxSlope          = 18,
  maxVelocity       = 0,
  minCloakDistance  = 150,
  noAutoFire        = false,
  objectName        = [[armestor.s3o]],
  seismicSignature  = 4,
  selfDestructAs    = [[ESTOR_BUILDINGEX]],
  side              = [[CORE]],
  sightDistance     = 273,
  smoothAnim        = true,
  TEDClass          = [[ENERGY]],
  turnRate          = 0,
  workerTime        = 0,
  yardMap           = [[ooooooooo]],

  featureDefs       = {

    DEAD  = {
      description      = [[Wreckage - Energy Storage]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 75,
      object           = [[ARMESTOR_DEAD]],
      reclaimable      = true,
      reclaimTime      = 75,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Energy Storage]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 75,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 75,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Energy Storage]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 37.5,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 37.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corestor = unitDef })