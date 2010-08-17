--WARNING
--This file is automatically generated and all manual changes will be lost!!

unitDef = {
  unitname               = [[crystalfreeze]],
  name                   = [[CrystalFreeze]],
  description            = [[CrystalFreeze]],
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
  maxDamage              = 300,
  maxSlope               = 36,
  maxVelocity            = 0,
  maxWaterDepth          = 0,
  minCloakDistance       = 150,
  modelCenterOffset      = [[0 32 0]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName             = [[armpb.s3o]],
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

  weapons                = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs             = {

    LASER = {
      name                    = [[Laser Blaster]],
      areaOfEffect            = 24,
      beamWeapon              = true,
      canattackground         = true,
      cegTag                  = [[redlaser_llt]],
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 0,
      },

      duration                = 0.02,
      energypershot           = 0.1,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_RED]],
      fireStarter             = 30,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      lodDistance             = 10000,
      noSelfDamage            = true,
      range                   = 300,
      reloadtime              = 2.6,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundHit                = [[laserhit]],
      soundStart              = [[laser]],
      soundTrigger            = true,
      sweepfire               = false,
      targetMoveError         = 0.1,
      thickness               = 4.03112887414927,
      tolerance               = 5000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 1720,
    },

  }

}

return lowerkeys({ crystalfreeze = unitDef })
