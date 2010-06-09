unitDef = {
  unitname           = [[corbhmth]],
  name               = [[Behemoth]],
  description        = [[Plasma Battery]],
  acceleration       = 0,
  activateWhenBuilt  = true,
  bmcode             = [[0]],
  brakeRate          = 0,
  buildAngle         = 8192,
  buildCostEnergy    = 3500,
  buildCostMetal     = 3500,
  builder            = false,
  buildPic           = [[CORBHMTH.png]],
  buildTime          = 3500,
  canAttack          = true,
  canstop            = [[1]],
  category           = [[SINK]],
  corpse             = [[DEAD]],
  defaultmissiontype = [[GUARD_NOMOVE]],
  explodeAs          = [[LARGE_BUILDINGEX]],
  footprintX         = 5,
  footprintZ         = 5,
  iconType           = [[staticarty]],
  idleAutoHeal       = 5,
  idleTime           = 1800,
  mass               = 1750,
  maxDamage          = 3500,
  maxSlope           = 255,
  maxVelocity        = 0,
  maxWaterDepth      = 0,
  minCloakDistance   = 150,
  noAutoFire         = false,
  noChaseCategory    = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName         = [[CORBHMTH]],
  onoffable          = false,
  seismicSignature   = 4,
  selfDestructAs     = [[LARGE_BUILDINGEX]],
  side               = [[CORE]],
  sightDistance      = 660,
  smoothAnim         = true,
  TEDClass           = [[FORT]],
  turnRate           = 0,
  workerTime         = 0,
  yardMap            = [[ooooo ooooo ooooo ooooo ooooo]],

  weapons            = {

    {
      def                = [[PLASMA]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs         = {

    PLASMA = {
      name                    = [[Long-Range Plasma Battery]],
      areaOfEffect            = 192,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 300,
        planes  = 300,
        subs    = 15,
      },

      edgeEffectiveness       = 0.7,
      explosionGenerator      = [[custom:FLASHSMALLBUILDINGEX]],
      fireStarter             = 99,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      projectiles             = 3,
      range                   = 1650,
      reloadtime              = 6,
      renderType              = 4,
      soundHit                = [[OTAunit/XPLOLRG3]],
      soundStart              = [[OTAunit/XPLONUK3]],
      sprayangle              = 1024,
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 620,
    },

  },


  featureDefs        = {

    DEAD  = {
      description      = [[Wreckage - Behemoth]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 7000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 5,
      footprintZ       = 5,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 1750,
      object           = [[CORBHMTH_DEAD]],
      reclaimable      = true,
      reclaimTime      = 1750,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Behemoth]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 7000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 5,
      footprintZ       = 5,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 1750,
      object           = [[debris4x4b.s3o]],
      reclaimable      = true,
      reclaimTime      = 1750,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Behemoth]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 7000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 5,
      footprintZ       = 5,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 875,
      object           = [[debris4x4b.s3o]],
      reclaimable      = true,
      reclaimTime      = 875,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corbhmth = unitDef })
