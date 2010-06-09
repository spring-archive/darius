unitDef = {
  unitname            = [[nsaclash]],
  name                = [[Halberd]],
  description         = [[Assault Hovertank]],
  acceleration        = 0.072,
  bmcode              = [[1]],
  brakeRate           = 0.075,
  buildCostEnergy     = 700,
  buildCostMetal      = 700,
  builder             = false,
  buildPic            = [[NSACLASH.png]],
  buildTime           = 700,
  canAttack           = true,
  canGuard            = true,
  canHover            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[HOVER]],
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Hovecraft d'Assaut Lourd]],
    helptext       = [[The Halberd is a heavy-duty assault hovertank, the Can of the sea. It is slow and short-ranged, making it easy prey for skirmishers - however, anything it gets close to is expected to die very quickly.]],
    helptext_fr    = [[Équivalent des mers du Can, le Halberd est etrememnt résistant et posscde une portée de tir trcs réduite.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[hoverassault]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 350,
  maxDamage           = 3000,
  maxSlope            = 36,
  maxVelocity         = 1.68,
  minCloakDistance    = 75,
  movementClass       = [[HOVER3]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[nsaclash.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:HEAVYHOVERS_ON_GROUND]],
      [[custom:BEAMWEAPON_MUZZLE_ORANGE]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 420,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  turninplace         = 0,
  turnRate            = 410,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[SABOT]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    SABOT = {
      name                    = [[Sabot]],
      areaOfEffect            = 32,
      burnblow                = true,
      cegTag                  = [[KBOTROCKETTRAIL]],
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 280,
        planes  = 280,
        subs    = 20,
      },

      explosionGenerator      = [[custom:FLASH2nd]],
      fireStarter             = 70,
      flightTime              = 2,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      model                   = [[wep_m_maverick.s3o]],
      noSelfDamage            = true,
      range                   = 360,
      reloadtime              = 2,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = false,
      soundHit                = [[SabotHit]],
      soundStart              = [[SabotFire]],
      startsmoke              = [[1]],
      startVelocity           = 550,
      targetMoveError         = 0.2,
      tolerance               = 8000,
      tracks                  = false,
      turnRate                = 4000,
      turret                  = true,
      weaponAcceleration      = 300,
      weaponTimer             = 0.1,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 680,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Halberd]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 6000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 350,
      object           = [[NSACLASH_DEAD]],
      reclaimable      = true,
      reclaimTime      = 350,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Halberd]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 6000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      hitdensity       = [[100]],
      metal            = 350,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 350,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Halberd]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 6000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      hitdensity       = [[100]],
      metal            = 175,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 175,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ nsaclash = unitDef })
