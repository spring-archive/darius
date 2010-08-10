unitDef = {
  unitname           = [[chickenspire]],
  name               = [[Chicken Spire]],
  description        = [[Static Artillery]],
  acceleration       = 0,
  activateWhenBuilt  = true,
  bmcode             = [[0]],
  brakeRate          = 0,
  buildCostEnergy    = 0,
  buildCostMetal     = 0,
  builder            = false,
  buildPic           = [[chickenspire.png]],
  buildTime          = 1200,
  canAttack          = true,
  canstop            = [[1]],
  category           = [[SINK]],

  customParams       = {
    description_fr = [[Static Artillery]],
    helptext       = [[Long range static artillery.]],
    helptext_fr    = [[]],
  },

  defaultmissiontype = [[GUARD_NOMOVE]],
  energyMake         = 1,
  explodeAs          = [[NOWEAPON]],
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = [[default]],
  idleAutoHeal       = 5,
  idleTime           = 1800,
  levelGround        = false,
  mass               = 0,
  maxDamage          = 1500,
  maxSlope           = 36,
  maxVelocity        = 0,
  maxWaterDepth      = 20,
  noAutoFire         = false,
  noChaseCategory    = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName         = [[spire.s3o]],
  onoffable          = true,
  power              = 120,
  seismicSignature   = 4,
  selfDestructAs     = [[NOWEAPON]],

  sfxtypes           = {

    explosiongenerators = {
      [[custom:blood_spray]],
      [[custom:blood_explode]],
      [[custom:dirt]],
    },

  },

  side               = [[THUNDERBIRDS]],
  sightDistance      = 512,
  smoothAnim         = true,
  TEDClass           = [[METAL]],
  turnRate           = 0,
  upright            = false,
  workerTime         = 0,
  yardMap            = [[oooooooooooooooo]],

  weapons            = {

    {
      def                = [[SEEKERS]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs         = {

    SEEKERS = {
      name                    = [[Seekers]],
      areaOfEffect            = 128,
      avoidFriendly           = false,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 500,
      },

      dance                   = 60,
      explosionGenerator      = [[custom:large_green_goo]],
      fireStarter             = 0,
      flightTime              = 20,
      groundbounce            = 1,
      guidance                = true,
      heightmod               = 0.5,
      impactOnly              = false,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[chickenegggreen.s3o]],
      noSelfDamage            = true,
      range                   = 3000,
      reloadtime              = 30,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      startsmoke              = [[1]],
      startVelocity           = 40,
      texture1                = [[none]],
      texture2                = [[sporetrail2]],
      tolerance               = 10000,
      tracks                  = true,
      trajectoryHeight        = 2,
      turnRate                = 10000,
      turret                  = true,
      waterweapon             = true,
      weaponAcceleration      = 40,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 400,
      wobble                  = 32000,
    },

  },

}

return lowerkeys({ chickenspire = unitDef })
