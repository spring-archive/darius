unitDef = {
  unitname            = [[coresupp]],
  name                = [[Supporter]],
  description         = [[Corvette (Assault/Raider)]],
  acceleration        = 0.072,
  activateWhenBuilt   = true,
  bmcode              = [[1]],
  brakeRate           = 0.019,
  buildAngle          = 16384,
  buildCostEnergy     = 320,
  buildCostMetal      = 320,
  builder             = false,
  buildPic            = [[CORESUPP.png]],
  buildTime           = 320,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[SHIP]],
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Corvette d'Assaut/Pillage]],
    helptext       = [[This Corvette combines high speed, decent armor, and strong firepower at a low cost--for a ship. Use Corvette packs against anything on the surface, but watch out for submarine attacks.]],
    helptext_fr    = [[La corvette est ? la fois bon-march? et rapide. Son blindage moyen et sa forte puissance de feu laser en font un bon compromis, mais est vuln?rable aux attaques sousmarines. ]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[corvette]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 160,
  maxDamage           = 2210,
  maxVelocity         = 3.4,
  minCloakDistance    = 75,
  minWaterDepth       = 5,
  movementClass       = [[BOAT3]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[vette.s3o]],
  scale               = [[0.5]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:BEAMWEAPON_MUZZLE_RED]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 429,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[SHIP]],
  turnRate            = 498,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 320,
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
	  mainDir            = [[0 0 -1]],
      maxAngleDif        = 290,
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    LASER = {
      name                    = [[Laser]],
      areaOfEffect            = 8,
      beamWeapon              = true,
      cegTag                  = [[redlaser_ak]],
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 14,
        planes  = 14,
        subs    = 0.7,
      },

      duration                = 0.02,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_RED]],
      fireStarter             = 30,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 320,
      reloadtime              = 0.2,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundHit                = [[laserhit]],
      soundStart              = [[OTAunit/lasrlit3]],
      soundTrigger            = true,
      targetMoveError         = 0.1,
      thickness               = 3.37268439080801,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 1280,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Supporter]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 4420,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 160,
      object           = [[CORESUPP_DEAD]],
      reclaimable      = true,
      reclaimTime      = 160,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Supporter]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4420,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 160,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 160,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Supporter]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4420,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 80,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 80,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ coresupp = unitDef })
