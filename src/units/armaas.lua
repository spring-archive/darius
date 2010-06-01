unitDef = {
  unitname            = [[armaas]],
  name                = [[Archer]],
  description         = [[Anti-Air Frigate]],
  acceleration        = 0.048,
  bmcode              = [[1]],
  brakeRate           = 0.062,
  buildAngle          = 16384,
  buildCostEnergy     = 750,
  buildCostMetal      = 750,
  builder             = false,
  buildPic            = [[ARMAAS.png]],
  buildTime           = 750,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[SHIP]],
  corpse              = [[DEAD]],

  customParams        = {
    description_es = [[Fragata Anti-Aérea]],
    description_fr = [[Fr?gate Anti-Air]],
    description_it = [[Fregata Anti-Aerea]],
    helptext       = [[With its powerful AA Laser and rapid-fire missile launcher, the anti-air frigate protects your fleet from aerial attackers. As always, it is useless against targets that aren't airborne.]],
    helptext_es    = [[Con su poderoso laser AA y misiles a fuego rápido, la fragata anti-aérea protege tu flota de ataques aéreos. Como siempre, es inútil contra objetivos que no vuelan.]],
    helptext_fr    = [[Gr?ce ? ses puissants canons laser et ses lances missiles ultra-v?loces le Archer prot?gera votre flotte contre les danges du ciel. ]],
    helptext_it    = [[Con il suo potente laser anti-aereo e i suoi missili a fuoco rapido, la fregata anti-aerea protegge la tua flotta dagli attacchi aerei. come sempre, ? inutile contro obbiettivi che non volano.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[aaship]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 375,
  maxDamage           = 2360,
  maxVelocity         = 3.08,
  minCloakDistance    = 75,
  minWaterDepth       = 5,
  movementClass       = [[BOAT3]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM LAND SINK SHIP SATELLITE SWIM FLOAT SUB HOVER]],
  objectName          = [[ARMAAS]],
  radarDistance       = 1000,
  scale               = [[0.6]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],
  side                = [[ARM]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[SHIP]],
  turnRate            = 416,
  waterline           = 4,
  workerTime          = 0,

  weapons             = {

    {
      def               = [[BOGUS_MISSILE]],
      badTargetCategory = [[SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
    },


    {
      def                = [[GA2]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },


    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    BOGUS_MISSILE = {
      name                    = [[Missiles]],
      areaOfEffect            = 48,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 0,
      },

      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      metalpershot            = 0,
      range                   = 900,
      reloadtime              = 0.5,
      renderType              = 1,
      startVelocity           = 450,
      tolerance               = 9000,
      turnRate                = 33000,
      turret                  = true,
      weaponAcceleration      = 101,
      weaponTimer             = 0.1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 650,
    },


    GA2           = {
      name                    = [[AA2Missile]],
      areaOfEffect            = 64,
      canattackground         = false,
      craterBoost             = 1,
      craterMult              = 2,
      cylinderTargetting      = 1,

      damage                  = {
        default = 7,
        planes  = 70,
        subs    = 3.5,
      },

      energypershot           = 0,
      explosionGenerator      = [[custom:FLASH2]],
      fireStarter             = 72,
      flightTime              = 4,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[missile]],
      noSelfDamage            = true,
      range                   = 840,
      reloadtime              = 0.8,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[packohit]],
      soundStart              = [[packolau]],
      soundTrigger            = true,
      startsmoke              = [[1]],
      startVelocity           = 520,
      tolerance               = 9950,
      tracks                  = true,
      turnRate                = 68000,
      turret                  = true,
      weaponAcceleration      = 160,
      weaponTimer             = 5,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 820,
    },


    LASER         = {
      name                    = [[Anti-Air Laser Battery]],
      areaOfEffect            = 12,
      beamDecay               = 0.736,
      beamlaser               = 1,
      beamTime                = 0.01,
      beamttl                 = 15,
      canattackground         = false,
      canAttackGround         = 0,
      coreThickness           = 0.5,
      craterMult              = 0,
      cylinderTargetting      = 1,

      damage                  = {
        default = 2,
        planes  = 20,
        subs    = 1,
      },

      energypershot           = 0.15,
      explosionGenerator      = [[custom:flash_teal7]],
      fireStarter             = 100,
      impactOnly              = true,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      laserFlareSize          = 3.75,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      pitchtolerance          = 8192,
      range                   = 800,
      reloadtime              = 0.11,
      renderType              = 0,
      rgbColor                = [[0 1 1]],
      soundStart              = [[OTAunit/LASRFIR2]],
      soundStartVolume        = 3,
      thickness               = 2.5,
      tolerance               = 8192,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 2200,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Archer]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 4720,
      energy           = 0,
      featureDead      = [[DEAD2]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 375,
      object           = [[ARMAAS_DEAD]],
      reclaimable      = true,
      reclaimTime      = 375,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Archer]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4720,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 375,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 375,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Archer]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4720,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 187.5,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 187.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armaas = unitDef })
