unitDef = {
  unitname            = [[chicken_leaper]],
  name                = [[Leaper]],
  description         = [[Raider]],
  acceleration        = 0.5,
  bmcode              = [[1]],
  brakeRate           = 0.2,
  buildPic            = [[chicken_leaper.png]],
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
  floater             = false,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[chickenleaper]],
  idleAutoHeal        = 20,
  idleTime            = 300,
  leaveTracks         = false,
  maneuverleashlength = [[640]],
  mass                = 100,
  maxDamage           = 700,
  maxSlope            = 36,
  maxVelocity         = 5,
  minCloakDistance    = 75,
  movementClass       = [[AKBOT2]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP]],
  objectName          = [[chicken_leaper.s3o]],
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
  turnRate            = 1600,
  upright             = true,
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
      name                    = [[Kick]],
      areaOfEffect            = 8,
      avoidFriendly           = true,
      burst                   = 5,
      burstrate               = 0.01,
      coreThickness           = 0,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 100,
        planes  = 10,
        subs    = 1,
      },

      duration                = 0.0333,
      endsmoke                = [[0]],
      explosionGenerator      = [[custom:NONE]],
      impactOnly              = true,
      impulseBoost            = 8000,
      impulseFactor           = 1,
      intensity               = 0,
      interceptedByShieldType = 0,
      noSelfDamage            = true,
      predictBoost            = 1,
      range                   = 100,
      reloadtime              = 2,
      renderType              = 4,
      rgbColor                = [[0 0 0]],
      rgbColor2               = [[0 0 0]],
      size                    = 0,
      soundStart              = [[packohit]],
      soundTrigger            = true,
      startsmoke              = [[0]],
      thickness               = 0,
      tolerance               = 5000,
      turret                  = true,
      waterWeapon             = true,
      weaponTimer             = 0.1,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 2200,
    },

  },

}

return lowerkeys({ chicken_leaper = unitDef })
