unitDef = {
  unitname            = [[armwar]],
  name                = [[Warrior]],
  description         = [[Riot Bot]],
  acceleration        = 0.072,
  bmcode              = [[1]],
  brakeRate           = 0.238,
  buildPic            = [[ARMWAR.png]],
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
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[1]],
  mass                = 110,
  maxDamage           = 1200,
  maxSlope            = 36,
  maxVelocity         = 1.9,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[SMALL]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[Spherewarrior.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[SMALL_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:WARMUZZLE]],
      [[custom:emg_shells_l]],
    },

  },

  side                = [[ARM]],
  sightDistance       = 400,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  turninplace         = 0,
  turnRate            = 770,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[WARRIOR_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    WARRIOR_WEAPON = {
      name                    = [[Heavy EMG]],
      accuracy                = 350,
      alphaDecay              = 0.7,
      areaOfEffect            = 96,
      burnblow                = true,
      burst                   = 1,
      burstrate               = 0.1,
      craterBoost             = 0.15,
      craterMult              = 0.3,

      damage                  = {
        default = 39,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:EMG_HIT_HE]],
      firestarter             = 70,
      impulseBoost            = 0,
      impulseFactor           = 0.2,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 320,
      reloadtime              = 0.1,
      renderType              = 4,
      rgbColor                = [[1 0.95 0.4]],
      separation              = 1.5,
      soundHit                = [[weapons/xplosml3]],
      soundStart              = [[weapons/flashemg]],
      stages                  = 10,
      targetMoveError         = 0.3,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 500,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Warrior]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 1760,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 110,
      object           = [[spherewarrior_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 110,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Warrior]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1760,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 110,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 110,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Warrior]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1760,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 55,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 55,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armwar = unitDef })
