unitDef = {
  unitname            = [[corarch]],
  name                = [[Shredder]],
  description         = [[Anti-Air Frigate]],
  acceleration        = 0.042,
  bmcode              = [[1]],
  brakeRate           = 0.062,
  buildAngle          = 16384,
  buildCostEnergy     = 400,
  buildCostMetal      = 400,
  builder             = false,
  buildPic            = [[CORARCH.png]],
  buildTime           = 400,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[SHIP]],
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Fr?gate (Anti-Air)]],
    helptext       = [[With its powerful twin anti-air laser batteries, the anti-air frigate protects your fleet from aerial attackers. As always, it is useless against targets that aren't airborne.]],
    helptext_fr    = [[Le Shredder est ?quip? d'un puissant canon flak, capable de d?cimer les attaques aeriennes gr?ce ? une explosion ? fragmentation. Tr?s utile et moins cher qu'un Enforcer, il prot?ge efficacement toute les flottes.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[aaboat]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 200,
  maxDamage           = 2000,
  maxVelocity         = 2.84,
  minCloakDistance    = 75,
  minWaterDepth       = 5,
  movementClass       = [[BOAT3]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM LAND SINK SHIP SATELLITE SWIM FLOAT SUB HOVER]],
  objectName          = [[aaship.s3o]],
  radarDistance       = 1000,
  scale               = [[0.6]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],
  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[SHIP]],
  turnRate            = 400,
  waterline           = 4,
  workerTime          = 0,

  weapons             = {

    {
      def               = [[BOGUS_MISSILE]],
      badTargetCategory = [[SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
    },


    {
      def                = [[AALASER]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },


    {
      def                = [[AALASER]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    AALASER       = {
      name                    = [[Anti-Air Laser]],
      accuracy                = 256,
      areaOfEffect            = 8,
      beamWeapon              = true,
      canattackground         = false,
      collideFriendly         = false,
      coreThickness           = 0.5,
      craterMult              = 0,
      cylinderTargetting      = 1,

      damage                  = {
        default = 2.5,
        planes  = [[25]],
        subs    = 1.25,
      },

      duration                = 0.02,
      edgeEffectiveness       = 1,
      explosionGenerator      = [[custom:FLASH1RED]],
      fireStarter             = 10,
      impactOnly              = true,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      lodDistance             = 10000,
      pitchtolerance          = [[1000]],
      predictBoost            = 1,
      proximityPriority       = 4,
      range                   = 1040,
      reloadtime              = 0.18,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundHit                = [[laserhit]],
      soundStart              = [[laser]],
      soundTrigger            = true,
      startsmoke              = [[1]],
      thickness               = 2.25346954716499,
      tolerance               = 1000,
      turnRate                = 48000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 1500,
    },


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
      range                   = 800,
      reloadtime              = 0.5,
      renderType              = 1,
      startVelocity           = 450,
      tolerance               = 9000,
      turnRate                = 33000,
      turret                  = true,
      weaponAcceleration      = 101,
      weaponTimer             = 0.1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 2000,
    },


    FLAK          = {
      name                    = [[Flak Cannon]],
      accuracy                = 1000,
      areaOfEffect            = 64,
      burnblow                = true,
      canattackground         = false,
      color                   = 1,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 10,
        planes  = 100,
        subs    = 2.5,
      },

      edgeEffectiveness       = 0.85,
      explosionGenerator      = [[custom:FLAK_HIT_24]],
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      minbarrelangle          = [[-24]],
      noSelfDamage            = true,
      range                   = 900,
      reloadtime              = 0.4,
      renderType              = 4,
      soundHit                = [[flakhit]],
      soundStart              = [[flakfire]],
      startsmoke              = [[1]],
      turret                  = true,
      unitsonly               = [[1]],
      weaponTimer             = 1,
      weaponType              = [[Cannon]],
      weaponVelocity          = 2000,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Shredder]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 4000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 200,
      object           = [[CORARCH_DEAD]],
      reclaimable      = true,
      reclaimTime      = 200,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Shredder]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 200,
      object           = [[debris4x4b.s3o]],
      reclaimable      = true,
      reclaimTime      = 200,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Shredder]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 100,
      object           = [[debris4x4b.s3o]],
      reclaimable      = true,
      reclaimTime      = 100,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corarch = unitDef })
