unitDef = {
  unitname            = [[corrl]],
  name                = [[Pulverizer]],
  description         = [[Light Missile Tower]],
  acceleration        = 0,
  bmcode              = [[0]],
  brakeRate           = 0,
  buildCostEnergy     = 80,
  buildCostMetal      = 80,
  builder             = false,
  buildPic            = [[CORRL.png]],
  buildTime           = 80,
  canAttack           = true,
  canstop             = [[1]],
  category            = [[FLOAT]],
  collisionVolumeTest = 1,
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Tourelle Lance-Missile Légcre]],
    helptext       = [[The Pulverizer is a light multi-purpose missile tower. It is good for sniping units from a distance, providing some degree of anti-air protection, and skirmishing enemy LLTs from outside their range. However, it breaks when you sneeze on it.]],
    helptext_fr    = [[Le Pullverizer est une tourelle légcre mais r plus longue portée que la LLT, il peut de plus attaquer les unité aeriennes avec précision grâce r ses roquettes r tete chercheuse. C'est la meilleure parade contre les bombes rampantes. Son blindage et son temps de rechargement la rendent rapidement obsolcte.]],
  },

  defaultmissiontype  = [[GUARD_NOMOVE]],
  explodeAs           = [[BIG_UNITEX]],
  floater             = true,
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[defenseskirm]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  levelGround         = false,
  mass                = 40,
  maxDamage           = 300,
  maxSlope            = 18,
  maxVelocity         = 0,
  minCloakDistance    = 150,
  noAutoFire          = false,
  noChaseCategory     = [[FIXEDWING LAND SINK SHIP SATELLITE SWIM GUNSHIP FLOAT SUB HOVER]],
  objectName          = [[lmt2.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:PULVMUZZLE]],
      [[custom:PULVBACK]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  TEDClass            = [[METAL]],
  turnRate            = 0,
  workerTime          = 0,
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
      def                = [[ARMRL_MISSILE]],
      badTargetCategory  = [[HOVER SWIM LAND SINK FLOAT SHIP]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    ARMRL_MISSILE = {
      name                    = [[Homing Missiles]],
      areaOfEffect            = 8,
      craterBoost             = 1,
      craterMult              = 2,
      cylinderTargetting      = 1,

      damage                  = {
        default = 110,
        planes  = [[110]],
        subs    = 7.5,
      },

      explosionGenerator      = [[custom:FLASH2]],
      fireStarter             = 70,
      flightTime              = 4,
      guidance                = true,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[hobbes.s3o]],
      noSelfDamage            = true,
      range                   = 610,
      reloadtime              = 1.2,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[weapons/xplomed2]],
      soundStart              = [[weapons/rocket_heavy]],
      startsmoke              = [[1]],
      startVelocity           = 500,
      tolerance               = 10000,
      tracks                  = true,
      turnRate                = 60000,
      turret                  = true,
      weaponAcceleration      = 300,
      weaponTimer             = 5,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 750,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Pulverizer]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 600,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 40,
      object           = [[Pulverizer_d.s3o]],
      reclaimable      = true,
      reclaimTime      = 40,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Pulverizer]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 600,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 40,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 40,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Pulverizer]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 600,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 20,
      object           = [[debris3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 20,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corrl = unitDef })
