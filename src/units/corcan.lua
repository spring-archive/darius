unitDef = {
  unitname            = [[corcan]],
  name                = [[Jack]],
  description         = [[Melee Assault Walker]],
  acceleration        = 0.12,
  bmcode              = [[1]],
  brakeRate           = 0.188,
  buildCostEnergy     = 650,
  buildCostMetal      = 650,
  builder             = false,
  buildPic            = [[CORCAN.png]],
  buildTime           = 650,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    canjump        = [[1]],
    description_bp = [[Robô de assaulto]],
    description_fr = [[Robot d'Assaut]],
    helptext       = [[The Jack is Logos' main assault walker. A few Jacks can easily level most fortification lines. Its small range and very low speed make it very vulnerable to skirmishers.]],
    helptext_bp    = [[Can é o principal robô de assaulto de Logos. Alguns podem facilmente destruir a maioria das linhas de defesa, e n?o podem ser "sufocados" por agressores devido a sua rápida velocidade de disparo. Sua velocidade e principalmente alcançe s?o muito baixos, tornando-o um alvo fácil, embora resistente, a escaramuçadores.]],
    helptext_fr    = [[Le Jack est un robot extr?mement bien blind? ?quip? d'un jetpack et d'un lance a syst?me hydrolique. Il ne frappe qu'au corps ? corps, mais il frappe fort. ]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[jumpjetassault]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 325,
  maxDamage           = 5000,
  maxSlope            = 36,
  maxVelocity         = 1.81,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT2]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[corcan.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:RAIDMUZZLE]],
      [[custom:VINDIBACK]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 350,
  smoothAnim          = true,
  sonarDistance       = 400,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  trackOffset         = 0,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ComTrack]],
  trackWidth          = 22,
  turninplace         = 0,
  turnRate            = 970,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[Spike]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER GUNSHIP FIXEDWING]],
    },

  },


  weaponDefs          = {

    Spike = {
      name                    = [[Spike]],
      areaOfEffect            = 8,
      beamTime                = 0.13,
      beamWeapon              = true,
      canattackground         = true,
      cegTag                  = [[orangelaser]],
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 300,
        planes  = 300,
        subs    = 15,
      },

      energypershot           = 0.2,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_ORANGE]],
      fireStarter             = 90,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 0,
      lineOfSight             = true,
      lodDistance             = 10000,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 125,
      reloadtime              = 1,
      renderType              = 0,
      rgbColor                = [[1 0.25 0]],
      soundHit                = [[OTAunit/XPLOLRG1]],
      soundStart              = [[OTAunit/XPLOLRG1]],
	  targetborder 			  = 1,
      targetMoveError         = 0.2,
      thickness               = 0,
      tolerance               = 10000,
      turret                  = true,
      waterweapon             = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 2000,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Jack]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 10000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 325,
      object           = [[CORCAN_DEAD]],
      reclaimable      = true,
      reclaimTime      = 325,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Jack]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 10000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 325,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 325,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Jack]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 10000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 162.5,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 162.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corcan = unitDef })
