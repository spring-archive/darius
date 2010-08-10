unitDef = {
  unitname            = [[armcir]],
  name                = [[Chainsaw]],
  description         = [[Medium-Range AA Missile Battery]],
  acceleration        = 0,
  bmcode              = [[0]],
  brakeRate           = 0,
  buildAngle          = 65536,
  buildCostEnergy     = 800,
  buildCostMetal      = 800,
  builder             = false,
  buildPic            = [[ARMCIR.png]],
  buildTime           = 800,
  canAttack           = true,
  canstop             = [[1]],
  category            = [[FLOAT]],
  collisionVolumeTest = 1,
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Batterie de Missiles Anti-Air ? Moyenne Port?e]],
    helptext       = [[The Chainsaw is a long range anti-air turret, dealing out massive damage, able to knock bombers out of the sky very quickly. It can't take very much damage in return, though, and does poorly when attacked directly.]],
    helptext_fr    = [[Cette batterie de missile ultra v?loce permet d'abattre des cibles aeriennes lourdes - comme les bombardiers - avant qu'elles ne puissent passer ? l'attaque. Il n?cessite d'?tre plac? en terrain d?gag? pour utiliser pleinement son potentiel. Reste assez fragile et ? prot?ger.]],
  },

  defaultmissiontype  = [[GUARD_NOMOVE]],
  explodeAs           = [[LARGE_BUILDINGEX]],
  floater             = true,
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[defense]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  mass                = 400,
  maxDamage           = 2500,
  maxSlope            = 18,
  maxVelocity         = 0,
  maxWaterDepth       = 5000,
  minCloakDistance    = 150,
  noAutoFire          = false,
  noChaseCategory     = [[FIXEDWING LAND SINK SHIP SATELLITE SWIM GUNSHIP FLOAT SUB HOVER]],
  objectName          = [[ARMCIR]],
  seismicSignature    = 4,
  selfDestructAs      = [[LARGE_BUILDINGEX]],
  side                = [[ARM]],
  sightDistance       = 702,
  smoothAnim          = true,
  TEDClass            = [[FORT]],
  turnRate            = 0,
  workerTime          = 0,
  yardMap             = [[oooooooooooooooo]],
  
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
      def                = [[MISSILE]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    MISSILE = {
      name                    = [[Missile Salvo]],
      areaOfEffect            = 24,
      canattackground         = false,
      cegTag                  = [[MISSILE_TAG_WHITE_10]],
      craterBoost             = 0,
      craterMult              = 0,
      cylinderTargetting      = 1,

      damage                  = {
        default = 35,
        planes  = 350,
        subs    = 17.5,
      },

      energypershot           = 0,
      explosionGenerator      = [[custom:MISSILE_HIT_PIKES_160]],
      fireStarter             = 20,
      flightTime              = 4,
      guidance                = true,
      impactOnly              = true,
      impulseBoost            = 0.123,
      impulseFactor           = 0.0492,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[wep_m_phoenix.s3o]],
      noSelfDamage            = true,
      range                   = 1400,
      reloadtime              = 1,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[weapons/mrmhit]],
      soundStart              = [[weapons/missilewolf]],
      soundTrigger            = true,
      startsmoke              = [[1]],
      startVelocity           = 550,
      texture2                = [[none]],
      tolerance               = 16000,
      tracks                  = true,
      turnRate                = 55000,
      turret                  = true,
      waterweapon             = true,
      weaponAcceleration      = 550,
      weaponTimer             = 3,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 800,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Chainsaw]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 5000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 400,
      object           = [[ARMCIR_DEAD]],
      reclaimable      = true,
      reclaimTime      = 400,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Chainsaw]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 5000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 400,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 400,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Chainsaw]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 5000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 200,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 200,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armcir = unitDef })
