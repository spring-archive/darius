--WARNING
--This file is automatically generated and all manual changes will be lost!!

unitDef = {
  unitname               = [[titaniumnuclear]],
  name                   = [[TitaniumNuclear]],
  description            = [[TitaniumNuclear]],
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
  maxDamage              = 2700,
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

weapons             = {

    {
      def                = [[NUKE]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    NUKE = {
      name                    = [[Nuclear missile]],
      areaOfEffect            = 300,
      craterBoost             = 0,
      craterMult              = 2,

      damage                  = {
        default = 3500,
      },

	  explosionGenerator      = [[custom:NUKE_150]],
      fireStarter             = 70,
      flightTime              = 15,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      model                   = [[wep_m_avalanche.s3o]],
      noSelfDamage            = true,
      predictBoost            = 1,
      range                   = 900,
      reloadtime              = 53,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[.1]],
      smokeTrail              = true,
      soundHit                = [[weapons/xplosml2]],
      soundHitVolume          = 8,
      soundStart              = [[weapons/rocklit1]],
      soundStartVolume        = 7,
      startsmoke              = [[1]],
      startVelocity           = 370,
      tracks                  = false,
      trajectoryHeight        = 0.6,
      turret                  = true,
      weaponTimer             = 3,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 700,
    },

}

}

return lowerkeys({ titaniumnuclear = unitDef })
