unitDef = {
  unitname            = [[corflak]],
  name                = [[Cobra]],
  description         = [[Anti-Air Flak Gun]],
  acceleration        = 0,
  bmcode              = [[0]],
  brakeRate           = 0,
  buildAngle          = 8192,
  buildCostEnergy     = 800,
  buildCostMetal      = 800,
  builder             = false,
  buildPic            = [[CORFLAK.png]],
  buildTime           = 800,
  canAttack           = true,
  canstop             = [[1]],
  category            = [[FLOAT]],
  collisionVolumeTest = 1,
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Canon Flak Anti-Air]],
    helptext_fr    = [[Le Cobra est une d?fense Anti-Air de moyenne port?e projetant des balles a fragmentation en l'air. Assez impr?cis mais tirant en zone, il est parfait pour les attaques aeriennes mass?es.]],
  },

  defaultmissiontype  = [[GUARD_NOMOVE]],
  explodeAs           = [[MEDIUM_BUILDINGEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[staticaa]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  levelGround         = false,
  mass                = 400,
  maxDamage           = 2500,
  maxSlope            = 18,
  maxVelocity         = 0,
  maxWaterDepth       = 5000,
  minCloakDistance    = 150,
  noAutoFire          = false,
  noChaseCategory     = [[FIXEDWING LAND SINK SHIP SATELLITE SWIM GUNSHIP FLOAT SUB HOVER]],
  objectName          = [[CORFLAK.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[MEDIUM_BUILDINGEX]],
  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  TEDClass            = [[FORT]],
  turnRate            = 0,
  workerTime          = 0,
  yardMap             = [[oooo]],

  weapons             = {

    {
      def                = [[ARMFLAK_GUN]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    ARMFLAK_GUN = {
      name                    = [[Flak Cannon]],
      accuracy                = 0,
      areaOfEffect            = 128,
      burnblow                = true,
      canattackground         = false,
      color                   = 1,
      craterBoost             = 0,
      craterMult              = 0,
      cylinderTargetting      = 1,

      damage                  = {
        default = 20,
        planes  = [[200]],
        subs    = 10,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:FLAK_HIT_24]],
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      predictBoost            = 1,
      range                   = 1200,
      reloadtime              = 0.5,
      renderType              = 4,
      soundHit                = [[flakhit]],
      soundStart              = [[flakfire]],
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
      description      = [[Wreckage - Cobra]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 5000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 400,
      object           = [[CORFLAK_DEAD]],
      reclaimable      = true,
      reclaimTime      = 400,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Cobra]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 5000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 400,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 400,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Cobra]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 5000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 200,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 200,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corflak = unitDef })
