unitDef = {
  unitname            = [[panther]],
  name                = [[Panther]],
  description         = [[Raider Tank]],
  acceleration        = 0.125,
  bmcode              = [[1]],
  brakeRate           = 0.125,
  buildCostEnergy     = 350,
  buildCostMetal      = 350,
  builder             = false,
  buildTime           = 350,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Tanque agressor]],
    description_fr = [[Tank Pilleur]],
    helptext       = [[The Panther is a high-tech raider. Its main weapon, a lightning gun, deals mostly paralyze damage. This way, the Panther can disable turrets, waltz through the defensive line, and proceed to level the economic heart of the opponent's base.]],
    helptext_bp    = [[Panther é um agressor de alta tecnologia. sua arma de raios cause principalmente dano PEM, permitindo ao Panther paralizar as defesas inimigas e ent?o passar direto por elas para destruir a infra-estrutura inimiga.]],
    helptext_fr    = [[Le Panther est un pilleur high-tech. Son canon principal sert ? paralyser l'ennemi, lui permettant de traverser les d?fenses afin de s'attaquer au coeur ?conomique d'une base]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[tankraider]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 140,
  maxDamage           = 1000,
  maxSlope            = 18,
  maxVelocity         = 3.9,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[TANK3]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[corseal.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:PANTHER_SPARK]],
    },

  },

  side                = [[ARM]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  trackOffset         = 6,
  trackStrength       = 5,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 30,
  turninplace         = 0,
  turnRate            = 550,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[ARMLATNK_LYZER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[ARMLATNK_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
      slaveTo            = 1,
    },

  },


  weaponDefs          = {

    ARMLATNK_LYZER  = {
      name                    = [[EMP Gun]],
      areaOfEffect            = 8,
      beamlaser               = 1,
      beamTime                = 0.1,
      collideFriendly         = false,
      coreThickness           = 0.1,
      craterBoost             = 0,
      craterMult              = 0,
      cylinderTargetting      = 0,

      damage                  = {
        default        = 1200,
        commanders     = 120,
        empresistant75 = 300,
        empresistant99 = 12,
      },

      duration                = 0.01,
      explosionGenerator      = [[custom:NONE]],
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 0,
      interceptedByShieldType = 1,
      laserFlareSize          = 0,
      lineOfSight             = true,
      minbarrelangle          = [[0]],
      noSelfDamage            = true,
      paralyzer               = true,
      paralyzeTime            = 1,
      range                   = 250,
      reloadtime              = 2.5,
      renderType              = 0,
      rgbColor                = [[1 1 0]],
      soundTrigger            = true,
      targetMoveError         = 0.3,
      thickness               = 1.2,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 400,
    },


    ARMLATNK_WEAPON = {
      name                    = [[LightningGun]],
      areaOfEffect            = 8,
      beamWeapon              = true,
      craterBoost             = 1,
      craterMult              = 2,
      cylinderTargetting      = 0,

      damage                  = {
        default = 250,
        planes  = 250,
        subs    = 12.5,
      },

      duration                = 10,
      explosionGenerator      = [[custom:LIGHTNINGPLOSION]],
      fireStarter             = 50,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 12,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 250,
      reloadtime              = 2.5,
      renderType              = 7,
      rgbColor                = [[0.5 0.5 1]],
      soundHit                = [[OTAunit/Lashit]],
      soundStart              = [[OTAunit/LGHTHVY1]],
      soundTrigger            = true,
      startsmoke              = [[1]],
      targetMoveError         = 0.3,
      texture1                = [[lightning]],
      thickness               = 10,
      turret                  = true,
      weaponType              = [[LightingCannon]],
      weaponVelocity          = 400,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Panther]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 175,
      object           = [[ARMLATNK_DEAD]],
      reclaimable      = true,
      reclaimTime      = 175,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Panther]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 175,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 175,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Panther]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 87.5,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 87.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ panther = unitDef })
