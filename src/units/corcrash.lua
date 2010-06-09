unitDef = {
  unitname            = [[corcrash]],
  name                = [[Crasher]],
  description         = [[Anti-air Bot]],
  acceleration        = 0.384,
  bmcode              = [[1]],
  brakeRate           = 0.25,
  buildCostEnergy     = 100,
  buildCostMetal      = 100,
  builder             = false,
  buildPic            = [[CORCRASH.png]],
  buildTime           = 100,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = true,
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Robô anti-aéreo]],
    description_es = [[Robot Antiaéreo]],
    description_fr = [[Robot Anti-Air]],
    description_it = [[Robot da contraerea]],
    helptext       = [[The Crasher is a cheap dedicated anti-air bot, it gives bots a definite advantage vs air. Defenseless vs. land forces.]],
    helptext_bp    = [[O Crasher é um robô anti-ar barato. Dá aos robôs uma vantagem definitiva contra aeronaves. N?o pode ser defender de unidades terrestres.]],
    helptext_es    = [[El crasher es un robot antiaéreo barato. Ofrece una ventaja definitiva para los kbots contra aviones. No tiene defensas contra unidades de tierra.]],
    helptext_fr    = [[Le Crasher est l'unit? anti-air de base, il tire des missiles guid?s ? une cadence peu rapide. Redoutable en groupe, il sert ? prot?ger bases et troupes.]],
    helptext_it    = [[Il crasher é un economico robot da contraerea. Offre ai kbot un vantaggio decisivo contro aerei. Non ha difese contro forze terrestre.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[kbotaa]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 50,
  maxDamage           = 650,
  maxSlope            = 36,
  maxVelocity         = 2.7,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT2]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM LAND SINK SHIP SATELLITE SWIM FLOAT SUB HOVER]],
  objectName          = [[m-6.s3o]],
  script              = [[m-6.lua]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:CRASHMUZZLE]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  trackOffset         = 0,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ComTrack]],
  trackWidth          = 22,
  turninplace         = 0,
  turnRate            = 1112,
  upright             = true,

  weapons             = {

    {
      def                = [[ARMKBOT_MISSILE]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    ARMKBOT_MISSILE = {
      name                    = [[Homing Missiles]],
      areaOfEffect            = 48,
      canattackground         = false,
      craterBoost             = 1,
      craterMult              = 2,
      cylinderTargetting      = 1,

      damage                  = {
        default = 9,
        planes  = 90,
        subs    = 4.5,
      },

      explosionGenerator      = [[custom:FLASH2]],
      fireStarter             = 70,
      flightTime              = 3,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      model                   = [[wep_m_fury.s3o]],
      noSelfDamage            = true,
      range                   = 760,
      reloadtime              = 2,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOSML2]],
      soundStart              = [[OTAunit/ROCKLIT1]],
      startsmoke              = [[1]],
      startVelocity           = 650,
      tolerance               = 9000,
      tracks                  = true,
      turnRate                = 63000,
      turret                  = true,
      weaponAcceleration      = 141,
      weaponTimer             = 5,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 850,
    },


    BOGUS_MISSILE   = {
      name                    = [[Missiles]],
      areaOfEffect            = 48,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 0,
      },

      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      metalpershot            = 0,
      range                   = 800,
      reloadtime              = 0.5,
      renderType              = 1,
      startVelocity           = 450,
      tolerance               = 9000,
      turnRate                = 33000,
      turret                  = true,
      weaponAcceleration      = 101,
      weaponTimer             = 0.1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 650,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Crasher]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1300,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 50,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 50,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Crasher]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1300,
      energy           = 0,
      featureDead      = [[HEAP]],
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


    HEAP  = {
      description      = [[Debris - Crasher]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1300,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 25,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 25,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corcrash = unitDef })
