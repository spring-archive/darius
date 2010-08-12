unitDef = {
  unitname            = [[armpw]],
  name                = [[Glaive]],
  description         = [[Raider Bot]],
  acceleration        = 0.36,
  bmcode              = [[1]],
  brakeRate           = 0.2,
  buildPic            = [[armpw.png]],
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[SMALL_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[default]],
  idleAutoHeal        = 20,
  idleTime            = 300,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 32.5,
  maxDamage           = 190,
  maxSlope            = 36,
  maxVelocity         = 4,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[SMALL]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[spherebot.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[SMALL_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:emg_shells_l]],
      [[custom:flashmuzzle1]],
    },

  },

  side                = [[HUMANS]],
  sightDistance       = 425,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  trackOffset         = 0,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ComTrack]],
  trackWidth          = 18,
  turninplace         = 0,
  turnRate            = 1250,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[EMG]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    EMG = {
      name                    = [[Pulse MG]],
      alphaDecay              = 0.1,
      areaOfEffect            = 8,
      burst                   = 3,
      burstrate               = 0.1,
      colormap                = [[1 0.95 0.4 1   1 0.95 0.4 1    0 0 0 0.01    1 0.7 0.2 1]],
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 11,
        planes  = 11,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:FLASHPLOSION]],
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noGap                   = false,
      noSelfDamage            = true,
      range                   = 255,
      reloadtime              = 0.31,
      renderType              = 4,
      rgbColor                = [[1 0.95 0.4]],
      separation              = 1.5,
      size                    = 1.75,
      sizeDecay               = 0,
      soundStart              = [[weapons/flashemg]],
      sprayAngle              = 1180,
      stages                  = 10,
      startsmoke              = [[0]],
      tolerance               = 5000,
      turret                  = true,
      weaponTimer             = 0.1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 500,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Glaive]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 380,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 32.5,
      object           = [[spherebot_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 32.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Glaive]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 380,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 32.5,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 32.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Glaive]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 380,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 16.25,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 16.25,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armpw = unitDef })
