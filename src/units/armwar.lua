unitDef = {
  unitname            = [[armwar]],
  name                = [[Warrior]],
  description         = [[Riot Bot]],
  acceleration        = 0.072,
  bmcode              = [[1]],
  brakeRate           = 0.238,
  buildCostEnergy     = 220,
  buildCostMetal      = 220,
  builder             = false,
  buildPic            = [[ARMWAR.png]],
  buildTime           = 220,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Robô dispersador]],
    description_es = [[Robot de alboroto]],
    description_fi = [[Mellakkarobotti]],
    description_fr = [[Robot ?meutier]],
    description_it = [[Robot da rissa]],
    helptext       = [[The Warrior's devastating heavy Energy Machine Gun is effective versus most enemy units, in particular raiders. It performs poorly versus static defense, so do not use it as an assault unit. Counter by staying out of their range, as they are slow.]],
    helptext_bp    = [[O Warrior ? um rob? dispesador. Sua devastadora metralhadora de energia ? efetiva contra a maioria das unidades, especialmente agressores. Ele ? ruim contra defesas, entao nao use como unidade de assaulto. Defenda-se deles mantendo-se fora de seu alcan?e, pois sao lentos. ]],
    helptext_es    = [[La devastante mitralleta de alta energía del Warrior es efectiva contra la mayoría de unidades enemigas, en particular las de invasión. No es muy efectivo contra la defensa inmóvil, así que no usarlo como unidad de asalto. Contrastalos con unidades de alcance mayor, porque son lentos.]],
    helptext_fi    = [[Warriorin korkeanopeuksiset plasmatykit tehoavat useimpia vihollisen yksik?it? vastaan. Warrior on erityisen hyv? kevyit? yksik?it? vastaan, muttei sovellu puolustusrakennuksia vastaan hy?kk??miseen hitaan liikkuvuutensa takia. Warriorin voittaa pysym?ll? sen kantaman ulkopuolella.]],
    helptext_fr    = [[La d?vastatrice mitrailleuse ? plasma lourde du Warrior est ?fficace contre la majorit? de ses enemis, en particulier les unit?s de raid. Il est tres peut ?fficace contre les d?fenses static, il faut donc ne pas l'utiliser en tant qu'unit? d'assaut. Contrez le en restant hors de sa port?e, ?tant donn? ca faible vitesse de mouvement.]],
    helptext_it    = [[La devastante mitraglia ad alta energia del Warrior é efficace contro la maggioranza delle unitá namiche, in particolare quelli da invasione. Non é molto efficace contro la difesa statica, sicché non usarlo come unitá d'assalto. Contrastali stando fuero dal loro raggio, siccome sono lenti.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[SMALL_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[kbotriot]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[1]],
  mass                = 110,
  maxDamage           = 880,
  maxSlope            = 36,
  maxVelocity         = 1.71,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT2]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[Spherewarrior.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[SMALL_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:WARMUZZLE]],
      [[custom:emg_shells_l]],
    },

  },

  side                = [[ARM]],
  sightDistance       = 330,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  turninplace         = 0,
  turnRate            = 770,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[WARRIOR_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    WARRIOR_WEAPON = {
      name                    = [[Heavy EMG]],
      accuracy                = 350,
      alphaDecay              = 0.7,
      areaOfEffect            = 96,
      burnblow                = true,
      burst                   = 3,
      burstrate               = 0.1,
      craterBoost             = 0.15,
      craterMult              = 0.3,

      damage                  = {
        default = 39,
        planes  = 39,
        subs    = 1.95,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:EMG_HIT_HE]],
      firestarter             = 70,
      impulseBoost            = 0,
      impulseFactor           = 0.2,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 270,
      reloadtime              = 0.52,
      renderType              = 4,
      rgbColor                = [[1 0.95 0.4]],
      separation              = 1.5,
      soundHit                = [[OTAunit/XPLOSML3]],
      soundStart              = [[flashemg]],
      stages                  = 10,
      targetMoveError         = 0.3,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 550,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Warrior]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1760,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 110,
      object           = [[spherewarrior_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 110,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Warrior]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1760,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 110,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 110,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Warrior]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1760,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 55,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 55,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armwar = unitDef })
