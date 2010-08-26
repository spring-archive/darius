--WARNING
--This file is automatically generated and all manual changes will be lost!!

unitDef = {
  unitname               = [[titaniumsniper]],
  name                   = [[TitaniumSniper]],
  description            = [[TitaniumSniper]],
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

weapons             = {

    {
      def                = [[Sniper]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    Sniper = {
      name                    = [[Long Range Pulse Rifle]],
      areaOfEffect            = 1,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 100,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:smoke]],
      impactOnly              = false,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noGap                   = true,
      noSelfDamage            = true,
      range                   = 1700,
      reloadtime              = 7,
      renderType              = 1,
      separation              = 0.5,
      sizeDecay               = 0,
      soundStart              = [[weapons/flashemg]],
      sprayAngle              = 1,
      startsmoke              = [[0]],
      tolerance               = 5000,
      turret                  = true,
      weaponTimer             = 0.1,
      weaponType              = [[Melee]],
      weaponVelocity          = 1,
    },

  },

}

return lowerkeys({ titaniumsniper = unitDef })
