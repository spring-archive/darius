unitDef = {
  unitname            = [[armpb]],
  name                = [[Pit Bull]],
  description         = [[Ambush Gauss Cannon]],
  acceleration        = 0,
  bmcode              = [[0]],
  brakeRate           = 0,
  buildCostEnergy     = 500,
  buildCostMetal      = 500,
  builder             = false,
  buildPic            = [[ARMPB.png]],
  buildTime           = 500,
  canAttack           = true,
  canstop             = [[1]],
  category            = [[SINK]],
  collisionVolumeTest = 1,
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Canon Gauss Ambusqué]],
    helptext       = [[The Pit Bull is a compact, resilent turret with a rapid-fire gauss gun that will make quick work of anyone who blunders into it. When popped down, it is very difficult to destroy, making it a good choice when the enemy is using artillery.]],
    helptext_fr    = [[Le Pit Bull s'enterre et profite de son camouflage radar et optique pour attendre la bonne occasion. L'ennemi de le verra pas avant qu'il ne soit trop tard. Son canon Gauss r haute cadence fait des ravages sur tous tupes d'unités, mais il ne faut pas éspcrer percer un blindage lourd du premier coup.]],
  },

  damageModifier      = 0.2,
  defaultmissiontype  = [[GUARD_NOMOVE]],
  digger              = [[1]],
  explodeAs           = [[SMALL_BUILDINGEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[defense]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  levelGround         = false,
  mass                = 250,
  maxDamage           = 3300,
  maxSlope            = 18,
  maxVelocity         = 0,
  maxWaterDepth       = 0,
  noAutoFire          = false,
  noChaseCategory     = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName          = [[armpb]],
  seismicSignature    = 16,
  selfDestructAs      = [[SMALL_BUILDINGEX]],
  side                = [[HUMANS]],
  sightDistance       = 660,
  smoothAnim          = true,
  stealth             = true,
  TEDClass            = [[FORT]],
  turnRate            = 0,
  yardMap             = [[ooooooooo]],
  
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
  
  weapons             = {

    {
      def                = [[GAUSS]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    GAUSS = {
      name                    = [[Gauss Cannon]],
      alphaDecay              = 0.12,
      areaOfEffect            = 16,
      bouncerebound           = 0.15,
      bounceslip              = 1,
      burst                   = 1,
      cegTag                  = [[gauss_tag_m]],
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 150,
        planes  = 150,
      },

      explosionGenerator      = [[custom:gauss_hit_m]],
      groundbounce            = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 0,
      lineOfSight             = true,
      noExplode               = true,
      noSelfDamage            = true,
      numbounce               = 40,
      range                   = 520,
      reloadtime              = 1.9,
      renderType              = 4,
      rgbColor                = [[0.5 1 1]],
      separation              = 0.5,
      size                    = 0.8,
      sizeDecay               = -0.1,
      soundHit                = [[weapons/xplomed2]],
      soundStart              = [[weapons/armcomgun]],
      sprayangle              = 800,
      stages                  = 32,
      startsmoke              = [[0]],
      tolerance               = 8000,
      turret                  = true,
      waterbounce             = 1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 900,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Pit Bull]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 6600,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[15]],
      hitdensity       = [[100]],
      metal            = 250,
      object           = [[ARMPB_DEAD]],
      reclaimable      = true,
      reclaimTime      = 250,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Pit Bull]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 6600,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 250,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 250,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Pit Bull]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 6600,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 125,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armpb = unitDef })
