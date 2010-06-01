unitDef = {
  unitname            = [[corsb]],
  name                = [[Maelstrom]],
  description         = [[Seaplane Bomber]],
  acceleration        = 0.084,
  altfromsealevel     = [[1]],
  amphibious          = true,
  attackrunlength     = [[260]],
  bmcode              = [[1]],
  brakeRate           = 1.5,
  buildCostEnergy     = 450,
  buildCostMetal      = 450,
  builder             = false,
  buildPic            = [[CORSB.png]],
  buildTime           = 450,
  canAttack           = true,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  canSubmerge         = false,
  category            = [[FIXEDWING]],
  collide             = false,
  corpse              = [[HEAP]],
  cruiseAlt           = 250,
  defaultmissiontype  = [[VTOL_standby]],
  explodeAs           = [[BIG_UNITEX]],
  fireState           = 1,
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[bomber]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[1380]],
  mass                = 225,
  maxDamage           = 1100,
  maxVelocity         = 9.46,
  minCloakDistance    = 75,
  moverate1           = [[8]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName          = [[CORSB]],
  seismicSignature    = 0,
  selfDestructAs      = [[BIG_UNITEX]],
  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[VTOL]],
  turnRate            = 368,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[ARMADVBOMB]],
      badTargetCategory  = [[SWIM LAND SHIP HOVER]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    ARMADVBOMB = {
      name                    = [[AdvancedBombs]],
      areaOfEffect            = 180,
      avoidFeature            = false,
      avoidFriendly           = false,
      burst                   = 10,
      burstrate               = 0.4,
      collideFriendly         = false,
      commandfire             = true,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 200,
        planes  = 20,
        subs    = 10,
      },

      dropped                 = true,
      edgeEffectiveness       = 0.7,
      explosionGenerator      = [[custom:BigBulletImpact]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      manualBombSettings      = true,
      model                   = [[bomb]],
      noSelfDamage            = true,
      range                   = 1280,
      reloadtime              = 10,
      renderType              = 6,
      soundHit                = [[OTAunit/XPLOMED2]],
      soundStart              = [[OTAunit/BOMBREL]],
      sprayAngle              = 4000,
      weaponType              = [[AircraftBomb]],
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Maelstrom]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2200,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 225,
      object           = [[ARMHAM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 225,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Maelstrom]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 225,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 225,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Maelstrom]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 112.5,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 112.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corsb = unitDef })
