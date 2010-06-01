unitDef = {
  unitname          = [[corjamt]],
  name              = [[Aegis]],
  description       = [[Linkable Shield Device]],
  acceleration      = 0,
  activateWhenBuilt = true,
  bmcode            = [[0]],
  brakeRate         = 0,
  buildAngle        = 9821,
  buildCostEnergy   = 480,
  buildCostMetal    = 480,
  builder           = false,
  buildPic          = [[CORJAMT.png]],
  buildTime         = 480,
  canAttack         = false,
  category          = [[SINK UNARMED]],
  corpse            = [[DEAD]],
  energyUse         = 1.5,
  explodeAs         = [[BIG_UNITEX]],
  footprintX        = 2,
  footprintZ        = 2,
  iconType          = [[defenseshield]],
  idleAutoHeal      = 5,
  idleTime          = 1800,
  levelGround       = false,
  mass              = 240,
  maxDamage         = 900,
  maxSlope          = 36,
  maxVelocity       = 0,
  maxWaterDepth     = 0,
  minCloakDistance  = 150,
  noAutoFire        = false,
  objectName        = [[m-8.s3o]],
  onoffable         = true,
  script            = [[aegis.lua]],
  seismicSignature  = 4,
  selfDestructAs    = [[BIG_UNITEX]],
  side              = [[CORE]],
  sightDistance     = 200,
  smoothAnim        = true,
  TEDClass          = [[SPECIAL]],
  turnRate          = 0,
  workerTime        = 0,
  yardMap           = [[oooo]],

  weapons           = {

    {
      def         = [[COR_SHIELD_SMALL]],
      maxAngleDif = 1,
    },

  },


  weaponDefs        = {

    COR_SHIELD_SMALL = {
      name                    = [[Energy Shield]],
      craterMult              = 0,

      damage                  = {
        default = 10,
      },

      exteriorShield          = true,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      isShield                = true,
      shieldAlpha             = 0.2,
      shieldBadColor          = [[1 0.1 0.1]],
      shieldGoodColor         = [[0.1 0.1 1]],
      shieldInterceptType     = 3,
      shieldPower             = 3500,
      shieldPowerRegen        = 60,
      shieldPowerRegenEnergy  = 9,
      shieldRadius            = 350,
      shieldRepulser          = false,
      smartShield             = true,
      texture1                = [[wake]],
      visibleShield           = true,
      visibleShieldHitFrames  = 4,
      visibleShieldRepulse    = true,
      weaponType              = [[Shield]],
    },

  },


  featureDefs       = {

    DEAD  = {
      description      = [[Wreckage - Aegis]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1800,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[3]],
      hitdensity       = [[100]],
      metal            = 240,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 240,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[all]],
    },


    DEAD2 = {
      description      = [[Debris - Aegis]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1800,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[100]],
      metal            = 240,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 240,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Aegis]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1800,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[100]],
      metal            = 120,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 120,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corjamt = unitDef })
