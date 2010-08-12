unitDef = {
  unitname            = [[chickenc]],
  name                = [[Basilisk]],
  description         = [[All-Terrain Riot]],
  acceleration        = 0.36,
  bmcode              = [[1]],
  brakeRate           = 0.2,
  buildPic            = [[chickenc.png]],
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],

  customParams        = {
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[NOWEAPON]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[default]],
  idleAutoHeal        = 20,
  idleTime            = 300,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 264,
  maxDamage           = 2400,
  maxSlope            = 72,
  maxVelocity         = 1,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[MEDIUM]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[chickenc.s3o]],
  power               = 520,
  seismicSignature    = 4,
  selfDestructAs      = [[NOWEAPON]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:blood_spray]],
      [[custom:blood_explode]],
      [[custom:dirt]],
    },

  },

  side                = [[THUNDERBIRDS]],
  sightDistance       = 400,
  smoothAnim          = true,
  sonarDistance       = 380,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  trackOffset         = 0.5,
  trackStrength       = 9,
  trackStretch        = 1,
  trackType           = [[ChickenTrackPointy]],
  trackWidth          = 70,
  turnRate            = 768,
  upright             = false,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[WEAPON]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 120,
      onlyTargetCategory = [[SWIM LAND SINK FLOAT GUNSHIP SHIP HOVER]],
    },

  },


  weaponDefs          = {

    WEAPON = {
      name                    = [[Blob]],
      areaOfEffect            = 128,
      burst                   = 4,
      burstrate               = 0.01,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 140,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:green_goo]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 350,
      reloadtime              = 3,
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

return lowerkeys({ chickenc = unitDef })
