unitDef = {
  unitname            = [[coracv]],
  name                = [[Welder]],
  description         = [[Armed Construction Tank, Builds at 9 m/s]],
  acceleration        = 0.06,
  brakeRate           = 1.5,
  buildCostEnergy     = 250,
  buildCostMetal      = 250,
  buildDistance       = 180,
  builder             = true,

  buildoptions        = {
  },

  buildPic            = [[coracv.png]],
  buildTime           = 250,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canreclamate        = [[1]],
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Tanque de construç?o armado, contrói a 9 m/s]],
    description_fr = [[Tank de Construction Arm?e, Construit ? 9 m/s]],
    helptext       = [[Armed with a small defensive tower, the Welder can defend itself against light enemy attacks.]],
    helptext_bp    = [[Armado com uma torre de defesa, o construtor armado pode se defender de pequenos ataques inimigos.]],
    helptext_fr    = [[Arm? d'une tourelle laser l?g?re, le Welder saura parfaitement se d?fendre contre les attaques de tirailleurs ou d'?claireurs.]],
  },

  defaultmissiontype  = [[Standby]],
  energyMake          = 0.225,
  energyUse           = 0,
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[builder]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 125,
  maxDamage           = 2200,
  maxSlope            = 18,
  maxVelocity         = 2.1,
  maxWaterDepth       = 22,
  metalMake           = 0.225,
  minCloakDistance    = 75,
  movementClass       = [[TANK3]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[coracv]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:BEAMWEAPON_MUZZLE_RED]],
    },

  },

  showNanoSpray       = false,
  side                = [[CORE]],
  sightDistance       = 255,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  terraformSpeed      = 450,
  trackOffset         = 3,
  trackStrength       = 6,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 32,
  turnRate            = 560,
  workerTime          = 9,

  weapons             = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    LASER = {
      name                    = [[Mini Laser]],
      areaOfEffect            = 8,
      beamWeapon              = true,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 8,
        planes  = 8,
        subs    = 0.4,
      },

      duration                = 0.02,
      energypershot           = 0,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_RED]],
      fireStarter             = 50,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 220,
      reloadtime              = 0.25,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundHit                = [[laserhit]],
      soundStart              = [[OTAunit/lasrlit3]],
      soundTrigger            = true,
      targetMoveError         = 0.15,
      thickness               = 2.54950975679639,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 880,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Welder]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 4400,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 125,
      object           = [[CORACV_DEAD]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Welder]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4400,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 125,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Welder]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4400,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 62.5,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 62.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ coracv = unitDef })
