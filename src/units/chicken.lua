unitDef = {
  unitname            = [[chicken]],
  name                = [[Chicken]],
  description         = [[Swarmer]],
  acceleration        = 0.36,
  bmcode              = [[1]],
  brakeRate           = 0.2,
  buildPic            = [[chicken.png]],
  canAttack           = true,
  canGuard            = true,
  canHover            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[SWIM]],

  customParams        = {
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[NOWEAPON]],
  floater             = false,
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[default]],
  idleAutoHeal        = 20,
  idleTime            = 300,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 26.4,
  maxDamage           = 370,
  maxSlope            = 36,
  maxVelocity         = 1.9,
  minCloakDistance    = 75,
  movementClass       = [[MEDIUM]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP]],
  objectName          = [[chicken.s3o]],
  power               = 100,
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
  sightDistance       = 256,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  trackOffset         = 0,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ChickenTrack]],
  trackWidth          = 18,
  turnRate            = 768,
  upright             = false,
  waterline           = 8,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[WEAPON]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 120,
      onlyTargetCategory = [[SWIM LAND SUB SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    WEAPON = {
      name                    = [[Claws]],
      areaOfEffect            = 8,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 80,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:NONE]],
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 80,
      reloadtime              = 0.8,
      size                    = 0,
      soundHit                = [[monsters/chickenbig2]],
      soundStart              = [[monsters/chicken]],
      startsmoke              = [[0]],
      targetborder            = 1,
      tolerance               = 5000,
      turret                  = true,
      waterWeapon             = true,
      weaponTimer             = 0.1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 500,
    },

  },

}

return lowerkeys({ chicken = unitDef })
