unitDef = {
  unitname            = [[corvamp]],
  name                = [[Vamp]],
  description         = [[Air Superiority Stealth Fighter]],
  amphibious          = true,
  buildCostEnergy     = 300,
  buildCostMetal      = 300,
  buildPic            = [[CORVAMP.png]],
  buildTime           = 300,
  canAttack           = true,
  canDropFlare        = false,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  canSubmerge         = false,
  category            = [[FIXEDWING]],
  collide             = false,
  corpse              = [[DEAD]],
  cruiseAlt           = 220,

  customParams        = {
    description_bp = [[Caça de superioridade aérea invisível a radar]],
    description_fr = [[Chasseur Anti-Air Sup?rieur]],
    helptext_bp    = [[Vamp é um caça poderoso contra unidades aéreas mas incapaz de atacar unidades terrestres.]],
    helptext_fr    = [[le Vamp combine, vitesse, invisibilit? au radar, et puissante force offensive Air/Air, afin d'abatre les aeronefs ennemis. Sans d?fense contre les attaques Sol/Air.]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 2,
  footprintZ          = 2,
  frontToSpeed        = 0.5,
  iconType            = [[stealthfighter]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[1280]],
  mass                = 150,
  maxAcc              = 0.5,
  maxDamage           = 1000,
  maxVelocity         = 11,
  minCloakDistance    = 75,
  noChaseCategory     = [[TERRAFORM LAND SINK SHIP SWIM FLOAT SUB HOVER]],
  objectName          = [[corvamp]],
  seismicSignature    = 0,
  selfDestructAs      = [[GUNSHIPEX]],
  side                = [[CORE]],
  sightDistance       = 790,
  smoothAnim          = true,
  speedToFront        = 0.5,
  stealth             = true,
  TEDClass            = [[VTOL]],

  weapons             = {

    {
      def                = [[CORVTOL_ADVMISSILE]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    CORVTOL_ADVMISSILE = {
      name                    = [[Guided Missiles]],
      areaOfEffect            = 24,
      avoidFriendly           = false,
      canattackground         = false,
      canAttackGround         = 0,
      cegTag                  = [[MISSILE_TAG_WHITE_10]],
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,
      cylinderTargetting      = 1,

      damage                  = {
        default = 15,
        planes  = 150,
        subs    = 7.5,
      },

      explosionGenerator      = [[custom:MISSILE_HIT_PIKES_160]],
      fireStarter             = 70,
      flightTime              = 4,
      guidance                = true,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[wep_m_needle.s3o]],
      noSelfDamage            = true,
      range                   = 750,
      reloadtime              = 1.5,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOSML2]],
      soundStart              = [[OTAunit/ROCKLIT3]],
      startsmoke              = [[1]],
      startVelocity           = 450,
      texture2                = [[none]],
      tolerance               = 40000,
      tracks                  = true,
      turnRate                = 50000,
      weaponAcceleration      = 450,
      weaponTimer             = 3.5,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 850,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Vamp]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 150,
      object           = [[corvamp_dead]],
      reclaimable      = true,
      reclaimTime      = 150,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Vamp]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 150,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 150,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Vamp]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 75,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 75,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corvamp = unitDef })
