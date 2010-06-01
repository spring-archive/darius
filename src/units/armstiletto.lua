unitDef = {
  unitname            = [[armstiletto]],
  name                = [[Stiletto]],
  description         = [[EMP Bomber]],
  amphibious          = true,
  buildCostEnergy     = 600,
  buildCostMetal      = 600,
  buildPic            = [[CORGRIPN.png]],
  buildTime           = 600,
  canAttack           = true,
  canDropFlare        = false,
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

  customParams        = {
    helptext = [[Sleek, fast and able to take a beating, the Stiletto drops EMP bombs that can paralyze an entire column of tanks in a single pass, rendering them helpless before allied forces.]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  explodeAs           = [[GUNSHIPEX]],
  fireState           = 1,
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[bomberriot]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  immunetoparalyzer   = [[1]],
  maneuverleashlength = [[1380]],
  mass                = 300,
  maxAcc              = 0.5,
  maxDamage           = 1130,
  maxFuel             = 1000,
  maxVelocity         = 12,
  minCloakDistance    = 75,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName          = [[armstiletto.s3o]],
  seismicSignature    = 0,
  selfDestructAs      = [[GUNSHIPEX]],
  side                = [[ARM]],
  sightDistance       = 660,
  smoothAnim          = true,

  sounds              = {
    canceldestruct = [[ota/cancel2]],

    cant           = {
      [[ota/cantdo4]],
    },


    count          = {
      [[ota/count6]],
      [[ota/count5]],
      [[ota/count4]],
      [[ota/count3]],
      [[ota/count2]],
      [[ota/count1]],
    },


    ok             = {
      [[ota/vtolcrmv]],
    },


    select         = {
      [[ota/vtolcrac]],
    },

    underattack    = [[ota/warning1]],
  },

  stealth             = true,
  steeringmode        = [[1]],
  TEDClass            = [[VTOL]],
  turnRate            = 396,

  weapons             = {

    {
      def                = [[CORGRIPN_BOMB]],
      badTargetCategory  = [[SWIM LAND SHIP HOVER]],
      fuelUsage          = 999,
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER GUNSHIP]],
    },

  },


  weaponDefs          = {

    CORGRIPN_BOMB = {
      name                    = [[EMPbomb]],
      areaOfEffect            = 240,
      avoidFeature            = false,
      avoidFriendly           = false,
      collideFriendly         = false,
      commandfire             = true,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default        = 1500,
        commanders     = 150,
        empresistant75 = 375,
        empresistant99 = 15,
        planes         = 1500,
      },

      dropped                 = true,
      edgeEffectiveness       = 0.4,
      explosionGenerator      = [[custom:ELECTRIC_EXPLOSION]],
      fireStarter             = 0,
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      model                   = [[bomb]],
      myGravity               = 0.7,
      noSelfDamage            = true,
      paralyzer               = true,
      paralyzeTime            = 15,
      range                   = 800,
      reloadtime              = 0.3,
      renderType              = 6,
      soundHit                = [[OTAunit/EMGPULS1]],
      soundStart              = [[OTAunit/BOMBREL]],
      tolerance               = 7000,
      weaponType              = [[AircraftBomb]],
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Stiletto]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2260,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 300,
      object           = [[ARMHAM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 300,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Stiletto]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2260,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 300,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 300,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Stiletto]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2260,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 150,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 150,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armstiletto = unitDef })
