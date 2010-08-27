--WARNING
--This file is automatically generated and all manual changes will be lost!!

unitDef = {
  unitname               = [[titaniumpoison]],
  name                   = [[TitaniumPoison]],
  description            = [[TitaniumPoison]],
  acceleration           = 0,
  activateWhenBuilt      = false,
  bmcode                 = [[0]],
  brakeRate              = 0,
  buildPic               = [[armcir.png]],
  canAttack              = true,
  canstop                = [[1]],
  category               = [[SINK]],
  collisionVolumeOffsets = [[0 -32 0]],
  collisionVolumeScales  = [[32 90 32]],
  collisionVolumeTest    = 1,
  collisionVolumeType    = [[CylY]],
  corpse                 = [[DEAD]],

  customParams           = {
  },

  defaultmissiontype     = [[GUARD_NOMOVE]],
  explodeAs              = [[SMALL_BUILDINGEX]],
  footprintX             = 2,
  footprintZ             = 2,
  healtime               = [[0]],
  iconType               = [[defenseraider]],
  idleAutoHeal           = 0,
  idleTime               = 1800,
  levelGround            = false,
  mass                   = 45,
  maxDamage              = 3000,
  maxSlope               = 36,
  maxVelocity            = 0,
  maxWaterDepth          = 0,
  minCloakDistance       = 150,
  modelCenterOffset      = [[0 32 0]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName             = [[armcir.3do]],
  seismicSignature       = 4,
  selfDestructAs         = [[SUICIDE]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:BEAMWEAPON_MUZZLE_RED]],
    },

  },

  side                   = [[HUMANS]],
  sightDistance          = 473,
  smoothAnim             = true,
  TEDClass               = [[FORT]],
  turnRate               = 110,
  workerTime             = 0,
  yardMap                = [[oooo]],

  weapons               = {

    {
      def                = [[GAS]],
      badTargetCategory  = [[FIREPROOF]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER GUNSHIP FIXEDWING]],
    },

  },


  weaponDefs            = {

    GAS = {
      name                    = [[Poison Gas]],
      areaOfEffect            = 200,
	  avoidFriendly			  = false,
      avoidFeature            = false,
      collideFeature          = false,
      craterBoost             = 0,
      craterMult              = 0,
      damage                  = {
        default       = 2,
      },

      fireStarter             = 1000,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 1.1,
      interceptedByShieldType = 0,
      lineOfSight             = true,
      noExplode               = true,
      noSelfDamage            = true,	 
      range                   = 420,
      reloadtime              = 3.2,
      renderType              = 5,
      sizeGrowth              = 3,
      soundTrigger            = true,
      tolerance               = 2500,
	  sprayAngle			  = 0,
	  texture1				  = [[poison]],
      turret                  = true,
      weaponType              = [[Flame]],
      weaponVelocity          = 200,
    },

  },

}

return lowerkeys({ titaniumpoison = unitDef })
