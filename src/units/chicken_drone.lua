unitDef = {
  unitname            = [[chicken_drone]],
  name                = [[Drone]],
  description         = [[Morphs Into Chicken Structures]],
  acceleration        = 0.36,
  activateWhenBuilt   = true,
  bmcode              = [[1]],
  brakeRate           = 0.2,
  buildCostEnergy     = 0,
  buildCostMetal      = 0,
  builder             = false,
  buildPic            = [[chicken_drone.png]],
  buildTime           = 60,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND UNARMED]],

  customParams        = {
    description_fr = [[Morphs Into Chicken Structures]],
    doesntcount    = [[0]],
    helptext       = [[A hapless non-combat organism whose sole purpose in life is to morph into one of the Chicken Hive's structures.]],
    helptext_fr    = [[A hapless non-combat organism whose sole purpose in life is to morph into one of the Chicken Hive's structures.]],
  },

  defaultmissiontype  = [[Standby]],
  energyMake          = 0,
  energyStorage       = 50,
  explodeAs           = [[SMALL_UNITEX]],
  floater             = false,
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[default]],
  idleAutoHeal        = 20,
  idleTime            = 300,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 14,
  maxDamage           = 170,
  maxSlope            = 36,
  maxVelocity         = 1.8,
  maxWaterDepth       = 5000,
  metalMake           = 0,
  metalStorage        = 50,
  minCloakDistance    = 75,
  movementClass       = [[SMALL]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  objectName          = [[chicken_drone.s3o]],
  onoffable           = true,
  power               = 60,
  seismicSignature    = 4,
  selfDestructAs      = [[SMALL_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:blood_spray]],
      [[custom:blood_explode]],
      [[custom:dirt]],
    },

  },

  side                = [[MONSTERS]],
  sightDistance       = 256,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  trackOffset         = 1,
  trackStrength       = 6,
  trackStretch        = 1,
  trackType           = [[ChickenTrack]],
  trackWidth          = 10,
  turnRate            = 768,
  upright             = false,
  waterline           = 8,
  workerTime          = 0,
}

return lowerkeys({ chicken_drone = unitDef })
