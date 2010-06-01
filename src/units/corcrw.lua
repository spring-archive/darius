unitDef = {
  unitname            = [[corcrw]],
  name                = [[Krow]],
  description         = [[Flying Fortress]],
  acceleration        = 0.154,
  activateWhenBuilt   = true,
  airStrafe           = 0,
  amphibious          = true,
  bankscale           = [[0.5]],
  bmcode              = [[1]],
  brakeRate           = 3.75,
  buildCostEnergy     = 5000,
  buildCostMetal      = 5000,
  builder             = false,
  buildPic            = [[CORCRW.png]],
  buildTime           = 5000,
  canAttack           = true,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  canSubmerge         = false,
  category            = [[GUNSHIP]],
  collide             = false,
  corpse              = [[HEAP]],
  cruiseAlt           = 120,

  customParams        = {
    description_bp = [[Fortaleza voadora]],
    description_fr = [[Forteresse Volante]],
    helptext_bp    = [[Aeronave flutuante armada com lasers para ataque terrestre. Muito cara e muito poderosa.]],
    helptext_fr    = [[La Forteresse Volante est l'ADAV le plus solide jamais construit, est ?quip?e de nombreuses tourelles laser, elle est capable de riposter dans toutes les directions et d'encaisser des d?g?ts importants. Id?al pour un appuyer un assaut lourd ou monopiler l'Anti-Air pendant une attaque a?rienne.]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  explodeAs           = [[SMALL_BUILDING]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  hoverAttack         = true,
  iconType            = [[heavygunship]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[500]],
  mass                = 2500,
  maxDamage           = 17000,
  maxVelocity         = 4.03,
  minCloakDistance    = 75,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[CORCRW]],
  scale               = [[1]],
  seismicSignature    = 0,
  selfDestructAs      = [[SMALL_BUILDING]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:BEAMWEAPON_MUZZLE_RED]],
      [[custom:BEAMWEAPON_MUZZLE_ORANGE]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 633,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[VTOL]],
  turnRate            = 297,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[KROWLASER2]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[KROWLASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[KROWLASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    KROWLASER  = {
      name                    = [[Laser]],
      areaOfEffect            = 8,
      avoidFeature            = false,
      beamWeapon              = true,
      collideFriendly         = false,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 20,
        subs    = 1,
      },

      duration                = 0.02,
      energypershot           = 0,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_RED]],
      fireStarter             = 50,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 575,
      reloadtime              = 0.2,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundHit                = [[laserhit]],
      soundStart              = [[OTAunit/lasrlit3]],
      soundTrigger            = true,
      targetMoveError         = 0.15,
      thickness               = 4.03112887414927,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 2300,
    },


    KROWLASER2 = {
      name                    = [[Heavy Laser]],
      areaOfEffect            = 8,
      avoidFeature            = false,
      beamWeapon              = true,
      collideFriendly         = false,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 20,
        subs    = 1,
      },

      duration                = 0.03,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_ORANGE]],
      fireStarter             = 90,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      lodDistance             = 10000,
      noSelfDamage            = true,
      range                   = 525,
      reloadtime              = 0.2,
      renderType              = 0,
      rgbColor                = [[1 0.25 0]],
      soundHit                = [[psionic/laserhit]],
      soundStart              = [[OTAunit/LASRHVY3]],
      targetMoveError         = 0.2,
      thickness               = 3.16227766016838,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 2100,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Krow]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 34000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 2500,
      object           = [[ARMHAM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 2500,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Krow]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 34000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 2500,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 2500,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Krow]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 34000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 1250,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 1250,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corcrw = unitDef })
