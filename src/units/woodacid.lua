--WARNING
--This file is automatically generated and all manual changes will be lost!!

unitDef = {
  unitname               = [[woodacid]],
  name                   = [[WoodAcid]],
  description            = [[WoodAcid]],
  acceleration           = 0,
  activateWhenBuilt      = false,
  bmcode                 = [[0]],
  brakeRate              = 0,
  buildPic               = [[CORLLT.png]],
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
  maxDamage              = 400,
  maxSlope               = 36,
  maxVelocity            = 0,
  maxWaterDepth          = 0,
  minCloakDistance       = 150,
  modelCenterOffset      = [[0 32 0]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName             = [[armbrtha.3do]],
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
      def                = [[WEAPON]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT GUNSHIP SHIP HOVER]],
    },

  },


  weaponDefs          = {

    WEAPON = {
      name                    = [[Blob]],
      areaOfEffect            = 100,
      burst                   = 3,
      burstrate               = 0.01,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 100,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:green_goo]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 400,
      reloadtime              = 1.2,
      renderType              = 4,
      rgbColor                = [[0.2 0.6 0]],
      size                    = 8,
      sizeDecay               = 0,
      soundHit                = [[weapons/acid2]],
      soundStart              = [[weapons/acid]],
      sprayAngle              = 1024,
      startsmoke              = [[0]],
      tolerance               = 5000,
      turret                  = true,
      weaponTimer             = 0.2,
      weaponType              = [[Cannon]],
      weaponVelocity          = 400,
    },

  },

}

return lowerkeys({ woodacid = unitDef })
