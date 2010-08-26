--WARNING
--This file is automatically generated and all manual changes will be lost!!

unitDef = {
  unitname               = [[chickenfire]],
  name                   = [[ChickenFire]],
  description            = [[ChickenFire]],
  acceleration           = 0,
  activateWhenBuilt      = false,
  bmcode                 = [[0]],
  brakeRate              = 0,
  buildPic               = [[mercury.png]],
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
  maxDamage              = 1350,
  maxSlope               = 36,
  maxVelocity            = 0,
  maxWaterDepth          = 0,
  minCloakDistance       = 150,
  modelCenterOffset      = [[0 32 0]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName             = [[mercury.3do]],
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
      def                = [[FLAMETHROWER]],
      badTargetCategory  = [[FIREPROOF]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER GUNSHIP FIXEDWING]],
    },

  },


  weaponDefs            = {

    FLAMETHROWER = {
      name                    = [[Flame Thrower]],
      areaOfEffect            = 250,
      avoidFeature            = false,
      collideFeature          = false,
      craterBoost             = 0,
      craterMult              = 0,
	  cegTag                  = [[fire1_burn1_flame1]],
      damage                  = {
        default       = 2,
      },

      explosionGenerator      = [[custom:SMOKE]],
      fireStarter             = 0,
      flameGfxTime            = 2.6,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 1.1,
      interceptedByShieldType = 0,
      lineOfSight             = true,
      noExplode               = true,
      noSelfDamage            = true,	 
      range                   = 180,
      reloadtime              = 0.4,
      renderType              = 5,
      sizeGrowth              = 2.5,
      soundStart              = [[weapons/flamhvy1]],
      soundTrigger            = true,
      tolerance               = 2500,
	  sprayAngle			  = 50000,
      turret                  = true,
	  texture1				  = [[fire2]],
      weaponType              = [[Flame]],
      weaponVelocity          = 200,
    },

  },

}

return lowerkeys({ chickenfire = unitDef })
