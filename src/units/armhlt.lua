unitDef = {
  unitname               = [[armhlt]],
  name                   = [[Sentinel]],
  description            = [[High-Energy Laser Tower]],
  acceleration           = 0,
  bmcode                 = [[0]],
  brakeRate              = 0,
  buildAngle             = 8192,
  buildCostEnergy        = 400,
  buildCostMetal         = 400,
  builder                = false,
  buildPic               = [[armhlt.png]],
  buildTime              = 400,
  canAttack              = true,
  canstop                = [[1]],
  category               = [[FLOAT]],
  collisionVolumeOffsets = [[0 -44 0]],
  collisionVolumeScales  = [[32 114 32]],
  collisionVolumeTest    = 1,
  collisionVolumeType    = [[CylY]],
  corpse                 = [[DEAD]],

  customParams           = {
    description_fr = [[Tourelle Laser Moyenne HLT]],
    description_pl = [[Ci?ka Wie?a Laserowa]],
    helptext       = [[The Sentinel is a medium-range laser turret. Its laser beam can badly hurt or outright kill almost any small unit, but its low rate of fire makes it vulnerable to swarms when unassisted. Falls relatively easily to artillery.]],
    helptext_fr    = [[Le Sentinel est une tourelle laser moyenne. Son rayon laser continu peut tr?s s?v?rement endomager une unit? d'assaut et se d?barrasser de nimporte quelle unit? l?g?re. Sa port?e est plus grande que celle des LLT, ce qui en fait un parfait compl?ment.]],
    helptext_pl    = [[Sentiel to wie?a laserowa ?redniego zasi?gu. Jego promie? laserowy mo?e ci?ko zrani? lub od razu zabi? ka?d? ma?? jednostk?, ale jego d?ugi czas prze?adowania czyni go wra?liwym na ataki du?ych grup wrogich jednostek. Jest on tak?e do?? wra?liwy na ataki artylerii.]],
  },

  defaultmissiontype     = [[GUARD_NOMOVE]],
  explodeAs              = [[MEDIUM_BUILDINGEX]],
  floater                = true,
  footprintX             = 2,
  footprintZ             = 2,
  iconType               = [[defense]],
  idleAutoHeal           = 5,
  idleTime               = 1800,
  levelGround            = false,
  mass                   = 200,
  maxDamage              = 2325,
  maxSlope               = 36,
  maxVelocity            = 0,
  minCloakDistance       = 150,
  modelCenterOffset      = [[0 45 0]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName             = [[novahlt]],
  seismicSignature       = 4,
  selfDestructAs         = [[MEDIUM_BUILDINGEX]],
  side                   = [[HUMANS]],
  sightDistance          = 660,
  smoothAnim             = true,
  sweepfire              = [[1]],
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
      name                    = [[High-Energy Laserbeam]],
      areaOfEffect            = 14,
      beamlaser               = 1,
      beamTime                = 0.8,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 810,
        planes  = 810,
      },

      energypershot           = 0,
      explosionGenerator      = [[custom:FLASH1blue]],
      fireStarter             = 90,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 10.4,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 620,
      reloadtime              = 4.5,
      renderType              = 0,
      rgbColor                = [[0 0 1]],
      scrollSpeed             = 5,
      soundHit                = [[weapons/laser_hit2]],
      soundStart              = [[weapons/lasermas]],
      sweepfire               = false,
      targetMoveError         = 0.2,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 10.4024486300101,
      tileLength              = 300,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 2250,
    },

  },


  featureDefs            = {

    DEAD  = {
      description      = [[Wreckage - Sentinel]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 4650,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 200,
      object           = [[NOVAHLT_DEAD]],
      reclaimable      = true,
      reclaimTime      = 200,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Sentinel]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4650,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 200,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 200,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Sentinel]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4650,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 100,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 100,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armhlt = unitDef })
