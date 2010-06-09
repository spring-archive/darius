unitDef = {
  unitname            = [[armjeth]],
  name                = [[Jethro]],
  description         = [[Anti-air Bot]],
  acceleration        = 0.36,
  bmcode              = [[1]],
  brakeRate           = 0.2,
  buildCostEnergy     = 100,
  buildCostMetal      = 100,
  builder             = false,
  buildPic            = [[ARMJETH.png]],
  buildTime           = 100,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Robô anti-ar]],
    description_es = [[Robot Antiaéreo]],
    description_fi = [[Ilmatorjuntarobotti]],
    description_fr = [[Robot Anti-air]],
    description_it = [[Robot da contraerea]],
    helptext       = [[A step between defenders and packos for air defense with the weaknesses of neither as well as being able to decisively protect a mobile force, the Jethro gives Bots a definite advantage vs air. Defenseless vs. land forces.]],
    helptext_bp    = [[Jethro ? um rob? barato dedicado a defesa anti-a?rea. est? entre defenders e packos, sem as fraquezas de nenhum deles, e pode com certeza proteger uma for?a m?vel, dando aos rob?s uma vantagem definitiva contra aeronaves. Nao pode se defender de unidades terrestres.]],
    helptext_es    = [[Un paso entre un defender y un pack0 en términos de defensa antiaérea, sin sus debilidades, y con la abilidad de defender unidades móbiles bien, el Jethro ofrece una ventaja definitiva para los kbots contra aviones. No tiene defensas contra unidades de tierra.]],
    helptext_fi    = [[Kevyell? hakeutuvalla ohjuksella varustettu Jethro on tehokas nopeita, mutta kevyesti panssaroituja ilma-aluksia vastaan. Soveltuu hyvin yksik?iden puolustamiseen ketter?n liikkuvuutensa takia. Ei pysty ampumaan maayksik?it? kohti.]],
    helptext_fr    = [[Se situant entre le Defender et le Packo pour la d?fense a?rienne, en ayant la faiblaisse d'aucun des deux et pouvant offrire un d?fense d?cissive pour les forces mobile, le Jethro done un avantage d?finis pour les robots. Il est sans d?fense contre les unit?s terriennes.]],
    helptext_it    = [[Un passo tra un defender ed un pack0, senza le sue debolezze, e con l'abilitá di proteggere bene una forza mobile, il Jethro offre ai kbot un vantaggio decisivo contro aerei. Non ha difese contro forze terrestre.]],
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
  maxDamage           = 550,
  maxSlope            = 36,
  maxVelocity         = 3,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT2]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM LAND SINK SHIP SATELLITE SWIM FLOAT SUB HOVER]],
  objectName          = [[spherejeth.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:STORMMUZZLE]],
      [[custom:STORMBACK]],
    },

  },

  side                = [[ARM]],
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
  turnRate            = 1118,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    [1] = {
      def               = [[BOGUS_MISSILE]],
      badTargetCategory = [[SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
    },


    [3] = {
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
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[wep_m_fury.s3o]],
      noSelfDamage            = true,
      range                   = 760,
      reloadtime              = 2,
      renderType              = 1,
      selfprop                = true,
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
      description      = [[Wreckage - Jethro]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1100,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 50,
      object           = [[spherejeth_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 50,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Jethro]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1100,
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
      description      = [[Debris - Jethro]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1100,
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

return lowerkeys({ armjeth = unitDef })
