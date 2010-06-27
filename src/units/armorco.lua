unitDef = {
  unitname              = [[armorco]],
  name                  = [[Detriment]],
  description           = [[Ultimate Assault Strider]],
  acceleration          = 0.108,
  bmcode                = [[1]],
  brakeRate             = 0.238,
  buildPic              = [[ARMORCO.png]],
  canAttack             = true,
  canGuard              = true,
  canMove               = true,
  canPatrol             = true,
  canstop               = [[1]],
  category              = [[LAND]],
  corpse                = [[DEAD]],

  customParams          = {
  },

  damageModifier        = 1,
  defaultmissiontype    = [[Standby]],
  explodeAs             = [[BIG_UNITEX]],
  footprintX            = 4,
  footprintZ            = 4,
  iconType              = [[krogoth]],
  idleAutoHeal          = 30,
  idleTime              = 0,
  immunetoparalyzer     = [[1]],
  maneuverleashlength   = [[640]],
  mass                  = 3100,
  maxDamage             = 5080,
  maxSlope              = 37,
  maxVelocity           = 0.8,
  maxWaterDepth         = 500,
  minCloakDistance      = 75,
  movementClass         = [[AKBOT6]],
  noAutoFire            = false,
  noChaseCategory       = [[TERRAFORM SATELLITE SUB]],
  objectName            = [[armorco]],
  seismicSignature      = 4,
  selfDestructAs        = [[NUCLEAR_MISSILE]],
  selfDestructCountdown = 10,
  shootme               = [[1]],
  side                  = [[ARM]],
  sightDistance         = 450,
  smoothAnim            = true,
  steeringmode          = [[2]],
  TEDClass              = [[KBOT]],
  turnRate              = 396,
  unitnumber            = [[263]],
  upright               = true,
  workerTime            = 0,

  weapons               = {

    {
      def                = [[GAUSS]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
  },


  weaponDefs            = {

    GAUSS         = {
      name                    = [[Gauss Battery]],
      alphaDecay              = 0.12,
      areaOfEffect            = 40,
      bouncerebound           = 0.15,
      bounceslip              = 1,
      burst                   = 3,
      burstrate               = 0.2,
      cegTag                  = [[gauss_tag_h]],
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 400,
      },

      explosionGenerator      = [[custom:gauss_hit_h]],
      groundbounce            = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      minbarrelangle          = [[-15]],
      noExplode               = true,
      noSelfDamage            = true,
      numbounce               = 40,
      range                   = 350,
      reloadtime              = 3,
      renderType              = 4,
      rgbColor                = [[0.5 1 1]],
      separation              = 0.5,
      size                    = 0.8,
      sizeDecay               = -0.1,
      soundHit                = [[armcomhit]],
      soundStart              = [[armcomgun]],
      sprayangle              = 800,
      stages                  = 32,
      startsmoke              = [[1]],
      tolerance               = 4096,
      turret                  = true,
      waterbounce             = 1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 900,
    },
  },


  featureDefs           = {

  
    DEAD  = {
      description      = [[Wreckage - Detriment]],
      blocking         = true,
      category         = [[arm_corpses]],
      damage           = 171600,
      featureDead      = [[DEAD2]],
      featurereclamate = [[smudge01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[60]],
      hitdensity       = [[150]],
      metal            = 14000,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 14000,
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Detriment]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 171600,
      featureDead      = [[HEAP]],
      featurereclamate = [[smudge01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[2]],
      hitdensity       = [[105]],
      metal            = 14000,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 14000,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Detriment]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 171600,
      featurereclamate = [[smudge01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[2]],
      hitdensity       = [[105]],
      metal            = 7000,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 7000,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armorco = unitDef })
