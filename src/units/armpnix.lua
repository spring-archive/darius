unitDef = {
  unitname            = [[armpnix]],
  name                = [[Tempest]],
  description         = [[Carpet Bomber]],
  amphibious          = true,
  buildCostEnergy     = 350,
  buildCostMetal      = 350,
  builder             = false,
  buildPic            = [[ARMPNIX.png]],
  buildTime           = 350,
  canAttack           = true,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = true,
  canSubmerge         = false,
  category            = [[FIXEDWING]],
  collide             = false,
  corpse              = [[DEAD]],
  cruiseAlt           = 180,

  customParams        = {
    description_bp = [[Bombardeiro estratégico]],
    description_fr = [[Bombardier Stratégique]],
    helptext       = [[Nova's carpet bomber is a fast-flying aircraft with a lethal package of saturation bombs that can make quick work of lightly armored base infrastructure, such as wind farms.]],
    helptext_bp    = [[O bombardeiro estratégico de Nova é um avi?o rápido que ataca saturando a área do ataque com um grande número de pequenas bombas. Funciona bem contra infraestrutura frágil, como "fazendas" de moinhos de vento.]],
    helptext_fr    = [[Le bombardier Nova Tempest est rapide et armé de bombes a saturation, qui permettent de se débarrasser de toute infrastructure au blindage léger, comme les éoliennes. ]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  explodeAs           = [[GUNSHIPEX]],
  fireState           = 1,
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[bomberraider]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[1380]],
  mass                = 175,
  maxAcc              = 0.5,
  maxDamage           = 700,
  maxFuel             = 1000,
  maxVelocity         = 11,
  minCloakDistance    = 75,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[tempest.s3o]],
  seismicSignature    = 0,
  selfDestructAs      = [[GUNSHIPEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:brawlermuzzle]],
      [[custom:emg_shells_m]],
    },

  },

  side                = [[ARM]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[VTOL]],
  turnRate            = 402,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[ARMADVBOMB]],
      badTargetCategory  = [[SWIM LAND SHIP HOVER]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },


    {
      def                = [[EMG]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    ARMADVBOMB = {
      name                    = [[Bombs]],
      areaOfEffect            = 256,
      avoidFeature            = false,
      avoidFriendly           = false,
      burst                   = 20,
      burstrate               = 0.07,
      collideFriendly         = false,
      commandfire             = true,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 40,
        planes  = 10,
        subs    = 5,
      },

      dropped                 = true,
      edgeEffectiveness       = 0.7,
      explosionGenerator      = [[custom:BigBulletImpact]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      manualBombSettings      = true,
      model                   = [[wep_b_fabby.s3o]],
      myGravity               = 0.7,
      noSelfDamage            = true,
      range                   = 500,
      reloadtime              = 10,
      renderType              = 6,
      soundHit                = [[OTAunit/XPLOMED2]],
      soundStart              = [[OTAunit/BOMBREL]],
      sprayangle              = 64000,
      startvelocity           = 200,
      weaponType              = [[AircraftBomb]],
    },


    EMG        = {
      name                    = [[EMG]],
      areaOfEffect            = 8,
      burst                   = 3,
      burstrate               = 0.1,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 16,
        subs    = 0.8,
      },

      explosionGenerator      = [[custom:BRAWLIMPACTS]],
      fireStarter             = 10,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 500,
      reloadtime              = 2,
      renderType              = 4,
      rgbColor                = [[1 0.5 0]],
      size                    = 1,
      soundStart              = [[flashemg]],
      soundTrigger            = true,
      sprayAngle              = 1024,
      stages                  = 50,
      tolerance               = 64000,
      turret                  = true,
      weaponTimer             = 0.1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 960,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Tempest]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1400,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 175,
      object           = [[tempest_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 175,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Tempest]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1400,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 175,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 175,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Tempest]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1400,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 87.5,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 87.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armpnix = unitDef })
