unitDef = {
  unitname              = [[armcomdgun2]],
  name                  = [[Commander with advanced Dgun]],
  description           = [[Commander with improved dgun, Builds at 12 m/s]],
  acceleration          = 0.19,
  activateWhenBuilt     = true,
  amphibious            = [[1]],
  autoHeal              = 10,
  bmcode                = [[1]],
  brakeRate             = 0.375,
  buildCostEnergy       = 2800,
  buildCostMetal        = 2800,
  buildDistance         = 120,
  builder               = true,

  buildoptions          = {
  },

  buildPic              = [[armcom.png]],
  buildTime             = 2800,
  canAttack             = true,
  canDGun               = true,
  canGuard              = true,
  canMove               = true,
  canPatrol             = true,
  canreclamate          = [[1]],
  canstop               = [[1]],
  category              = [[LAND FIREPROOF]],
  cloakCost             = 10,
  cloakCostMoving       = 40,
  commander             = true,
  corpse                = [[DEAD]],

  customParams          = {
    fireproof = [[1]],
    helptext  = [[This Nova Commander has been equipped with a full disintegrator weapon suite, allowing it to destroy even the fearsome Saktoth experimental assault mech in a single blow. This is an updated version of the weapon that lacks the older versions' unstable power core, which was notorious for its large death explosion, and a has higher range than other dguns. The suite also includes a personal cloak and advanced turning servos, allowing quick, hairpin turns, along with an expanded energy storage bay.]],
  },

  defaultmissiontype    = [[Standby]],
  energyMake            = 10,
  energyStorage         = 0,
  energyUse             = 0,
  explodeAs             = [[ESTOR_BUILDINGEX]],
  footprintX            = 2,
  footprintZ            = 2,
  hideDamage            = true,
  iconType              = [[corcommander]],
  idleAutoHeal          = 5,
  idleTime              = 1800,
  immunetoparalyzer     = [[1]],
  maneuverleashlength   = [[640]],
  mass                  = 2500,
  maxDamage             = 4000,
  maxSlope              = 36,
  maxVelocity           = 2,
  maxWaterDepth         = 5000,
  metalMake             = 3,
  metalStorage          = 0,
  minCloakDistance      = 100,
  movementClass         = [[AKBOT2]],
  noChaseCategory       = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  norestrict            = [[1]],
  objectName            = [[ARMCOM]],
  radarDistance         = 700,
  reclaimable           = false,
  seismicSignature      = 16,
  selfDestructAs        = [[COMMANDER_BLAST]],
  selfDestructCountdown = 10,

  sfxtypes              = {

    explosiongenerators = {
      [[custom:COMGATE]],
    },

  },

  showPlayerName        = true,
  side                  = [[ARM]],
  sightDistance         = 600,
  smoothAnim            = true,
  sonarDistance         = 300,
  steeringmode          = [[2]],
  TEDClass              = [[COMMANDER]],
  terraformSpeed        = 600,
  turnRate              = 1533,
  upright               = true,
  workerTime            = 12,

  weapons               = {

    [1] = {
      def                = [[FAKELASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    [3] = {
      def = [[DISINTEGRATOR]],
    },


    [4] = {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs            = {

    DISINTEGRATOR = {
      name                    = [[Disintegrator]],
      areaOfEffect            = 36,
      avoidFeature            = false,
      avoidFriendly           = false,
      avoidNeutral            = false,
      commandfire             = true,
      craterBoost             = 1,
      craterMult              = 6,

      damage                  = {
        default    = 99999,
        commanders = [[1]],
      },

      energypershot           = 400,
      explosionGenerator      = [[custom:DGUNTRACE]],
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      noExplode               = true,
      noSelfDamage            = true,
      range                   = 330,
      reloadtime              = 1,
      renderType              = 3,
      soundHit                = [[OTAunit/XPLOMAS2]],
      soundStart              = [[OTAunit/DISIGUN1]],
      soundTrigger            = true,
      tolerance               = 10000,
      turret                  = true,
      weaponTimer             = 4.2,
      weaponType              = [[DGun]],
      weaponVelocity          = 300,
    },


    FAKELASER     = {
      name                    = [[Fake Laser]],
      areaOfEffect            = 12,
      beamlaser               = 1,
      beamTime                = 0.1,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 0,
        subs    = 0,
      },

      duration                = 0.11,
      edgeEffectiveness       = 0.99,
      explosionGenerator      = [[custom:flash1green]],
      fireStarter             = 70,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 5.53,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 250,
      reloadtime              = 0.11,
      renderType              = 0,
      rgbColor                = [[0 1 0]],
      soundHit                = [[OTAunit/BURN02]],
      soundStart              = [[OTAunit/BUILD2]],
      soundTrigger            = true,
      targetMoveError         = 0.05,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 5.53,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 900,
    },


    LASER         = {
      name                    = [[Commander Laser]],
      areaOfEffect            = 12,
      beamlaser               = 1,
      beamTime                = 0.1,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 15.75,
        subs    = 3.75,
      },

      duration                = 0.11,
      edgeEffectiveness       = 0.99,
      explosionGenerator      = [[custom:flash1green]],
      fireStarter             = 70,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 4.31,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 300,
      reloadtime              = 0.11,
      renderType              = 0,
      rgbColor                = [[0 1 0]],
      soundHit                = [[OTAunit/BURN02]],
      soundStart              = [[OTAunit/BUILD2]],
      soundTrigger            = true,
      targetMoveError         = 0.05,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 4.31331514035318,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 900,
    },

  },


  featureDefs           = {

    DEAD      = {
      description      = [[Wreckage - Commander with advanced Dgun]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 8000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 1400,
      object           = [[ARMCOM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 1400,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2     = {
      description      = [[Debris - Commander with advanced Dgun]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 8000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[100]],
      metal            = 1400,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 1400,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP      = {
      description      = [[Debris - Commander with advanced Dgun]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 8000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[100]],
      metal            = 700,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 700,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    RIOT_HEAP = {
      description      = [[Commander Debris]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 20000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 937.5,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armcomdgun2 = unitDef })