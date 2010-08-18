unitDef = {
  unitname            = [[cormortgold]],
  name                = [[Golden Morty]],
  description         = [[Elite Skirmisher Walker]],
  acceleration        = 0.132,
  bmcode              = [[1]],
  brakeRate           = 0.225,
  buildPic            = [[cormortgold.png]],
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
  maneuverleashlength = [[640]],
  mass                = 1000,
  maxDamage           = 2000,
  maxSlope            = 36,
  maxVelocity         = 1,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[SMALL]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[cormort_gold.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:RAIDMUZZLE]],
    },

  },

  side                = [[HUMANS]],
  sightDistance       = 400,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  turnRate            = 1099,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[CORE_MORTGOLD]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    CORE_MORTGOLD = {
      name                    = [[PlasmaCannon]],
      accuracy                = 400,
      areaOfEffect            = 250,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 450,
      },

      explosionGenerator      = [[custom:DEFAULT]],
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      minbarrelangle          = [[-35]],
      noSelfDamage            = true,
      range                   = 400,
      reloadtime              = 3,
      renderType              = 4,
      soundHit                = [[weapons/xplomed3]],
      soundStart              = [[weapons/cannon1]],
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 900,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Golden Morty]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 1300,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 160,
      object           = [[cormort_dead]],
      reclaimable      = true,
      reclaimTime      = 160,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description = [[Debris - Golden Morty]],
      blocking    = false,
      category    = [[heaps]],
      damage      = 1300,
      energy      = 0,
      featureDead = [[HEAP]],
      footprintX  = 2,
      footprintZ  = 2,
      height      = [[4]],
      hitdensity  = [[100]],
      metal       = 160,
      object      = [[debris3x3a.s3o]],
      reclaimable = true,
      reclaimTime = 160,
      world       = [[All Worlds]],
    },


    HEAP  = {
      description = [[Debris - Golden Morty]],
      blocking    = false,
      category    = [[heaps]],
      damage      = 1300,
      energy      = 0,
      footprintX  = 2,
      footprintZ  = 2,
      height      = [[4]],
      hitdensity  = [[100]],
      metal       = 80,
      object      = [[debris3x3a.s3o]],
      reclaimable = true,
      reclaimTime = 80,
      world       = [[All Worlds]],
    },

  },

}

return lowerkeys({ cormortgold = unitDef })
