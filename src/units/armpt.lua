unitDef = {
  unitname            = [[armpt]],
  name                = [[Skeeter]],
  description         = [[Patrol Boat (AA/Scout)]],
  acceleration        = 0.096,
  bmcode              = [[1]],
  brakeRate           = 0.025,
  buildCostEnergy     = 120,
  buildCostMetal      = 120,
  builder             = false,
  buildPic            = [[ARMPT.png]],
  buildTime           = 120,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[SHIP]],
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Navire de Patrouille Éclaireur et Anti-Air]],
    helptext       = [[Cheap, fast, and fragile, this Patrol Boat is good as AA support and spotting for longer-ranged ships. Although it is has a small laser, it is easily destroyed by any armed resistance.]],
    helptext_fr    = [[Pas cher, rapide et peu solide, voici venir le Skeeter et ses canons laser. Utile en début de conflit ou en tant qu'éclaireur son blindage le rends trcs vite obsolcte.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[SMALL_UNITEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[scoutboat]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 60,
  maxDamage           = 460,
  maxVelocity         = 5.5,
  minCloakDistance    = 75,
  minWaterDepth       = 5,
  movementClass       = [[BOAT3]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE SUB]],
  objectName          = [[ARMPT]],
  seismicSignature    = 4,
  selfDestructAs      = [[SMALL_UNITEX]],
  side                = [[ARM]],
  sightDistance       = 845,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[SHIP]],
  turnRate            = 644,
  workerTime          = 0,

  weapons             = {

    {
      def               = [[BOGUS_MISSILE]],
      badTargetCategory = [[SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
    },


    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[MISSILE]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    BOGUS_MISSILE = {
      name                    = [[Missiles]],
      areaOfEffect            = 48,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 0,
      },

      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      metalpershot            = 0,
      range                   = 800,
      reloadtime              = 0.5,
      renderType              = 1,
      startVelocity           = 450,
      tolerance               = 9000,
      turnRate                = 33000,
      turret                  = true,
      weaponAcceleration      = 101,
      weaponTimer             = 0.1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 650,
    },


    LASER         = {
      name                    = [[Laser]],
      areaOfEffect            = 8,
      beamlaser               = 1,
      beamTime                = 0.1,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 40,
        planes  = 40,
        subs    = 2,
      },

      duration                = 0.02,
      energypershot           = 0.2,
      explosionGenerator      = [[custom:FLASH1yellow2]],
      fireStarter             = 50,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      laserFlareSize          = 7.19,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 220,
      reloadtime              = 0.8,
      renderType              = 0,
      rgbColor                = [[1 1 0]],
      soundHit                = [[laserhit]],
      soundStart              = [[OTAunit/LASRFIR1]],
      soundTrigger            = true,
      targetMoveError         = 0.2,
      thickness               = 4.79583152331272,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 750,
    },


    MINESWEEP     = {
      name                    = [[MineSweep]],
      areaOfEffect            = 512,
      avoidFeature            = false,
      avoidFriendly           = false,
      collideFeature          = false,
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 11,
      },

      edgeEffectiveness       = 1,
      explosionGenerator      = [[custom:MINESWEEP]],
      impulseFactor           = 0,
      intensity               = 0,
      interceptedByShieldType = 0,
      lineOfSight             = false,
      noSelfDamage            = true,
      paralyzer               = true,
      paralyzeTime            = 10,
      range                   = 300,
      reloadtime              = 3,
      renderType              = 4,
      tolerance               = 32367,
      turret                  = false,
      weaponTimer             = 0.1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 1024,
    },


    MISSILE       = {
      name                    = [[Light SAM]],
      areaOfEffect            = 8,
      canattackground         = false,
      craterBoost             = 1,
      craterMult              = 2,
      cylinderTargetting      = 1,

      damage                  = {
        default = 9,
        planes  = 90,
        subs    = 4.5,
      },

      explosionGenerator      = [[custom:FLASH2]],
      fireStarter             = 70,
      flightTime              = 4,
      guidance                = true,
      heightmod               = 0.5,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[wep_m_fury.s3o]],
      noSelfDamage            = true,
      range                   = 700,
      reloadtime              = 2,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOMED2]],
      soundStart              = [[OTAunit/ROCKHVY2]],
      startsmoke              = [[1]],
      startVelocity           = 300,
      tolerance               = 10000,
      tracks                  = true,
      trajectoryHeight        = 1.2,
      turnRate                = 16000,
      turret                  = true,
      weaponAcceleration      = 150,
      weaponTimer             = 5,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 750,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Skeeter]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 920,
      energy           = 0,
      featureDead      = [[DEAD2]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 60,
      object           = [[ARMPT_DEAD]],
      reclaimable      = true,
      reclaimTime      = 60,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Skeeter]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 920,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 60,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 60,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Skeeter]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 920,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 30,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 30,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armpt = unitDef })
