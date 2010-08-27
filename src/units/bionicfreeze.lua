--WARNING
--This file is automatically generated and all manual changes will be lost!!

unitDef = {
  unitname               = [[bionicfreeze]],
  name                   = [[BionicFreeze]],
  description            = [[BionicFreeze]],
  acceleration           = 0,
  activateWhenBuilt      = false,
  bmcode                 = [[0]],
  brakeRate              = 0,
  buildPic               = [[armartic.png]],
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
  idleAutoHeal           = 70,
  idleTime               = 0,
  levelGround            = false,
  mass                   = 45,
  maxDamage              = 800,
  maxSlope               = 36,
  maxVelocity            = 0,
  maxWaterDepth          = 0,
  minCloakDistance       = 150,
  modelCenterOffset      = [[0 32 0]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName             = [[armartic.3do]],
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

weapons             = {

    {
      def                = [[ICE]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    ICE = {
      name                    = [[Ice Beam]],
	  avoidFriendly			  = false,
      areaOfEffect            = 40,
	  beamWeapon              = true,
      collideFriendly         = true,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default 	   = 99999,
      },

	  duration                = 8,
      energypershot           = 0,
      explosionGenerator      = [[custom:smoke2]],
	  fireStarter             = 0,
      heightMod               = 1,
      impulseBoost            = 0,
      impulseFactor           = 0,
	  intensity               = 12,
      interceptedByShieldType = 1,
	  lineOfSight             = true,
      noSelfDamage            = true,
      paralyzer               = true,
      paralyzeTime            =	1,
      range                   = 300,
      reloadtime              = 3.3,
      renderType              = 4,
	  rgbColor                = [[0.5 0.5 1]],
      soundHit                = [[weapons/xplomed3]],
      soundStart              = [[weapons/cannon1]],
	  soundTrigger            = true,
	  targetMoveError         = 0.2,
	  thickness               = 3,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 300,
    },

  },

}

return lowerkeys({ bionicfreeze = unitDef })
