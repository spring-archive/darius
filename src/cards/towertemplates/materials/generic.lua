unitDef = {
  unitname               = [[%%SHORTNAME%%]],
  name                   = [[%%NAME%%]],
  description            = [[%%NAME%%]],
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
  healtime               = [[4]],
  iconType               = [[defenseraider]],
  idleAutoHeal           = 5,
  idleTime               = 1800,
  levelGround            = false,
  mass                   = 45,
  maxDamage              = %%HEALTH%%,
  maxSlope               = 36,
  maxVelocity            = 0,
  maxWaterDepth          = 0,
  minCloakDistance       = 150,
  modelCenterOffset      = [[0 32 0]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName             = [[%%MODEL%%.s3o]],
  seismicSignature       = 4,
  selfDestructAs         = [[SMALL_BUILDINGEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:BEAMWEAPON_MUZZLE_RED]],
    },

  },

  side                   = [[HUMANS]],
  sightDistance          = 473,
  smoothAnim             = true,
  TEDClass               = [[FORT]],
  turnRate               = 0,
  workerTime             = 0,
  yardMap                = [[oooo]],

  %%WEAPONS%%
}

return lowerkeys({ %%SHORTNAME%% = unitDef })