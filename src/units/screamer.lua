unitDef = {
  unitname            = [[screamer]],
  name                = [[Screamer]],
  description         = [[Long-Range AA Missile Tower]],
  acceleration        = 0,
  activateWhenBuilt   = true,
  bmcode              = [[0]],
  brakeRate           = 0,
  buildCostEnergy     = 2400,
  buildCostMetal      = 2400,
  builder             = false,
  buildPic            = [[SCREAMER.png]],
  buildTime           = 2400,
  canAttack           = true,
  canstop             = [[1]],
  category            = [[SINK UNARMED]],
  collisionVolumeTest = 1,
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Tourelle Lance Missile Anti-Air Longue Portée]],
    helptext       = [[The Screamer is an extremely long-ranging first strike anti-air weapon that sends a clear message to enemy aircraft - can't go here, sonny. Each shot must be stockpiled at the cost of resources, but this is well worth the price, for a quick salvo of missiles will wipe out almost any air attack without fuss.]],
    helptext_fr    = [[Leest un lance missile trcs longue portée. Ses missiles r tete chercheuse ultra rapides peuvent abattre r peu prcs nimporte quel avion d'un seul tir. L'ultime défense Anti-Air, de tous points de vue, met necessite de programmer la production de missiles Sol/Air dans son interface avant d'etre apte r faire feu.]],
  },

  defaultmissiontype  = [[GUARD_NOMOVE]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[defense]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  mass                = 1200,
  maxDamage           = 1570,
  maxSlope            = 18,
  maxVelocity         = 0,
  maxWaterDepth       = 0,
  minCloakDistance    = 150,
  noAutoFire          = false,
  objectName          = [[screamer]],
  onoffable           = false,
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
      description      = [[Wreckage - Screamer]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 3140,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 1200,
      object           = [[SCREAMER_DEAD]],
      reclaimable      = true,
      reclaimTime      = 1200,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Screamer]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3140,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 1200,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 1200,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Screamer]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3140,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 600,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 600,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ screamer = unitDef })
