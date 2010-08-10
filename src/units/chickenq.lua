unitDef = {
  unitname               = [[chickenq]],
  name                   = [[Chicken Queen]],
  description            = [[Clucking Hell!]],
  acceleration           = 1,
  autoHeal               = 0,
  bmcode                 = [[1]],
  brakeRate              = 1,
  buildPic               = [[chickenq.png]],
  canAttack              = true,
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  canstop                = [[1]],
  canSubmerge            = false,
  cantBeTransported      = true,
  category               = [[LAND]],
  collisionSphereScale   = 1,
  collisionVolumeOffsets = [[0 0 15]],
  collisionVolumeScales  = [[46 110 120]],
  collisionVolumeTest    = 1,
  collisionVolumeType    = [[box]],

  customParams           = {
  },

  defaultmissiontype     = [[standby]],
  explodeAs              = [[DODO_DEATH]],
  footprintX             = 8,
  footprintZ             = 8,
  iconType               = [[default]],
  idleAutoHeal           = 0,
  idleTime               = 300,
  leaveTracks            = true,
  maneuverleashlength    = [[640]],
  mass                   = 24800,
  maxDamage              = 20000,
  maxVelocity            = 1.3,
  minCloakDistance       = 75,
  movementClass          = [[TKBOT3]],
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM SATELLITE]],
  objectName             = [[chickenq.s3o]],
  power                  = 6000,
  seismicSignature       = 4,
  selfDestructAs         = [[DODO_DEATH]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:blood_spray]],
      [[custom:blood_explode]],
      [[custom:dirt]],
    },

  },

  side                   = [[THUNDERBIRDS]],
  sightDistance          = 800,
  smoothAnim             = true,
  sonarDistance          = 450,
  steeringmode           = [[2]],
  TEDClass               = [[KBOT]],
  trackOffset            = 18,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ChickenTrack]],
  trackWidth             = 100,
  turnRate               = 300,
  upright                = false,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[MELEE]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 150,
      onlyTargetCategory = [[SWIM LAND SUB SINK FLOAT SHIP HOVER]],
    },


    {
      def                = [[SPORES]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[SPORES]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[SPORES]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[GOO]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 120,
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },


    {
      def                = [[QUEENCRUSH]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs             = {

    GOO        = {
      name                    = [[Blob]],
      areaOfEffect            = 256,
      burst                   = 6,
      burstrate               = 0.01,
      cegTag                  = [[queen_trail]],
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 500,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:large_green_goo]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      proximityPriority       = -4,
      range                   = 450,
      reloadtime              = 6,
      renderType              = 4,
      rgbColor                = [[0.2 0.6 0]],
      size                    = 8,
      sizeDecay               = 0,
      soundStart              = [[monsters/bigchickenroar]],
      sprayAngle              = 6100,
      startsmoke              = [[0]],
      tolerance               = 5000,
      turret                  = true,
      weaponTimer             = 0.2,
      weaponType              = [[Cannon]],
      weaponVelocity          = 600,
    },


    MELEE      = {
      name                    = [[ChickenClaws]],
      areaOfEffect            = 32,
      craterBoost             = 1,
      craterMult              = 0,

      damage                  = {
        default = 3000,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:NONE]],
      impulseBoost            = 0,
      impulseFactor           = 1,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 200,
      reloadtime              = 0.4,
      size                    = 0,
      soundStart              = [[monsters/bigchickenbreath]],
      startsmoke              = [[0]],
      targetborder            = 1,
      tolerance               = 5000,
      turret                  = true,
      waterWeapon             = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 600,
    },


    QUEENCRUSH = {
      name                    = [[ChickenKick]],
      areaOfEffect            = 400,
      collideFriendly         = false,
      craterBoost             = 0.001,
      craterMult              = 0.002,

      damage                  = {
        default    = 10,
      },

      edgeEffectiveness       = 1,
      explosionGenerator      = [[custom:NONE]],
      impulseBoost            = 2000,
      impulseFactor           = 1,
      intensity               = 1,
      interceptedByShieldType = 1,
      lineOfSight             = false,
      noSelfDamage            = true,
      range                   = 512,
      reloadtime              = 1,
      renderType              = 4,
      rgbColor                = [[1 1 1]],
      thickness               = 1,
      tolerance               = 100,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 0.8,
    },


    SPORES     = {
      name                    = [[Spores]],
      areaOfEffect            = 24,
      avoidFriendly           = false,
      burst                   = 8,
      burstrate               = 0.1,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 10,
        planes  = [[150]],
        subs    = 7.5,
      },

      dance                   = 60,
      dropped                 = 1,
      explosionGenerator      = [[custom:NONE]],
      fireStarter             = 0,
      flightTime              = 5,
      groundbounce            = 1,
      guidance                = true,
      heightmod               = 0.5,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[chickeneggpink.s3o]],
      noSelfDamage            = true,
      range                   = 400,
      reloadtime              = 4,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      startsmoke              = [[1]],
      startVelocity           = 100,
      texture1                = [[]],
      texture2                = [[sporetrail]],
      tolerance               = 10000,
      tracks                  = true,
      turnRate                = 24000,
      turret                  = true,
      waterweapon             = true,
      weaponAcceleration      = 100,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 500,
      wobble                  = 32000,
    },

  },

}

return lowerkeys({ chickenq = unitDef })
