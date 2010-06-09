unitDef = {
  unitname           = [[mahlazer]],
  name               = [[Starlight]],
  description        = [[Planetary Energy Chisel]],
  acceleration       = 0,
  activateWhenBuilt  = true,
  antiweapons        = [[1]],
  bmcode             = [[0]],
  brakeRate          = 0,
  buildAngle         = 32700,
  buildCostEnergy    = 35000,
  buildCostMetal     = 35000,
  builder            = false,
  buildPic           = [[mahlazer.png]],
  buildTime          = 35000,
  canAttack          = true,
  canstop            = [[1]],
  category           = [[SINK]],
  corpse             = [[DEAD]],

  customParams       = {
    description_fr = [[Lazer ? Charge ?liptique]],
    helptext       = [[This large scale tool is used to shape terrain for Nova's terraforming projects. Also useful as a cleanser of obstacles such as pesky enemy units and bases.]],
    helptext_fr    = [[Le MAH Lazer est un b?timent abritant un puissant g?n?rateur de faisceau laser ?liptique, dont l'impact est param?trable. Sa puissance est telle qu'il coupe tout sur son passage, y compris les alli?s. Pensez ? pr?voir un espace d?gag? autour de lui pour ?viter que le laser ne coupe votre base en deux en d?marrant.]],
  },

  defaultmissiontype = [[GUARD_NOMOVE]],
  energyUse          = 300,
  explodeAs          = [[ATOMIC_BLAST]],
  footprintX         = 8,
  footprintZ         = 8,
  iconType           = [[mahlazer]],
  idleAutoHeal       = 5,
  idleTime           = 1800,
  mass               = 17500,
  maxDamage          = 12000,
  maxSlope           = 18,
  maxVelocity        = 0,
  maxWaterDepth      = 0,
  minCloakDistance   = 150,
  noChaseCategory    = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName         = [[lazer.3do]],
  onoffable          = true,
  seismicSignature   = 4,
  selfDestructAs     = [[ATOMIC_BLAST]],

  sfxtypes           = {

    explosiongenerators = {
      [[custom:IMMA_LAUNCHIN_MAH_LAZER]],
    },

  },

  side               = [[ARM]],
  sightDistance      = 660,
  smoothAnim         = true,
  TEDClass           = [[FORT]],
  turnRate           = 0,
  workerTime         = 0,
  yardMap            = [[oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo]],

  weapons            = {

    {
      def                = [[LAZER]],
      badTargetCategory  = [[FIXEDWING GUNSHIP SATELLITE]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER FIXEDWING GUNSHIP SATELLITE]],
    },


    {
      def                = [[TARGETER]],
      badTargetCategory  = [[FIXEDWING GUNSHIP SATELLITE]],
      onlyTargetCategory = [[SWIM LAND SHIP SINK FLOAT FIXEDWING GUNSHIP SATELLITE HOVER]],
    },

  },


  weaponDefs         = {

    LAZER    = {
      name                    = [[Energy Chisel]],
      accuracy                = 0,
      alwaysVisible           = 0,
      areaOfEffect            = 140,
      avoidFeature            = false,
      avoidNeutral            = false,
      beamlaser               = 1,
      beamTime                = 1,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,
      cylinderTargetting      = 8192,

      damage                  = {
        default = 3000,
        planes  = 3000,
        subs    = 150,
      },

      energypershot           = 10000,
      explosionGenerator      = [[custom:megapartgun]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 10,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 9000,
      reloadtime              = 20,
      renderType              = 0,
      rgbColor                = [[0.25 0 1]],
      soundHit                = [[OTAunit/XPLOLRG1]],
      soundStart              = [[OTAunit/LASRMAS1]],
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 48,
      tolerance               = 1000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 1400,
    },


    TARGETER = {
      name                    = [[MAH TARGETIN LAZER]],
      alwaysVisible           = 18,
      areaOfEffect            = 32,
      avoidFeature            = false,
      avoidNeutral            = false,
      beamlaser               = 1,
      beamTime                = 0.001,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,
      cylinderTargetting      = 8192,

      damage                  = {
        default = 100,
        planes  = 100,
        subs    = 5,
      },

      energypershot           = 0,
      explosionGenerator      = [[custom:FLASHLAZER]],
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 12,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 9000,
      reloadtime              = 7,
      renderType              = 0,
      rgbColor                = [[0.25 0 1]],
      soundHit                = [[OTAunit/BURN02]],
      soundStart              = [[OTAunit/build2]],
      soundTrigger            = true,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 16,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 1400,
    },

  },


  featureDefs        = {

    DEAD  = {
      description      = [[Wreckage - Starlight]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 24000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 17500,
      object           = [[ARMBRTHA_DEAD]],
      reclaimable      = true,
      reclaimTime      = 17500,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Starlight]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 24000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 17500,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 17500,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Starlight]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 24000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 8750,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 8750,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ mahlazer = unitDef })
