unitDef = {
  unitname              = [[armcombattle2]],
  name                  = [[Battle Commander]],
  description           = [[Commander with better blaster but less resource production, Builds at 10 m/s]],
  acceleration          = 0.29,
  activateWhenBuilt     = true,
  amphibious            = [[1]],
  autoHeal              = 20,
  bmcode                = [[1]],
  brakeRate             = 0.475,
  buildCostEnergy       = 3200,
  buildCostMetal        = 3200,
  buildDistance         = 90,
  builder               = true,

  buildoptions          = {
  },

  buildPic              = [[armcom.png]],
  buildTime             = 3200,
  canAttack             = true,
  canDGun               = true,
  canGuard              = true,
  canMove               = true,
  canPatrol             = true,
  canreclamate          = [[1]],
  canstop               = [[1]],
  category              = [[LAND FIREPROOF]],
  commander             = true,
  corpse                = [[DEAD]],

  customParams          = {
    fireproof = [[1]],
    helptext  = [[The Nova Battle Commander is a deadly variant of the normal commander. Lethal if used correctly, it comes with better servo-motors, allowing higher movement speed, thicker armor plating, and an advanced EMG weapon, which can outrange most turrets, and fires in suprisingly accurate bursts. Unfortunately, to gain these features, the commander sacrifices much of its economic potential, resulting in lower build speed and less resource production/storage.]],
  },

  defaultmissiontype    = [[Standby]],
  energyMake            = 2,
  energyStorage         = 0,
  energyUse             = 0,
  explodeAs             = [[ESTOR_BUILDINGEX]],
  footprintX            = 2,
  footprintZ            = 2,
  hideDamage            = true,
  iconType              = [[corcommander]],
  idleAutoHeal          = 10,
  idleTime              = 1800,
  immunetoparalyzer     = [[1]],
  maneuverleashlength   = [[640]],
  mass                  = 2500,
  maxDamage             = 6500,
  maxSlope              = 36,
  maxVelocity           = 2.55,
  maxWaterDepth         = 5000,
  metalMake             = 1,
  metalStorage          = 0,
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
      [[custom:WARMUZZLE]],
      [[custom:DEVA_SHELLS]],
    },

  },

  showPlayerName        = true,
  side                  = [[ARM]],
  sightDistance         = 600,
  smoothAnim            = true,
  sonarDistance         = 200,
  steeringmode          = [[2]],
  TEDClass              = [[COMMANDER]],
  terraformSpeed        = 500,
  turnRate              = 1433,
  upright               = true,
  workerTime            = 10,

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
      def                = [[ARMDEVA_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs            = {

    ARMDEVA_WEAPON = {
      name                    = [[RapidSkirmAndRiotCannon]],
      accuracy                = 700,
      alphaDecay              = 0.95,
      areaOfEffect            = 96,
      burnblow                = true,
      burst                   = 8,
      burstrate               = 0.05,
      craterBoost             = 0.15,
      craterMult              = 0.3,

      damage                  = {
        default = 24,
        planes  = 24,
        subs    = 7,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:flash1green]],
      firestarter             = 70,
      impulseBoost            = 0.2,
      impulseFactor           = 0.6,
      intensity               = 1.2,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 425,
      reloadtime              = 0.5,
      renderType              = 4,
      rgbColor                = [[.5 1 .4]],
      separation              = 1.5,
      soundHit                = [[OTAunit/XPLOSML3]],
      soundStart              = [[flashemg]],
      stages                  = 10,
      targetMoveError         = 0.3,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 550,
    },


    DISINTEGRATOR  = {
      name                    = [[Disintegrator]],
      areaOfEffect            = 36,
      avoidFeature            = false,
      avoidFriendly           = false,
      avoidNeutral            = false,
      commandfire             = true,
      craterBoost             = 1,
      craterMult              = 6,

      damage                  = {
        default = 200,
      },

      energypershot           = 150,
      explosionGenerator      = [[custom:DGUNTRACE]],
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      noExplode               = true,
      noSelfDamage            = true,
      range                   = 250,
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


    FAKELASER      = {
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
      interceptedByShieldType = 0,
      largeBeamLaser          = true,
      laserFlareSize          = 5.53,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 320,
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

  },


  featureDefs           = {

    DEAD      = {
      description      = [[Wreckage - Battle Commander]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 13000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 1600,
      object           = [[ARMCOM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 1600,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2     = {
      description      = [[Debris - Battle Commander]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 13000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[100]],
      metal            = 1600,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 1600,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP      = {
      description      = [[Debris - Battle Commander]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 13000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[100]],
      metal            = 800,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 800,
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

return lowerkeys({ armcombattle2 = unitDef })
