unitDef = {
  unitname         = [[armemp]],
  name             = [[Detonator]],
  description      = [[EMP Missile Launcher]],
  acceleration     = 0,
  antiweapons      = [[1]],
  bmcode           = [[0]],
  brakeRate        = 0,
  buildAngle       = 8192,
  buildCostEnergy  = 2000,
  buildCostMetal   = 2000,
  builder          = false,
  buildPic         = [[ARMEMP.png]],
  buildTime        = 2000,
  canAttack        = true,
  canstop          = [[1]],
  category         = [[SINK UNARMED]],
  corpse           = [[DEAD]],

  customParams     = {
    helptext = [[The Detonator launches guided EMP missiles over a long distance. The missiles can stun targets for 45 seconds, allowing for oppurtunity strikes while defenses are disabled. One popular use is to paralyze an enemy antinuke and then squeeze in a warhead during the window of oppurtunity.]],
  },

  explodeAs        = [[CORGRIPN_BOMB]],
  footprintX       = 4,
  footprintZ       = 4,
  iconType         = [[cruisemissile]],
  idleAutoHeal     = 5,
  idleTime         = 1800,
  levelGround      = false,
  mass             = 1000,
  maxDamage        = 3000,
  maxSlope         = 18,
  maxVelocity      = 0,
  maxWaterDepth    = 0,
  minCloakDistance = 150,
  noAutoFire       = false,
  objectName       = [[ARMEMP]],
  seismicSignature = 4,
  selfDestructAs   = [[CORGRIPN_BOMB]],
  side             = [[ARM]],
  sightDistance    = 660,
  smoothAnim       = true,
  TEDClass         = [[SPECIAL]],
  turnRate         = 0,
  workerTime       = 0,
  yardMap          = [[oooooooooooooooo]],

  weapons          = {

    {
      def                = [[ARMEMP_WEAPON]],
      badTargetCategory  = [[SWIM LAND SHIP HOVER]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER FIXEDWING GUNSHIP SUB]],
    },

  },


  weaponDefs       = {

    ARMEMP_WEAPON = {
      name                    = [[EMPMissile]],
      areaOfEffect            = 350,
      collideFriendly         = false,
      commandfire             = true,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default        = 36000,
        commanders     = 3600,
        empresistant75 = 9000,
        empresistant99 = 360,
        planes         = 36000,
      },

      edgeEffectiveness       = 1,
      energypershot           = 350,
      explosionGenerator      = [[custom:POWERPLANT_EXPLOSION]],
      fireStarter             = 0,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      metalpershot            = 350,
      model                   = [[wep_m_deathblow.s3o]],
      noautorange             = [[1]],
      noSelfDamage            = true,
      paralyzer               = true,
      paralyzeTime            = 45,
      propeller               = [[1]],
      range                   = 3500,
      reloadtime              = 1,
      renderType              = 1,
      selfprop                = true,
      shakeduration           = [[1.5]],
      shakemagnitude          = [[32]],
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOMED4]],
      soundStart              = [[OTAunit/MISICBM1]],
      startsmoke              = [[1]],
      stockpile               = true,
      stockpileTime           = 60,
      tolerance               = 4000,
      tracks                  = true,
      vlaunch                 = true,
      weaponAcceleration      = 180,
      weaponTimer             = 5,
      weaponType              = [[StarburstLauncher]],
      weaponVelocity          = 1200,
    },

  },


  featureDefs      = {

    DEAD  = {
      description      = [[Wreckage - Detonator]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 6000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 1000,
      object           = [[ARMEMP_DEAD]],
      reclaimable      = true,
      reclaimTime      = 1000,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Detonator]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 6000,
      energy           = 0,
      featureDead      = [[HEAP]],
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


    HEAP  = {
      description      = [[Debris - Detonator]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 6000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 500,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 500,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armemp = unitDef })
