unitDef = {
  unitname            = [[armthund2]],
  name                = [[Thunder II]],
  description         = [[Precision Laser Bomber]],
  acceleration        = 0.096,
  altfromsealevel     = [[1]],
  amphibious          = true,
  attackrunlength     = [[170]],
  bankscale           = [[1]],
  bmcode              = [[1]],
  brakeRate           = 0.5,
  buildCostEnergy     = 250,
  buildCostMetal      = 250,
  builder             = false,
  buildPic            = [[armthund2.png]],
  buildTime           = 250,
  canAttack           = true,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  canSubmerge         = false,
  category            = [[FIXEDWING]],
  collide             = false,
  corpse              = [[HEAP]],
  cruiseAlt           = 180,

  customParams        = {
    helptext = [[Arm scientists are experimenting with a new type of bomber, collectively known as laser bombers. These bombers offer similar damage to conventional bombers. These lasers are somewhat more responsive than conventional  bombs, but also more sensitive to sudden altitude changes due to their limited range. The beam begins at the target point and trails away as the bomber flies past its target. The Thunder II is the first of these laser bombers. It fires a focused short-duration laser beam, excellent against single, stationary targets, but unable to track moving targets.]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  explodeAs           = [[BIG_UNITEX]],
  fireState           = 1,
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[bomber]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[1380]],
  mass                = 125,
  maxDamage           = 520,
  maxVelocity         = 10.2,
  minCloakDistance    = 75,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[ARMTHUND]],
  scale               = [[1]],
  seismicSignature    = 0,
  selfDestructAs      = [[BIG_UNITEX]],
  side                = [[ARM]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[VTOL]],
  turnRate            = 500,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[BOGUS_BOMB]],
      badTargetCategory  = [[SWIM LAND SHIP HOVER]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },


    {
      def                = [[ARMBOMBLASER]],
      mainDir            = [[0 -1 0]],
      maxAngleDif        = 180,
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    ARMBOMBLASER = {
      name                    = [[BombLaser]],
      areaOfEffect            = 14,
      avoidFeature            = false,
      avoidFriendly           = false,
      beamlaser               = 1,
      beamTime                = 0.01,
      collideFriendly         = false,
      coreThickness           = 0.6,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 160,
        planes  = [[1]],
        subs    = 8,
      },

      explosionGenerator      = [[custom:FLASH1blue]],
      fireStarter             = 90,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 10,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 300,
      reloadtime              = 7,
      renderType              = 0,
      rgbColor                = [[0 0 1]],
      scrollSpeed             = 5,
      targetMoveError         = 5,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 9,
      tileLength              = 300,
      tolerance               = 32767,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 2250,
    },


    BOGUS_BOMB   = {
      name                    = [[BogusBomb]],
      areaOfEffect            = 80,
      burst                   = 2,
      burstrate               = 1,
      commandfire             = true,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 0,
      },

      dropped                 = true,
      edgeEffectiveness       = 0,
      explosionGenerator      = [[custom:NONE]],
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      manualBombSettings      = true,
      model                   = [[]],
      myGravity               = 1000,
      noSelfDamage            = true,
      range                   = 10,
      reloadtime              = 10,
      renderType              = 6,
      scale                   = [[0]],
      weaponType              = [[AircraftBomb]],
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Thunder II]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1040,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 125,
      object           = [[ARMHAM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Thunder II]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1040,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 125,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Thunder II]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1040,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 62.5,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 62.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armthund2 = unitDef })