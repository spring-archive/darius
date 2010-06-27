unitDef = {
  unitname            = [[armsptk]],
  name                = [[Recluse]],
  description         = [[Skirmisher Spider]],
  acceleration        = 0.18,
  bmcode              = [[1]],
  brakeRate           = 0.188,
  buildPic            = [[ARMSPTK.png]],
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[spiderskirm]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 150,
  maxDamage           = 800,
  maxSlope            = 72,
  maxVelocity         = 1.9,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[TKBOT3]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING GUNSHIP SATELLITE SUB]],
  objectName          = [[ARMSPTK]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],
  side                = [[ARM]],
  sightDistance       = 500,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  turninplace         = 0,
  turnRate            = 1122,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[ADV_ROCKET]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[LAND SINK SHIP SWIM FLOAT HOVER]],
    },

  },


  weaponDefs          = {

    ADV_ROCKET = {
      name                    = [[Rocket Volley]],
      areaOfEffect            = 48,
      burst                   = 3,
      burstrate               = 0.3,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 125,
      },

      edgeEffectiveness       = 0.5,
      fireStarter             = 70,
      flightTime              = 4,
      guided                  = [[1]],
      impulseBoost            = 0,
      impulseFactor           = 0.1292,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      model                   = [[wep_m_ajax.s3o]],
      noSelfDamage            = true,
      range                   = 400,
      reloadtime              = 4,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOSML1]],
      soundStart              = [[OTAunit/ROCKHVY3]],
      soundTrigger            = true,
      startsmoke              = [[1]],
      startVelocity           = 200,
      trajectoryHeight        = 1.5,
      turnRate                = 4000,
      turret                  = true,
      weaponAcceleration      = 150,
      weaponTimer             = 6,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 550,
      wobble                  = 9000,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Recluse]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1200,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 150,
      object           = [[ARMSPTK_DEAD]],
      reclaimable      = true,
      reclaimTime      = 150,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Recluse]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1200,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 150,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 150,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Recluse]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1200,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 75,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 75,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armsptk = unitDef })
