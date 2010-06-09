unitDef = {
  unitname            = [[corstorm]],
  name                = [[Rogue]],
  description         = [[Skirmisher Bot]],
  acceleration        = 0.108,
  bmcode              = [[1]],
  brakeRate           = 0.188,
  buildCostEnergy     = 90,
  buildCostMetal      = 90,
  builder             = false,
  buildPic            = [[CORSTORM.png]],
  buildTime           = 90,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Robô escaramuçador]],
    description_fr = [[Robot Tirailleur]],
    description_it = [[Robot Da Scaramuccia]],
    dexcription_es = [[Robot Escaramuzador]],
    helptext       = [[The Rogue's arcing missiles have a low rate of fire, but do a lot of damage, making it very good at dodging in and out of range of enemy units or defense, or in a powerful initial salvo. Counter them by attacking them with fast units, or crawling bombs when massed.]],
    helptext_bp    = [[O Rogue é um robô escaramuçador. Seus mísseis com trajetória verticalmente curva tem uma baixa velocidade de disparo, mas causam muito dano, tornando-o muito bom em mover-se para dentro e para fora do alcançe das unidades ou defesas inimigas, ou causar grande dano na aproximaç?o inicial. Defenda-se dele atacando-o com unidades rápidas ou com bombas rastejantes se estiverem juntos.]],
    helptext_es    = [[Los misiles del Rogue viajan en un arco y tienen rato de fuego bajo, pero hacen mucho da?o, que le permite al Rogue de ir dentro y fuera del alcance de unidades o defensas enemigas, o de hacer mucho da?o al empezar una batalla. Contrastalos con unidades rápidas o con bombas móviles cuando hay muchos.]],
    helptext_fr    = [[Le Rogue est un tirailleur typique: longue port?e, cadence de tir lente et faible blindage. Ces deux puissants missiles ? t?tes chercheuse sont tr?s puissant mais cette unit? doit fuir le corps ? corps ? tout prix.]],
    helptext_it    = [[I missili del Rogue viaggiano in un arco ed hanno un basso rato di fuoco, ma fanno molto danno. Questo fa che il Rogue sia buono per andare dentro e fuori del raggio di unitá o difese nemiche, o fare molto danno all'inizio d'una battaglia. Contrastali con unitá veloci, o bombe mobili quando sono in massa.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[kbotskirm]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 50,
  maxDamage           = 570,
  maxSlope            = 36,
  maxVelocity         = 1.95,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT2]],
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
  turnRate            = 1103,
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
        default = 325,
        planes  = 325,
        subs    = 16.25,
      },

      fireStarter             = 70,
      flightTime              = 8,
      guidance                = false,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      model                   = [[wep_m_hailstorm.s3o]],
      noSelfDamage            = true,
      predictBoost            = 1,
      range                   = 440,
      reloadtime              = 7,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOSML2]],
      soundHitVolume          = 8,
      soundStart              = [[OTAunit/ROCKLIT1]],
      soundStartVolume        = 7,
      startsmoke              = [[1]],
      startVelocity           = 170,
      tracks                  = false,
      trajectoryHeight        = 0.6,
      turret                  = true,
      weaponTimer             = 3,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 170,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Rogue]],
      blocking         = true,
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
