unitDef = {
  unitname            = [[arm_venom]],
  name                = [[Venom]],
  description         = [[Riot EMP Spider]],
  acceleration        = 0.18,
  bmcode              = [[1]],
  brakeRate           = 0.188,
  buildPic            = [[arm_venom.png]],
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
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[default]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 100,
  maxDamage           = 750,
  maxSlope            = 72,
  maxVelocity         = 1.9,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[MEDIUM]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[armspid.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:YELLOW_LIGHTNING_MUZZLE]],
      [[custom:YELLOW_LIGHTNING_GROUNDFLASH]],
    },

  },

  side                = [[HUMANS]],
  sightDistance       = 380,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  turninplace         = 0,
  turnRate            = 1122,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[spider]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    spider  = {
      name                    = [[Electro-Stunner]],
      areaOfEffect            = 30,
      beamWeapon              = true,
      collideFriendly         = true,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default        = 1000,
      },

      duration                = 8,
      energypershot           = 0,
      explosionGenerator      = [[custom:YELLOW_LIGHTNINGPLOSION]],
      fireStarter             = 0,
      heightMod               = 1,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 12,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      paralyzer               = true,
      paralyzeTime            = 3,
      range                   = 250,
      reloadtime              = 6,
      renderType              = 7,
      rgbColor                = [[1 1 0.25]],
      soundHit                = [[weapons/laser_hit]],
      soundStart              = [[weapons/laser_shoot]],
      soundTrigger            = true,
      targetMoveError         = 0.2,
      texture1                = [[lightning]],
      thickness               = 10,
      turret                  = true,
      weaponType              = [[LightingCannon]],
      weaponVelocity          = 450,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Venom]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 1500,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 100,
      object           = [[ARMSPID_DEAD]],
      reclaimable      = true,
      reclaimTime      = 100,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Venom]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1500,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 100,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 100,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Venom]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1500,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 50,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 50,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ arm_venom = unitDef })
