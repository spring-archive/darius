unitDef = {
  unitname            = [[chickenr]],
  name                = [[Lobber]],
  description         = [[Artillery]],
  acceleration        = 0.36,
  bmcode              = [[1]],
  brakeRate           = 0.2,
  buildCostEnergy     = 0,
  buildCostMetal      = 0,
  builder             = false,
  buildPic            = [[chickenr.png]],
  buildTime           = 200,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],

  customParams        = {
    description_fr = [[Artillery]],
    helptext       = [[A form of organic artillery, the Lobber hurls balls of venom at a high trajectory over long distances. It proves a problem for those who rely excessively on static defenses, but is practically helpless when attacked directly.]],
    helptext_fr    = [[A form of organic artillery, the Lobber hurls balls of venom at a high trajectory over long distances. It proves a problem for those who rely excessively on static defenses, but is practically helpless when attacked directly.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[NOWEAPON]],
  footprintX          = 2,
  footprintZ          = 2,
  highTrajectory      = 1,
  iconType            = [[default]],
  idleAutoHeal        = 20,
  idleTime            = 300,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 616,
  maxDamage           = 500,
  maxSlope            = 36,
  maxVelocity         = 1.8,
  maxWaterDepth       = 5000,
  minCloakDistance    = 75,
  movementClass       = [[SMALL]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[chickenr.s3o]],
  power               = 400,
  seismicSignature    = 4,
  selfDestructAs      = [[NOWEAPON]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:blood_spray]],
      [[custom:blood_explode]],
      [[custom:dirt]],
    },

  },

  side                = [[MONSTERS]],
  sightDistance       = 2000,
  smoothAnim          = true,
  sonarDistance       = 450,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  trackOffset         = 6,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ChickenTrack]],
  trackWidth          = 30,
  turnRate            = 768,
  upright             = false,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[WEAPON]],
      badTargetCategory  = [[SWIM SHIP HOVER]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 120,
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    WEAPON = {
      name                    = [[Blob]],
      areaOfEffect            = 96,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 240,
        planes  = 240,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:lobber_goo]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      mygravity               = 0.2,
      noSelfDamage            = true,
      range                   = 950,
      reloadtime              = 6,
      renderType              = 4,
      rgbColor                = [[0.2 0.6 0.0]],
      size                    = 8,
      sizeDecay               = 0,
      soundHit                = [[weapons/acid2]],
      soundStart              = [[weapons/acid]],
      sprayAngle              = 256,
      startsmoke              = [[0]],
      tolerance               = 5000,
      turret                  = true,
      weaponTimer             = 0.2,
      weaponType              = [[Cannon]],
      weaponVelocity          = 400,
    },

  },

}

return lowerkeys({ chickenr = unitDef })
