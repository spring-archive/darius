unitDef = {
  unitname            = [[corgarp]],
  name                = [[Wolverine]],
  description         = [[Artillery Tank]],
  acceleration        = 0.018,
  bmcode              = [[1]],
  brakeRate           = 0.018,
  buildCostEnergy     = 160,
  buildCostMetal      = 160,
  builder             = false,
  buildPic            = [[corgarp.png]],
  buildTime           = 160,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Tanque de artilharia]],
    description_fr = [[Tank Artilleur]],
    helptext       = [[The Wolverine fires in high trajectory so it's not suitable for use against moving units. It can comfortably outrange Heavy Laser Towers. It can't fire backwards and is unmanouverable. Protect it against raider charges with a screen of riot or assault units.]],
    helptext_bp    = [[Wolverine é o veículo de artilharia leve de Logos. Seus tiros s?o de alta trajetória ent?o n?o funciona bem contra unidades móveis. Seu alcançe supera com folga o de torres de laser pesadas, mas é pouco ágil e n?o pode atirar para trás, devendo ser protegido de agressores por linhas de unidades dispesadoras ou de assalto.]],
    helptext_fr    = [[Le Wolverine est l'arme idéale pour prendre d'assaut les zones fortifiées. Une grande portée, des tirs en cloche et une cadence de tir respectable en font une artillerie trcs bon marché. Peu rapide et ne pouvant pas tirer en arricre, il faudra cependant la protéger.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  highTrajectory      = 1,
  iconType            = [[default]],
  idleAutoHeal        = 5,
  idleTime            = 3200,
  leaveTracks         = true,
  maneuverleashlength = [[650]],
  mass                = 80,
  maxDamage           = 380,
  maxSlope            = 18,
  maxVelocity         = 2.5,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[MEDIUM]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName          = [[corwolv.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:wolvmuzzle0]],
      [[custom:wolvmuzzle1]],
      [[custom:wolvflash]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  trackOffset         = 6,
  trackStrength       = 5,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 30,
  turninplace         = 0,
  turnRate            = 300,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[PLASMA]],
      badTargetCategory  = [[SWIM LAND SHIP HOVER]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 180,
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    PLASMA = {
      name                    = [[Light Plasma Artillery]],
      accuracy                = 250,
      areaOfEffect            = 58,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 250,
        planes  = 250,
        subs    = 12.5,
      },

      explosionGenerator      = [[custom:WEAPEXP_PUFF]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      myGravity               = 0.1,
      noSelfDamage            = true,
      range                   = 800,
      reloadtime              = 5,
      renderType              = 4,
      soundHit                = [[weapons/xplomed2]],
      soundStart              = [[weapons/cannonhvy]],
      startsmoke              = [[1]],
      targetMoveError         = 0.1,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 350,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Wolverine]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 760,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[0]],
      hitdensity       = [[100]],
      metal            = 80,
      object           = [[CORGARP_DEAD]],
      reclaimable      = true,
      reclaimTime      = 80,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[all]],
    },


    DEAD2 = {
      description      = [[Debris - Wolverine]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 760,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      hitdensity       = [[100]],
      metal            = 80,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 80,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Wolverine]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 760,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      hitdensity       = [[100]],
      metal            = 40,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 40,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corgarp = unitDef })
