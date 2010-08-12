unitDef = {
  unitname            = [[mercury]],
  name                = [[Mercury]],
  description         = [[Long-Range AA Missile Tower]],
  acceleration        = 0,
  bmcode              = [[0]],
  brakeRate           = 0,
  buildCostEnergy     = 2100,
  buildCostMetal      = 2100,
  builder             = false,
  buildPic            = [[MERCURY.png]],
  buildTime           = 2100,
  canAttack           = true,
  canstop             = [[1]],
  category            = [[SINK UNARMED]],
  collisionVolumeTest = 1,
  corpse              = [[DEAD]],

  customParams        = {
    helptext = [[The heaviest anti-air weapon available, the Mercury can take down enemy aircraft in a wide radius with its long-range, ultra-high lethality missiles. Such its its power that each missile must be stockpiled before use, although once they are accumulated they can be launched in quick succession.]],
  },

  defaultmissiontype  = [[GUARD_NOMOVE]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[defense]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  mass                = 1050,
  maxDamage           = 1500,
  maxSlope            = 18,
  maxVelocity         = 0,
  maxWaterDepth       = 0,
  minCloakDistance    = 150,
  noAutoFire          = false,
  objectName          = [[mercury.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],
  side                = [[HUMANS]],
  sightDistance       = 660,
  smoothAnim          = true,
  TEDClass            = [[FORT]],
  turnRate            = 0,
  workerTime          = 0,
  yardMap             = [[oooooooooooooooo]],
  
  sounds = {
    underattack = {
      "voices/unit_under_attack"
    },
    ok = {
      "voices/unit_selected"
    },
    select = {
      "voices/unit_selected"
    }
  },
  
  weapons             = {

    {
      def                = [[ADVSAM]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP SATELLITE]],
    },

  },


  weaponDefs          = {

    ADVSAM = {
      name                    = [[Advanced AA Missile]],
      areaOfEffect            = 240,
      canattackground         = false,
      canAttackGround         = 0,
      cegTag                  = [[MISSILE_TAG_WHITE_40]],
      craterBoost             = 1,
      craterMult              = 2,
      cylinderTargetting      = 1,

      damage                  = {
        default    = 175,
        planes     = [[1750]],
      },

      edgeEffectiveness       = 0.25,
      energypershot           = 0,
      explosionGenerator      = [[custom:MISSILE_HIT_SPHERE_120]],
      fireStarter             = 90,
      flightTime              = 4,
      groundbounce            = 1,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[wep_m_avalanche.s3o]],
      noSelfDamage            = true,
      range                   = 2400,
      reloadtime              = 1.8,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0]],
      smokeTrail              = true,
      soundHit                = [[weapons/impact]],
      soundStart              = [[weapons/rocket]],
      startsmoke              = [[1]],
      startVelocity           = 1000,
      stockpile               = true,
      stockpileTime           = 20,
      texture2                = [[none]],
      tolerance               = 10000,
      tracks                  = true,
      trajectoryHeight        = 0.55,
      turnRate                = 60000,
      turret                  = true,
      weaponAcceleration      = 600,
      weaponTimer             = 3,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 1600,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Mercury]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 3000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 1050,
      object           = [[MERCURY_DEAD]],
      reclaimable      = true,
      reclaimTime      = 1050,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Mercury]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      hitdensity       = [[100]],
      metal            = 1050,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 1050,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Mercury]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      hitdensity       = [[100]],
      metal            = 525,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 525,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ mercury = unitDef })
