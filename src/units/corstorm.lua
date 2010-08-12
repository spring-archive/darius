unitDef = {
  unitname            = [[corstorm]],
  name                = [[Rogue]],
  description         = [[Skirmisher Bot]],
  acceleration        = 0.108,
  bmcode              = [[1]],
  brakeRate           = 0.188,
  buildPic            = [[CORSTORM.png]],
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
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[default]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 100,
  maxDamage           = 770,
  maxSlope            = 36,
  maxVelocity         = 1.9,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[SMALL]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[storm.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:STORMMUZZLE]],
      [[custom:STORMBACK]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 523,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  trackOffset         = 0,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ComTrack]],
  trackWidth          = 22,
  turninplace         = 0,
  turnRate            = 1203,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[STORM_ROCKET]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    STORM_ROCKET = {
      name                    = [[Heavy Rocket]],
      areaOfEffect            = 68,
      craterBoost             = 0,
      craterMult              = 2,

      damage                  = {
        default = 125,
      },

      fireStarter             = 70,
      flightTime              = 8,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      model                   = [[wep_m_hailstorm.s3o]],
      noSelfDamage            = true,
      predictBoost            = 1,
      range                   = 400,
      reloadtime              = 2,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[.1]],
      smokeTrail              = true,
      soundHit                = [[weapons/xplosml2]],
      soundHitVolume          = 8,
      soundStart              = [[weapons/rocklit1]],
      soundStartVolume        = 7,
      startsmoke              = [[1]],
      startVelocity           = 370,
      tracks                  = false,
      trajectoryHeight        = 0.6,
      turret                  = true,
      weaponTimer             = 3,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 800,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Rogue]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 1140,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 50,
      object           = [[CORSTORM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 50,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Rogue]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1140,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 50,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 50,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Rogue]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1140,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 25,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 25,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corstorm = unitDef })
