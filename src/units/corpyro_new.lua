unitDef = {
  unitname              = [[corpyro_new]],
  name                  = [[Pyro]],
  description           = [[I'LL SAVE YOU WITH FIRE]],
  acceleration          = 0.3,
  bmcode                = [[1]],
  brakeRate             = 0.45,
  buildPic              = [[CORPYRO.png]],
  canAttack             = true,
  canGuard              = true,
  canMove               = true,
  canPatrol             = true,
  canstop               = [[1]],
  category              = [[LAND FIREPROOF]],
  corpse                = [[DEAD]],

  customParams          = {
    fireproof = [[1]],
  },

  defaultmissiontype    = [[Standby]],
  explodeAs             = [[CORPYRO_BLAST]],
  footprintX            = 2,
  footprintZ            = 2,
  iconType              = [[kbotraider]],
  idleAutoHeal          = 5,
  idleTime              = 1800,
  leaveTracks           = true,
  maneuverleashlength   = [[640]],
  mass                  = 110,
  maxDamage             = 1000,
  maxSlope              = 36,
  maxVelocity           = 5,
  maxWaterDepth         = 5000,
  minCloakDistance      = 75,
  movementClass         = [[AKBOT2]],
  noAutoFire            = false,
  noChaseCategory       = [[FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName            = [[newpyro.s3o]],
  seismicSignature      = 4,
  selfDestructAs        = [[CORPYRO_BLAST]],
  selfDestructCountdown = 1,

  sfxtypes              = {

    explosiongenerators = {
      [[custom:PILOT]],
      [[custom:PILOT2]],
      [[custom:RAIDMUZZLE]],
      [[custom:VINDIBACK]],
    },

  },

  side                  = [[CORE]],
  sightDistance         = 318,
  smoothAnim            = true,
  steeringmode          = [[2]],
  TEDClass              = [[KBOT]],
  trackOffset           = 0,
  trackStrength         = 8,
  trackStretch          = 1,
  trackType             = [[ComTrack]],
  trackWidth            = 22,
  turnRate              = 1145,
  upright               = true,
  workerTime            = 0,

  weapons               = {

    {
      def                = [[FLAMETHROWER]],
      badTargetCategory  = [[FIREPROOF]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },


    {
      def                = [[CHINESE_FIREWORKS]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs            = {

    FLAMETHROWER      = {
      name                    = [[FlameThrower]],
      areaOfEffect            = 200,
      avoidFeature            = false,
      collideFeature          = false,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default       = 6,
        flamethrowers = 1.2,
        planes        = 6,
        subs          = 0.003,
      },

      explosionGenerator      = [[custom:SMOKE]],
      fireStarter             = 100,
      flameGfxTime            = 1.6,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 0.1,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noExplode               = true,
      noSelfDamage            = true,
      range                   = 280,
      reloadtime              = 0.16,
      renderType              = 5,
      sizeGrowth              = 2.05,
      soundStart              = [[weapons/flamhvy1]],
      soundTrigger            = true,
      sprayAngle              = 50000,
      tolerance               = 2500,
      turret                  = true,
      weaponType              = [[Flame]],
      weaponVelocity          = 180,
    },

  },


  featureDefs           = {

    DEAD  = {
      description      = [[Wreckage - Pyro]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1400,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 110,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 110,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Pyro]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1400,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[100]],
      metal            = 110,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 110,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Pyro]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1400,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[100]],
      metal            = 55,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 55,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corpyro_new = unitDef })
