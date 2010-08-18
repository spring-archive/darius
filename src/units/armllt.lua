unitDef = {
  unitname               = [[armllt]],
  name                   = [[Ray]],
  description            = [[Light Laser Tower]],
  acceleration           = 0,
  bmcode                 = [[0]],
  brakeRate              = 0,
  buildAngle             = 32768,
  buildCostEnergy        = 70,
  buildCostMetal         = 70,
  builder                = false,
  buildPic               = [[armllt.png]],
  buildTime              = 70,
  canAttack              = true,
  canstop                = [[1]],
  category               = [[SINK]],
  collisionVolumeOffsets = [[0 -23 0]],
  collisionVolumeScales  = [[32 78 32]],
  collisionVolumeTest    = 1,
  collisionVolumeType    = [[CylY]],
  corpse                 = [[DEAD]],

  customParams           = {
    description_fr = [[Light Laser Tower ou Tourelle Laser Légcre]],
    description_pl = [[Lekka Wie?yczka Laserowa]],
    helptext       = [[The Ray is a basic turret. A versatile, solid anti-ground weapon, it does well versus scouts as well as being able to take on one or two raiders. Falls relatively easily to skirmishers, artillery or assault units unless supported.]],
    helptext_fr    = [[La Tourelle Laser Légcre aussi appellée LLT est une tourelle basique, peu solide mais utile pour se protéger des éclaireurs ou des pilleurs. Des tirailleurs ou de l'artillerie en viendrons rapidement r bout.]],
    helptext_pl    = [[Ray jest podstawow? wie?yczk?. Jest skuteczny przeciwko zwiadowcom i ma?ym grupom naje?d?ców. ?atwo pada ofiar? artylerii i jednostek szturmowych.]],
  },

  explodeAs              = [[SMALL_BUILDINGEX]],
  footprintX             = 2,
  footprintZ             = 2,
  iconType               = [[defense]],
  idleAutoHeal           = 5,
  idleTime               = 1800,
  levelGround            = false,
  mass                   = 35,
  maxDamage              = 560,
  maxSlope               = 36,
  maxVelocity            = 0,
  maxWaterDepth          = 0,
  minCloakDistance       = 150,
  modelCenterOffset      = [[0 25 0]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName             = [[novallt]],
  seismicSignature       = 4,
  selfDestructAs         = [[SMALL_BUILDINGEX]],
  side                   = [[HUMANS]],
  sightDistance          = 473,
  smoothAnim             = true,
  TEDClass               = [[FORT]],
  turnRate               = 0,
  workerTime             = 0,
  yardMap                = [[oooo]],
  
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
  
  weapons                = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs             = {

    LASER = {
      name                    = [[Laserbeam]],
      areaOfEffect            = 8,
      beamlaser               = 1,
      beamTime                = 0.1,
      coreThickness           = 0.4,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 9,
        planes  = 9,
      },

      energypershot           = 0,
      explosionGenerator      = [[custom:FLASH1blue]],
      fireStarter             = 30,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 2,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 460,
      reloadtime              = 0.1,
      renderType              = 0,
      rgbColor                = [[0 1 1]],
      soundHit                = [[weapons/burning]],
      soundStart              = [[weapons/build2]],
      soundTrigger            = true,
      sweepfire               = false,
      targetMoveError         = 0.1,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 2,
      tolerance               = 5000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 500,
    },

  },


  featureDefs            = {

    DEAD  = {
      description      = [[Wreckage - Ray]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1120,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 35,
      object           = [[NOVALLT_DEAD]],
      reclaimable      = true,
      reclaimTime      = 35,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Ray]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1120,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 35,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 35,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Ray]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1120,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 17.5,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 17.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armllt = unitDef })
