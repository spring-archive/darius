unitDef = {
  unitname          = [[castle]],
  name              = [[Castle]],
  description       = [[Save me!]],
  acceleration      = 0,
  activateWhenBuilt = false,
  bmcode            = [[0]],
  brakeRate         = 0,
  buildAngle        = 4096,
  buildCostEnergy   = 0,
  buildCostMetal    = 0,
  builder           = false,
  buildPic          = [[castle.png]],
  buildTime         = 0,
  category          = [[SINK UNARMED]],
  corpse            = [[DEAD]],
  explodeAs         = [[SMALL_BUILDINGEX]],
  footprintX        = 4,
  footprintZ        = 4,
  iconType          = [[mex]],
  idleAutoHeal      = 5,
  idleTime          = 1800,
  commander       = true,
  mass              = 40,
  maxDamage         = 20000,
  maxSlope          = 18,
  maxVelocity       = 0,
  metalStorage      = 0,
  minCloakDistance  = 150,
  noAutoFire        = false,
  objectName        = [[castle.s3o]],
  seismicSignature  = 4,
  selfDestructAs    = [[SMALL_BUILDINGEX]],
  side              = [[HUMANS]],
  sightDistance     = 273,
  smoothAnim        = true,
  TEDClass          = [[METAL]],
  turnRate          = 0,
  workerTime        = 0,
  yardMap           = [[oooooooooooooooo]],

  sounds = {
    underattack = {
      "voices/structure_under_attack"
    },
    ok = {
      "voices/unit_selected"
    },
    select = {
      "voices/castle_selected"
    }
  },
  
  featureDefs       = {

    DEAD  = {
      description      = [[Wreckage - Castle]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1400,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 40,
      object           = [[castle_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 40,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Castle]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1400,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 40,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 40,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Castle]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1400,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 20,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 20,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ castle = unitDef })