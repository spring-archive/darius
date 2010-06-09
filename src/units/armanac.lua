unitDef = {
  unitname            = [[armanac]],
  name                = [[Anaconda]],
  description         = [[Assault Hovertank]],
  acceleration        = 0.084,
  bmcode              = [[1]],
  brakeRate           = 0.112,
  buildCostEnergy     = 240,
  buildCostMetal      = 240,
  builder             = false,
  buildPic            = [[ARMANAC.png]],
  buildTime           = 240,
  canAttack           = true,
  canGuard            = true,
  canHover            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[HOVER]],
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Hovertank]],
    helptext_fr    = [[Le Anaconda est la version lourde du Skimmer, son blindage r été renforcé, et le canon laser remplacé par un canon plasma lourd. Solide mais lent il convient aux assauts plus poussés. Son prix est cependant rédibitoire.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[hoverassault]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 120,
  maxDamage           = 1377,
  maxSlope            = 36,
  maxVelocity         = 2.73,
  minCloakDistance    = 75,
  movementClass       = [[HOVER3]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[ARMANAC]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:HOVERS_ON_GROUND]],
    },

  },

  side                = [[ARM]],
  sightDistance       = 380,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  turninplace         = 0,
  turnRate            = 525,
  upright             = false,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[ARMANAC_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    ARMANAC_WEAPON = {
      name                    = [[Medium Plasma Cannon]],
      areaOfEffect            = 32,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 98,
        planes  = 98,
        subs    = 4.9,
      },

      explosionGenerator      = [[custom:FLASH2]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 320,
      reloadtime              = 1.4,
      renderType              = 4,
      soundHit                = [[OTAunit/XPLOSML3]],
      soundStart              = [[OTAunit/CANLITE3]],
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 260,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Anaconda]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 2754,
      energy           = 0,
      featureDead      = [[DEAD2]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 120,
      object           = [[ARMANAC_DEAD]],
      reclaimable      = true,
      reclaimTime      = 120,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Anaconda]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2754,
      energy           = 0,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 120,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 120,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Anaconda]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2754,
      energy           = 0,
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 60,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 60,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armanac = unitDef })
