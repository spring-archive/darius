unitDef = {
  unitname            = [[prometheus]],
  name                = [[Prometheus]],
  description         = [[Artillery]],
  acceleration        = 0.096,
  bmcode              = [[1]],
  brakeRate           = 0.238,
  buildCostEnergy     = 8000,
  buildCostMetal      = 8000,
  builder             = false,
  buildPic            = [[prometheus.png]],
  buildTime           = 8000,
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
  explodeAs           = [[CRAWL_BLASTSML]],
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[t3generic]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  immunetoparalyzer   = [[0]],
  maneuverleashlength = [[640]],
  mass                = 4000,
  maxDamage           = 11000,
  maxSlope            = 36,
  maxVelocity         = 1.787,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT4]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE SUB]],
  objectName          = [[prometheus.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[CRAWL_BLASTSML]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:ARMBRTHA_SHOCKWAVE]],
      [[custom:ARMBRTHA_SMOKE]],
      [[custom:ARMBRTHA_FLARE]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  turnRate            = 528,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[PLASMA]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    PLASMA = {
      name                    = [[Heavy Plasma Cannon]],
      accuracy                = 1800,
      areaOfEffect            = 192,
      cegTag                  = [[vulcanfx]],
      craterBoost             = 0.25,
      craterMult              = 0.5,

      damage                  = {
        default = 100,
        planes  = 100,
        subs    = 5,
      },

      energypershot           = 100,
      explosionGenerator      = [[custom:lrpc_expl]],
      holdtime                = [[1]],
      impulseBoost            = 0.5,
      impulseFactor           = 0.2,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 4200,
      reloadtime              = 0.1,
      renderType              = 4,
      soundHit                = [[lrpchit]],
      soundStart              = [[golgotha/big_begrtha_gun_fire]],
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 800,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Prometheus]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 22000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 4000,
      object           = [[CORKARG_DEAD]],
      reclaimable      = true,
      reclaimTime      = 4000,
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Prometheus]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 22000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 4000,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 4000,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Prometheus]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 22000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 2000,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 2000,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ prometheus = unitDef })
