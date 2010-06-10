unitDef = {
  unitname            = [[corcut]],
  name                = [[Cutlass]],
  description         = [[Anti-air/Anti-Ship Gunship]],
  acceleration        = 0.125,
  amphibious          = true,
  bankscale           = [[1]],
  bmcode              = [[1]],
  brakeRate           = 3.938,
  buildCostEnergy     = 500,
  buildCostMetal      = 500,
  builder             = false,
  buildPic            = [[CORCUT.png]],
  buildTime           = 500,
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
  cruiseAlt           = 100,

  customParams        = {
    helptext = [[The Cutlass combines air-to-air and anti-ship capability into a single neat package. Its air-to-air missiles allow the Cutlass to intercept enemy aircraft, although it is no match for a dedicated fighter. The Cutlass also carries depthcharge which can be employed against both surface ships and subs.]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  explodeAs           = [[BIG_UNITEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  hoverAttack         = true,
  iconType            = [[gunship]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[1280]],
  mass                = 250,
  maxDamage           = 1280,
  maxVelocity         = 6.58,
  minCloakDistance    = 75,
  moverate1           = [[8]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE HOVER]],
  objectName          = [[CORCUT]],
  scale               = [[1]],
  seismicSignature    = 0,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:STORMMUZZLE]],
      [[custom:STORMBACK]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 550,
  smoothAnim          = true,
  sonarDistance       = 450,
  steeringmode        = [[1]],
  TEDClass            = [[VTOL]],
  turnRate            = 828,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[CORE_GUNSHIP_AAM]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },


    {
      def                = [[DEPTHCHARGE]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[SWIM FIXEDWING LAND SUB SINK FLOAT SHIP GUNSHIP]],
    },

  },


  weaponDefs          = {

    CORE_GUNSHIP_AAM = {
      name                    = [[Missiles]],
      areaOfEffect            = 48,
      avoidFriendly           = false,
      canattackground         = false,
      collideFriendly         = false,
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
      flightTime              = 3,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[missile]],
      noSelfDamage            = true,
      projectiles             = 2,
      range                   = 760,
      reloadtime              = 2,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOSML2]],
      soundStart              = [[OTAunit/ROCKLIT1]],
      startsmoke              = [[1]],
      startVelocity           = 650,
      tolerance               = 9000,
      tracks                  = true,
      turnRate                = 63000,
      turret                  = false,
      weaponAcceleration      = 141,
      weaponTimer             = 5,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 850,
    },


    DEPTHCHARGE      = {
      name                    = [[Depth Charge]],
      areaOfEffect            = 16,
      avoidFriendly           = false,
      bouncerebound           = 0.5,
      bounceslip              = 0.5,
      burnblow                = true,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 100,
      },

      explosionGenerator      = [[custom:TORPEDO_HIT]],
      groundbounce            = 1,
      guidance                = true,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      model                   = [[depthcharge]],
      noSelfDamage            = true,
      numbounce               = 4,
      projectiles             = 2,
      propeller               = [[1]],
      range                   = 580,
      reloadtime              = 1.8,
      renderType              = 1,
      selfprop                = true,
      soundHit                = [[OTAunit/XPLODEP2]],
      soundStart              = [[OTAunit/TORPEDO1]],
      startVelocity           = 250,
      tracks                  = true,
      turnRate                = 18000,
      turret                  = false,
      waterWeapon             = true,
      weaponAcceleration      = 25,
      weaponTimer             = 6,
      weaponType              = [[TorpedoLauncher]],
      weaponVelocity          = 350,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Cutlass]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2560,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 250,
      object           = [[ARMHAM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 250,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Cutlass]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2560,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 250,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 250,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Cutlass]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2560,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 125,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corcut = unitDef })