unitDef = {
  unitname            = [[corthud]],
  name                = [[Thug]],
  description         = [[Assault Bot]],
  acceleration        = 0.113,
  bmcode              = [[1]],
  brakeRate           = 0.225,
  buildPic            = [[CORTHUD.png]],
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
  mass                = 70,
  maxDamage           = 600,
  maxSlope            = 36,
  maxVelocity         = 1.9,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[SMALL]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[thud.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:THUDMUZZLE]],
      [[custom:THUDSHELLS]],
      [[custom:THUDDUST]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 450,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  trackOffset         = 0,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ComTrack]],
  trackWidth          = 22,
  turninplace         = 0,
  turnRate            = 1099,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[THUD_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    THUD_WEAPON = {
      name                    = [[Light Plasma Cannon]],
      areaOfEffect            = 36,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 60,
      },

      explosionGenerator      = [[custom:MARY_SUE]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      minbarrelangle          = [[-35]],
      noSelfDamage            = true,
      range                   = 350,
      reloadtime              = 2.5,
      renderType              = 4,
      soundHit                = [[weapons/xplomed3]],
      soundStart              = [[weapons/cannon1]],
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 400,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Thug]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 3000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 70,
      object           = [[thug_d.s3o]],
      reclaimable      = true,
      reclaimTime      = 70,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Heap - Thug]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 70,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 70,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Thug]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 35,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 35,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corthud = unitDef })
