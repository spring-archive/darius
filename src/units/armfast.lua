unitDef = {
  unitname            = [[armfast]],
  name                = [[Zipper]],
  description         = [[Ultra Fast Stealth Raider]],
  acceleration        = 0.4,
  autoHeal            = 1,
  bmcode              = [[1]],
  brakeRate           = 2,
  buildCostEnergy     = 130,
  buildCostMetal      = 130,
  builder             = false,
  buildPic            = [[ARMFAST.png]],
  buildTime           = 130,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Agressor ultra rápido]],
    description_es = [[Invasor ultra-rápdio]],
    description_fi = [[Eritt?in nopea hy?kk??j?robotti]],
    description_fr = [[Pilleur Ultra Rapide]],
    description_it = [[Invasore ultra-veloce]],
    helptext       = [[The Zipper can zip past defences and destroy the structures inside your opponent's base. Use the sprint button to make it faster for a few seconds.]],
    helptext_bp    = [[Zipper ? umo robo agressor r?pido que pode correr atrav?s das defesas e destruir as estruturas dentro da base inimiga. Use o botao "sprint" para torna-lo mais r?pido por alguns segundos.]],
    helptext_es    = [[El Zipper puede pasar através de las defensas enemigas y destruir las estructuras en la base enemiga. Usa el botón "sprint" para hacerlo ir más rápido por algunos segundos.]],
    helptext_fi    = [[Nopealiikkeinen Zipper pystyy hetkellisesti kiihdytt?m??n puolustuslinjojen tai yksik?iden ohitse hy?k?t?kseen haavoittuvaisiin kohteisiin, kuten vihollisen resursseihin.]],
    helptext_fr    = [[Le Zipper peut se faufiler r toute vitesse au travers des défenses et détruire les structures enemies. Utilisez le boutton sprint pour le faire courire plus vite pendant quelque secondes]],
    helptext_it    = [[Il Zipper puo infilarsi tra le difese nemiche e distruggere le strutture dentro la base nemicha. Usa il bottone "sprint" per farlo andare piú rapido per alcuni secondi.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[SMALL_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[kbotraider]],
  idleAutoHeal        = 55,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 65,
  maxDamage           = 480,
  maxSlope            = 36,
  maxVelocity         = 8,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT2]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[ARMFAST]],
  seismicSignature    = 4,
  selfDestructAs      = [[SMALL_UNITEX]],
  side                = [[ARM]],
  sightDistance       = 390,
  smoothAnim          = true,
  stealth             = true,
  steeringmode        = [[1]],
  TEDClass            = [[KBOT]],
  turninplace         = 0,
  turnInPlace         = 0,
  turnRate            = 1250,
  upright             = true,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[ARMFAST_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    ARMFAST_WEAPON = {
      name                    = [[Laser]],
      areaOfEffect            = 8,
      beamlaser               = 1,
      beamTime                = 0.1,
      burstrate               = 0.2,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 32,
        planes  = 32,
        subs    = 1.6,
      },

      energypershot           = 0.2,
      explosionGenerator      = [[custom:FLASH1yellow2]],
      fireStarter             = 50,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      laserFlareSize          = 6.43,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 140,
      reloadtime              = 0.4,
      renderType              = 0,
      rgbColor                = [[1 1 0]],
      soundHit                = [[laserhit]],
      soundStart              = [[OTAunit/LASRFIR1]],
      soundTrigger            = true,
      targetMoveError         = 0.1,
      thickness               = 4.28952211790544,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 600,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Zipper]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 960,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 65,
      object           = [[ARMFAST_DEAD]],
      reclaimable      = true,
      reclaimTime      = 65,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Zipper]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 960,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 65,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 65,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Zipper]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 960,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 32.5,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 32.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armfast = unitDef })