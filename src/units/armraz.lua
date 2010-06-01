unitDef = {
  unitname            = [[armraz]],
  name                = [[Razorback]],
  description         = [[Assault/Riot Strider]],
  acceleration        = 0.156,
  bmcode              = [[1]],
  brakeRate           = 0.262,
  buildCostEnergy     = 4000,
  buildCostMetal      = 4000,
  builder             = false,
  buildPic            = [[ARMRAZ.png]],
  buildTime           = 4000,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Mechwarrior d'Assaut]],
    helptext       = [[The lightest of Nova's heavy striders, the Razorback features twin multi-barelled pulse cannons for extreme crowd control, as well as a head-mounted short-range laser for close in work. Don't use recklessly - its short range can be a real liability.]],
    helptext_fr    = [[Le Razorback est un Robot au blindage lourd arm? de deux Miniguns et d'un canon laser continu ind?pendant. Son blindage et sa pr?cision le rendent utile contre nimporte quel type d'arm?e, ? l'exception des unit?s longues port?e. V?ritable rouleau compresseur, il est pourtant le moins cher et le plus faible des Mechs.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[CRAWL_BLASTSML]],
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[t3generic]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 2000,
  maxDamage           = 11000,
  maxSlope            = 36,
  maxVelocity         = 1.9,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT4]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE SUB]],
  objectName          = [[ARMRAZ]],
  seismicSignature    = 4,
  selfDestructAs      = [[CRAWL_BLASTSML]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:WARMUZZLE]],
      [[custom:razorbackejector]],
    },

  },

  side                = [[ARM]],
  sightDistance       = 578,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  turnRate            = 434,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[RAZORBACK_EMG]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[RAZORBACK_EMG]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
      slaveTo            = 1,
    },


    {
      def                = [[LASER]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    LASER         = {
      name                    = [[High Intensity Laserbeam]],
      areaOfEffect            = 8,
      beamlaser               = 1,
      beamTime                = 0.1,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 25,
        planes  = 25,
        subs    = 1.25,
      },

      energypershot           = 0.25,
      explosionGenerator      = [[custom:flash1green]],
      fireStarter             = 30,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 5.43,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 350,
      reloadtime              = 0.1,
      renderType              = 0,
      rgbColor                = [[0 1 0]],
      soundHit                = [[OTAunit/BURN02]],
      soundStart              = [[OTAunit/BUILD2]],
      soundTrigger            = true,
      sweepfire               = false,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 5.43426627982104,
      tolerance               = 18000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 500,
    },


    RAZORBACK_EMG = {
      name                    = [[Heavy Pulse Autocannon]],
      alphaDecay              = 0.7,
      areaOfEffect            = 32,
      burst                   = 6,
      burstrate               = 0.03,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 10,
        planes  = 10,
        subs    = 0.5,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:EMG_HIT]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 400,
      reloadtime              = 0.06,
      renderType              = 4,
      rgbColor                = [[1 0.95 0.4]],
      separation              = 1.5,
      size                    = 1.7,
      soundStart              = [[flashemg]],
      sprayAngle              = 2048,
      stages                  = 10,
      startsmoke              = [[0]],
      tolerance               = 5000,
      turret                  = true,
      weaponTimer             = 0.1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 550,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Razorback]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 22000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 2000,
      object           = [[ARMRAZ_DEAD]],
      reclaimable      = true,
      reclaimTime      = 2000,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Razorback]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 22000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 2000,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 2000,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Razorback]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 22000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 1000,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 1000,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armraz = unitDef })
