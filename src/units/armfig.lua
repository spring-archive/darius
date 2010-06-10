unitDef = {
  unitname            = [[armfig]],
  name                = [[Swiftspear]],
  description         = [[Multirole Fighter]],
  amphibious          = true,
  buildCostEnergy     = 150,
  buildCostMetal      = 150,
  buildPic            = [[ARMFIG.png]],
  buildTime           = 150,
  canAttack           = true,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  canSubmerge         = false,
  category            = [[FIXEDWING]],
  collide             = false,
  corpse              = [[DEAD]],
  cruiseAlt           = 200,

  customParams        = {
    description_bp = [[Caça básico]],
    description_fr = [[Chasseur Multir?le]],
    helptext       = [[The Swiftspear can hit both land and air. It protects well again air units, but enemy AA and air superiority fighters will kill it quickly. It can harass land units relatively effectively in numbers.]],
    helptext_bp    = [[Este caça pode atacar unidades aéreas e terrestres e protege bem outras unidades contra unidades aéreas, mas é morto rapidamente por fogo anti-aéreo e caças de superioridade aérea. Funciona melhor contra unidades terrestres quando em grandes números.]],
    helptext_fr    = [[Le Swiftspear peut attaquer en l'air et au sol. Il est cependant moins efficace dans ces deux domaines que des unit?s d?di?es. Utilis? en nombre, il peut ?fficacement harrasser l'?nemi. ]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 2,
  footprintZ          = 2,
  frontToSpeed        = 0,
  iconType            = [[fighter]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  isFighter           = true,
  maneuverleashlength = [[1280]],
  mass                = 75,
  maxAcc              = 0.5,
  maxDamage           = 350,
  maxVelocity         = 13,
  minCloakDistance    = 75,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE SUB]],
  objectName          = [[hammerhead.s3o]],
  seismicSignature    = 0,
  selfDestructAs      = [[GUNSHIPEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:ffmuzzle]],
      [[custom:ffejector]],
      [[custom:ff_engine]],
      [[custom:FF_PUFF]],
      [[custom:ff_wingtips]],
    },

  },

  side                = [[ARM]],
  sightDistance       = 710,
  size                = [[1]],
  sizedecay           = [[0]],
  smoothAnim          = true,
  speedToFront        = 0,
  stages              = [[50]],
  TEDClass            = [[VTOL]],

  weapons             = {

    {
      def                = [[FREEDOM_FIGHTER_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 60,
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[ARMFIG_MISSILE]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    ARMFIG_MISSILE         = {
      name                    = [[Guided AA Missiles]],
      areaOfEffect            = 48,
      avoidFriendly           = true,
      canattackground         = false,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,
      cylinderTargetting      = 1,

      damage                  = {
        default = 20,
        planes  = [[200]],
        subs    = 10,
      },

      explosionGenerator      = [[custom:WEAPEXP_PUFF]],
      fireStarter             = 70,
      flightTime              = 3,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[wep_m_fury.s3o]],
      noSelfDamage            = true,
      range                   = 530,
      reloadtime              = 4.5,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOSML2]],
      soundStart              = [[OTAunit/ROCKLIT3]],
      startsmoke              = [[1]],
      startVelocity           = 200,
      tolerance               = 22000,
      tracks                  = true,
      turnRate                = 30000,
      weaponAcceleration      = 550,
      weaponTimer             = 5,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 750,
    },


    FREEDOM_FIGHTER_WEAPON = {
      name                    = [[Light EMG]],
      areaOfEffect            = 8,
      collideFriendly         = false,
      craterMult              = 0,

      damage                  = {
        default = 6,
        subs    = 0.3,
      },

      edgeEffectiveness       = 1,
      explosionGenerator      = [[custom:BRAWLIMPACTS]],
      fireStarter             = 10,
      impactOnly              = true,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      pitchtolerance          = [[18000]],
      range                   = 700,
      reloadtime              = 0.2,
      renderType              = 4,
      rgbColor                = [[1 0.95 0.5]],
      separation              = 2,
      size                    = 1,
      sizeDecay               = 0,
      soundStart              = [[flashemg]],
      soundTrigger            = true,
      stages                  = 50,
      startsmoke              = [[1]],
      sweepfire               = false,
      thickness               = 2,
      tolerance               = 8000,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 1000,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Swiftspear]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 700,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 75,
      object           = [[armfig_dead]],
      reclaimable      = true,
      reclaimTime      = 75,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Swiftspear]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 700,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 75,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 75,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Swiftspear]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 700,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 37.5,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 37.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armfig = unitDef })