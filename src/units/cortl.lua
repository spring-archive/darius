unitDef = {
  unitname          = [[cortl]],
  name              = [[Urchin]],
  description       = [[Torpedo Launcher]],
  acceleration      = 0,
  activateWhenBuilt = true,
  bmcode            = [[0]],
  brakeRate         = 0,
  buildAngle        = 16384,
  buildCostEnergy   = 260,
  buildCostMetal    = 260,
  builder           = false,
  buildPic          = [[CORTL.png]],
  buildTime         = 260,
  canAttack         = true,
  canstop           = [[1]],
  category          = [[FLOAT]],
  corpse            = [[DEAD]],

  customParams      = {
    description_fr = [[Lance Torpille]],
    helptext       = [[This Torpedo Launcher provides defense against both surface and submerged vessels. Remember to build sonar so that the Torpedo Launcher can hit submerged targets. The Torpedo Launcher cannot hit hovercraft.]],
    helptext_fr    = [[Ce lance torpille permet de torpiller les unit?s flottantes ou immerg?es. Construisez un sonar afin de d?tecter le plus t?t possible les cibles potentielles du Harpoon. Attention, le Harpoon est inefficace contre les Hovercraft.]],
  },

  explodeAs         = [[MEDIUM_BUILDINGEX]],
  footprintX        = 3,
  footprintZ        = 3,
  iconType          = [[defense]],
  idleAutoHeal      = 5,
  idleTime          = 1800,
  mass              = 130,
  maxDamage         = 1900,
  maxSlope          = 18,
  maxVelocity       = 0,
  minCloakDistance  = 150,
  minWaterDepth     = 1,
  noAutoFire        = false,
  noChaseCategory   = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName        = [[torpedo launcher.s3o]],
  seismicSignature  = 4,
  selfDestructAs    = [[MEDIUM_BUILDINGEX]],
  side              = [[CORE]],
  sightDistance     = 605,
  smoothAnim        = true,
  TEDClass          = [[WATER]],
  turnRate          = 0,
  waterline         = 1,
  workerTime        = 0,
  yardMap           = [[wwwwwwwww]],

  weapons           = {

    {
      def                = [[COAX_TORPEDO]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[SWIM FIXEDWING LAND SUB SINK FLOAT SHIP GUNSHIP]],
    },

  },


  weaponDefs        = {

    COAX_TORPEDO = {
      name                    = [[Level1 Torpedo Launcher]],
      areaOfEffect            = 16,
      avoidFriendly           = false,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 300,
      },

      explosionGenerator      = [[custom:TORPEDO_HIT]],
      guidance                = true,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      model                   = [[wep_t_longbolt.s3o]],
      noSelfDamage            = true,
      propeller               = [[1]],
      range                   = 600,
      reloadtime              = 1.8,
      renderType              = 1,
      selfprop                = true,
      soundHit                = [[OTAunit/XPLODEP2]],
      soundStart              = [[OTAunit/TORPEDO1]],
      startVelocity           = 200,
      tracks                  = true,
      turnRate                = 16000,
      turret                  = true,
      waterWeapon             = true,
      weaponAcceleration      = 40,
      weaponTimer             = 3,
      weaponType              = [[TorpedoLauncher]],
      weaponVelocity          = 320,
    },

  },


  featureDefs       = {

    DEAD  = {
      description      = [[Wreckage - Urchin]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 3800,
      energy           = 0,
      featureDead      = [[DEAD2]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 130,
      object           = [[CORTL_DEAD]],
      reclaimable      = true,
      reclaimTime      = 130,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Urchin]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3800,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      hitdensity       = [[100]],
      metal            = 130,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 130,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Urchin]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3800,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      hitdensity       = [[100]],
      metal            = 65,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 65,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ cortl = unitDef })
