unitDef = {
  unitname            = [[cormist]],
  name                = [[Slasher]],
  description         = [[Ranged Support/AA Truck (must stop to fire)]],
  acceleration        = 0.026,
  bmcode              = [[1]],
  brakeRate           = 0.012,
  buildCostEnergy     = 120,
  buildCostMetal      = 120,
  builder             = false,
  buildPic            = [[CORMIST.png]],
  buildTime           = 120,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Veículo lançador de mísseis]],
    description_fr = [[Camion Lance-Missile]],
    helptext       = [[Keep the Slasher at maximum range to harass the opponent's units. The Slasher's missiles track, so they are ideal to kill fast-moving crawling bombs. It is able to hit both air and land, allowing you to counter an enemy who is using both. Cannot fire over terraform walls, and does poorly if an enemy is allowed to close range. Unlike normal skirmishers, the Slasher cannot fire while moving.]],
    helptext_bp    = [[Slasher é um escaramuçador. Mantenha-o a distância máxima do inimigo para perturbar suas unidades ou comandante. Pode atirar tanto contra inimigos aéreos como terrestres, sendo úteis quando o inimigo está usando ambos, e seus mísseis s?o tele-guiados possibilitando acertar alvos pequenos e rápidos como bombas rastejantes. N?o pode atirar sobre muros de terra e luta mal de perto.]],
    helptext_fr    = [[Le Slasher est un camion Tirailleur. Sa trcs grande portée compense un peu son manque de puissance de feu. Capable de tirer en l'air ou au sol, il saura quand meme trouver sa place dans votre armée.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[vehiclesupport]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 60,
  maxDamage           = 500,
  maxSlope            = 18,
  maxVelocity         = 2.5,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[TANK3]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE SUB]],
  objectName          = [[cormist_512.s3o]],
  pushResistant       = 1,
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:SLASHMUZZLE]],
      [[custom:SLASHREARMUZZLE]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  trackOffset         = -6,
  trackStrength       = 5,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 30,
  turninplace         = 0,
  turnInPlace         = 0,
  turnRate            = 400,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[CORTRUCK_MISSILE]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    CORTRUCK_MISSILE = {
      name                    = [[Homing Missiles]],
      areaOfEffect            = 48,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 33.6,
        subs    = 1.68,
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
      model                   = [[wep_m_frostshard.s3o]],
      noSelfDamage            = true,
      range                   = 600,
      reloadtime              = 0.75,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOMED2]],
      soundStart              = [[OTAunit/ROCKHVY2]],
      startsmoke              = [[1]],
      startVelocity           = 450,
      tolerance               = 8000,
      tracks                  = true,
      turnRate                = 33000,
      turret                  = true,
      weaponAcceleration      = 109,
      weaponTimer             = 5,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 545,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Slasher]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 60,
      object           = [[cormist_dead_new.s3o]],
      reclaimable      = true,
      reclaimTime      = 60,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Slasher]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 60,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 60,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Slasher]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 30,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 30,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ cormist = unitDef })
