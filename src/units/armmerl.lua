unitDef = {
  unitname            = [[armmerl]],
  name                = [[Merl]],
  description         = [[Mobile Cruise Missile Launcher]],
  acceleration        = 0.04,
  bmcode              = [[1]],
  brakeRate           = 0.07,
  buildCostEnergy     = 800,
  buildCostMetal      = 800,
  builder             = false,
  buildPic            = [[ARMMERL.png]],
  buildTime           = 800,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Lançador de mísseis crusadores móvel]],
    description_fr = [[Lanceur de Missile de Croisi?re Mobile]],
    description_pl = [[Mobilna Wyrzutnia Rakiet Manewruj?cych]],
    helptext       = [[The Merl fires vertically a high damage, high accuracy missile at long range. Its high arc makes it able to fire over any obstable, however that makes the flight time so high that it's useless against moving targets. Use the Merl to kill specific buildings.]],
    helptext_bp    = [[Merl dispara verticalmente um míssel de grande precis?o, dano e alcançe. Seu alto ângulo disparo o faz capaz de atirar sobre qualquer obstáculo, mas como consequ?ncia o tempo de voo é t?o longo que é quase impossível acertar alvos móveis. Use-o para matar construç?es específicas. ]],
    helptext_fr    = [[Le Merl tire verticallement des missiles de croisi?res qui retombent exactement sur leur cible, causant de puissant dommages sur une tr?s petite zone. Cependant le temps de voyage des missiles le rends inefficace contre les unit?s mobiles. ]],
    helptext_pl    = [[Merl jest wyrzutni? ci?kich rakiet artyleryjskich du?ego zasi?gu. Po wystrzeleniu rakieta wznosi si? wysoko w powietrze, a nast?pnie opada na wcze?niej wyznaczony punkt. Pozwala to omin?? wi?kszo?? przeszk?d i uderzy? z du?? moc? w konkretny budynek. Niestety Merl jest absolutnie bezu?yteczny przeciwko mobilnym jednostkom.]],
  },

  damageModifier      = 1,
  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[tanklrarty]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 400,
  maxDamage           = 1100,
  maxSlope            = 18,
  maxVelocity         = 2.1,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[TANK3]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName          = [[core_diplomat.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:RED_STROBE]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  trackOffset         = 15,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 38,
  turnRate            = 440,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[CORTRUCK_ROCKET]],
      badTargetCategory  = [[SWIM LAND SHIP HOVER]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    CORTRUCK_ROCKET = {
      name                    = [[Cruise Missile]],
      areaOfEffect            = 64,
      cegTag                  = [[raventrail]],
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 850,
        planes  = 850,
        subs    = 42.5,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:STARFIRE]],
      fireStarter             = 100,
      flighttime              = 12,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[corvrocket]],
      noautorange             = [[1]],
      noSelfDamage            = true,
      range                   = 1500,
      reloadtime              = 10,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = false,
      soundHit                = [[OTAunit/XPLOMED4]],
      soundStart              = [[OTAunit/ROCKHVY1]],
      startsmoke              = [[1]],
      tolerance               = 4000,
      twoPhase                = true,
      vlaunch                 = true,
      weaponAcceleration      = 315,
      weaponTimer             = 2,
      weaponType              = [[StarburstLauncher]],
      weaponVelocity          = 10000,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Merl]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2200,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 400,
      object           = [[CORE_DIPLOMAT_DEAD]],
      reclaimable      = true,
      reclaimTime      = 400,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Merl]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 400,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 400,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Merl]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 200,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 200,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armmerl = unitDef })
