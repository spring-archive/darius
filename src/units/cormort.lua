unitDef = {
  unitname            = [[cormort]],
  name                = [[Morty]],
  description         = [[Skirmisher Walker]],
  acceleration        = 0.132,
  bmcode              = [[1]],
  brakeRate           = 0.225,
  buildCostEnergy     = 220,
  buildCostMetal      = 220,
  builder             = false,
  buildPic            = [[CORMORT.png]],
  buildTime           = 220,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Robô escaramuçador]],
    description_fr = [[Marcheur Tirailleur]],
    helptext       = [[The Morty offers cheap, mobile skirmishing capability. It can outrange light defenses such as LLTs, although it is vulnerable to swarms of raiders.]],
    helptext_bp    = [[Morty é um escaramuçador barato e rápido. Tem maior alcançe que defesas leves com torres de laser leves, mas é vulnerável a grupos de agressores.]],
    helptext_fr    = [[Le Morty offre des capacités de tirailleur idéales pour un prix réduit. Son canon plasma lui permet une longue portée pour une cadence de tir honorable. Il pourra détruire la plupart des tourelles sans risquer d'y laisser sa carcasse. ]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[walkerskirm]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 110,
  maxDamage           = 550,
  maxSlope            = 36,
  maxVelocity         = 2,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT2]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[CORMORT.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:RAIDMUZZLE]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  turninplace         = 0,
  turnRate            = 1099,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[CORE_MORT]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    CORE_MORT = {
      name                    = [[Plasma Cannon]],
      accuracy                = 400,
      areaOfEffect            = 16,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 210,
        planes  = 210,
        subs    = 10.5,
      },

      explosionGenerator      = [[custom:DEFAULT]],
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      minbarrelangle          = [[-35]],
      noSelfDamage            = true,
      range                   = 600,
      reloadtime              = 4,
      renderType              = 4,
      soundHit                = [[OTAunit/XPLOMED3]],
      soundStart              = [[OTAunit/CANNON1]],
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 300,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Morty]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1100,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 110,
      object           = [[CORMORT_DEAD]],
      reclaimable      = true,
      reclaimTime      = 110,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description = [[Debris - Morty]],
      blocking    = false,
      category    = [[heaps]],
      damage      = 1100,
      energy      = 0,
      featureDead = [[HEAP]],
      footprintX  = 2,
      footprintZ  = 2,
      height      = [[4]],
      hitdensity  = [[100]],
      metal       = 110,
      object      = [[debris2x2a.s3o]],
      reclaimable = true,
      reclaimTime = 110,
      world       = [[All Worlds]],
    },


    HEAP  = {
      description = [[Debris - Morty]],
      blocking    = false,
      category    = [[heaps]],
      damage      = 1100,
      energy      = 0,
      footprintX  = 2,
      footprintZ  = 2,
      height      = [[4]],
      hitdensity  = [[100]],
      metal       = 55,
      object      = [[debris2x2a.s3o]],
      reclaimable = true,
      reclaimTime = 55,
      world       = [[All Worlds]],
    },

  },

}

return lowerkeys({ cormort = unitDef })
