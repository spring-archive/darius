unitDef = {
  unitname            = [[corsent]],
  name                = [[Copperhead]],
  description         = [[Flak Tank]],
  acceleration        = 0.0528,
  bmcode              = [[1]],
  brakeRate           = 0.1375,
  buildCostEnergy     = 550,
  buildCostMetal      = 550,
  builder             = false,
  buildPic            = [[corsent.png]],
  buildTime           = 550,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Tanque de flak]],
    description_fr = [[Tank Anti-Air r Canons Flak]],
    helptext_bp    = [[]],
    helptext_fr    = [[Le Copperhead est doté d'un double canon Flak envoyant des balles explosives en l'air. Il compense son imprécision par les dégâts de zones qu'elles provoquent. Peut efficace contre les cibles rapides, il s'occupera parfaitement des cibles aeriennes groupées en essaim.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[default]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[30]],
  mass                = 275,
  maxDamage           = 1200,
  maxSlope            = 18,
  maxVelocity         = 3.2,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[MEDIUM]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM LAND SINK SHIP SATELLITE SWIM FLOAT SUB HOVER]],
  objectName          = [[corsent.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],
  side                = [[HUMANS]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[TANK]],
  trackOffset         = 6,
  trackStrength       = 5,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 32,
  turnRate            = 591.8,
  upright             = false,
  workerTime          = 0,

  weapons             = {

    {
      def               = [[BOGUS_MISSILE]],
      badTargetCategory = [[SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
    },


    {
      def                = [[FLAK]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    BOGUS_MISSILE = {
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


    FLAK          = {
      name                    = [[Flak Cannon]],
      accuracy                = 0,
      areaOfEffect            = 64,
      burnblow                = true,
      canattackground         = false,
      color                   = 1,
      craterBoost             = 0,
      craterMult              = 0,
      cylinderTargetting      = 1,

      damage                  = {
        default = 10.8,
        planes  = 108,
      },

      edgeEffectiveness       = 0.85,
      explosionGenerator      = [[custom:FLAK_HIT_24]],
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      minbarrelangle          = [[-24]],
      noSelfDamage            = true,
      predictBoost            = 1,
      range                   = 900,
      reloadtime              = 0.4,
      renderType              = 4,
      soundHit                = [[weapons/flakhit]],
      soundStart              = [[weapons/flakfire]],
      startsmoke              = [[1]],
      turret                  = true,
      unitsonly               = [[1]],
      weaponTimer             = 1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 2000,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Copperhead]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2400,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 275,
      object           = [[CORSENT_DEAD]],
      reclaimable      = true,
      reclaimTime      = 275,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Copperhead]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2400,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 275,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 275,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Copperhead]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2400,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 137.5,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 137.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corsent = unitDef })
