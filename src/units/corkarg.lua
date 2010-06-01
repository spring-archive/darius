unitDef = {
  unitname            = [[corkarg]],
  name                = [[Karganeth]],
  description         = [[Assault/Riot Strider]],
  acceleration        = 0.096,
  bmcode              = [[1]],
  brakeRate           = 0.238,
  buildCostEnergy     = 4000,
  buildCostMetal      = 4000,
  builder             = false,
  buildPic            = [[CORKARG.png]],
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
    helptext       = [[The Karganeth is a heavy frontal assault unit for when conventional means don't cut it. Decked out with an array of heatrays, flamethrowers and napalm missiles, it can quickly cook anything foolish enough to get too close. However, it is ineffective at long range; skirmishers can defeat it given enough time and manuvering room.]],
    helptext_fr    = [[Le Karganeth est un robot d'assaut lourd. Deux fois plus haut qu'un robot normal, il utilise ses deux rayon r chaleur et ses missiles r tete chercheuse pour littéralement exterminer tout ce qui se trouve prcs de lui. Son blindage lui permet d'ouvrir des breches dans les défenses ennemies que vos alliés sauront exploiter.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[CRAWL_BLASTSML]],
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[t3generic]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  immunetoparalyzer   = [[0]],
  maneuverleashlength = [[640]],
  mass                = 2000,
  maxDamage           = 11000,
  maxSlope            = 36,
  maxVelocity         = 1.787,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT4]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE SUB]],
  objectName          = [[CORKARG]],
  seismicSignature    = 4,
  selfDestructAs      = [[CRAWL_BLASTSML]],
  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  turnRate            = 528,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[HEATRAY]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[KARG_FLAMER]],
      badTargetCategory  = [[FIREPROOF]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },


    {
      def                = [[NAPALM_MISSILES]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    HEATRAY         = {
      name                    = [[Heat Ray]],
      accuracy                = 512,
      areaOfEffect            = 20,
      beamWeapon              = true,
      cegTag                  = [[HEATRAY_CEG]],
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 30,
        planes  = 30,
        subs    = 1.5,
      },

      duration                = 0.3,
      dynDamageExp            = 1,
      dynDamageInverted       = false,
      energypershot           = 0.6,
      explosionGenerator      = [[custom:HEATRAY_HIT]],
      fallOffRate             = 1,
      fireStarter             = 90,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      lodDistance             = 10000,
      noSelfDamage            = true,
      projectiles             = 2,
      proximityPriority       = 4,
      range                   = 350,
      reloadtime              = 0.1,
      renderType              = 0,
      rgbColor                = [[1 0.1 0]],
      rgbColor2               = [[1 1 0.25]],
      soundStart              = [[Kargcant]],
      targetMoveError         = 0.25,
      thickness               = 2.5,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 700,
    },


    KARG_FLAMER     = {
      name                    = [[Flame Thrower]],
      areaOfEffect            = 96,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default       = 7.5,
        flamethrowers = 1.5,
        planes        = 7.5,
        subs          = 0.00375,
      },

      energypershot           = 0.8,
      explosionGenerator      = [[custom:SMOKE]],
      fireStarter             = 100,
      flameGfxTime            = 1.6,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 0.1,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noExplode               = true,
      noSelfDamage            = true,
      range                   = 300,
      reloadtime              = 0.16,
      renderType              = 5,
      sizeGrowth              = 1.4,
      soundStart              = [[OTAunit/FLAMHVY1]],
      soundTrigger            = true,
      sprayAngle              = 40000,
      tolerance               = 2500,
      turret                  = true,
      weaponType              = [[Flame]],
      weaponVelocity          = 200,
    },


    NAPALM_MISSILES = {
      name                    = [[Napalm Missiles]],
      accuracy                = 1500,
      areaOfEffect            = 144,
      burst                   = 3,
      burstrate               = 0.3,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 250,
        subs    = 12.5,
      },

      edgeEffectiveness       = 0.75,
      explosionGenerator      = [[custom:NAPALM_Expl]],
      fireStarter             = 5,
      flightTime              = 4,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0.1,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[missile]],
      noSelfDamage            = true,
      range                   = 450,
      reloadtime              = 8,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOSML2]],
      soundStart              = [[rapidrocket3]],
      soundwater              = [[SplsSml]],
      sprayAngle              = 1000,
      startsmoke              = [[1]],
      startVelocity           = 150,
      tolerance               = 6500,
      tracks                  = true,
      turnRate                = 8000,
      turret                  = true,
      weaponAcceleration      = 200,
      weaponTimer             = 2.2,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 800,
      wobble                  = 10000,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Karganeth]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 22000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 2000,
      object           = [[CORKARG_DEAD]],
      reclaimable      = true,
      reclaimTime      = 2000,
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Karganeth]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 22000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 2000,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 2000,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Karganeth]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 22000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 1000,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 1000,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corkarg = unitDef })
