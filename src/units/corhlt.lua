unitDef = {
  unitname               = [[corhlt]],
  name                   = [[Stinger]],
  description            = [[High-Energy Laser Tower]],
  acceleration           = 0,
  bmcode                 = [[0]],
  brakeRate              = 0,
  buildAngle             = 4096,
  buildCostEnergy        = 450,
  buildCostMetal         = 450,
  builder                = false,
  buildPic               = [[CORHLT.png]],
  buildTime              = 450,
  canAttack              = true,
  canstop                = [[1]],
  category               = [[FLOAT]],
  collisionVolumeOffsets = [[0 -38 0]],
  collisionVolumeScales  = [[32 118 32]],
  collisionVolumeTest    = 1,
  collisionVolumeType    = [[CylY]],
  corpse                 = [[DEAD]],

  customParams           = {
    description_fr = [[Tourelle Laser Moyenne HLT]],
    helptext       = [[The Stinger is a medium laser turret. Its three rotating laser guns can kill almost any small unit, but its low rate of fire makes it vulnerable to swarms when unassisted.]],
    helptext_fr    = [[Le Gaat Gun est compos? de trois canons lasers rotatifs lourd. Oblig?s de se refroidir apr?s chaque tir, il n'en d?livrent pas moins une forte puissance de feu instann?e. Tr?s utile sur des grosses cibles, elle aura besoin d'assistance en cas de nombreux ennemis.]],
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
  mass                   = 225,
  maxDamage              = 2475,
  maxSlope               = 36,
  maxVelocity            = 0,
  minCloakDistance       = 150,
  modelCenterOffset      = [[0 55 0]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName             = [[hlt.s3o]],
  seismicSignature       = 4,
  selfDestructAs         = [[MEDIUM_BUILDINGEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:HLTRADIATE0]],
      [[custom:BEAMWEAPON_MUZZLE_YELLOW]],
    },

  },

  side                   = [[CORE]],
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
      name                    = [[High-Energy Laser Blaster]],
      areaOfEffect            = 14,
      beamWeapon              = true,
      burst                   = 3,
      burstrate               = 0.07,
      canattackground         = true,
      cegTag                  = [[yellowlaser_hlt]],
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 270,
        planes  = 270,
      },

      duration                = 0.05,
      energypershot           = 0,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_YELLOW]],
      fireStarter             = 90,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      lodDistance             = 10000,
      noSelfDamage            = true,
      range                   = 620,
      reloadtime              = 4.5,
      renderType              = 0,
      rgbColor                = [[1 1 0]],
      soundHit                = [[weapons/laserhit]],
      soundStart              = [[weapons/laser]],
      sweepfire               = false,
      targetMoveError         = 0.2,
      thickness               = 8.81050509335305,
      tolerance               = 500,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 2480,
    },

  },


  featureDefs            = {

    DEAD  = {
      description      = [[Wreckage - Stinger]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 4950,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 225,
      object           = [[corhlt_d.s3o]],
      reclaimable      = true,
      reclaimTime      = 225,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Stinger]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4950,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 225,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 225,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Stinger]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4950,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 112.5,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 112.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corhlt = unitDef })
