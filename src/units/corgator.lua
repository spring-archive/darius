unitDef = {
  unitname            = [[corgator]],
  name                = [[Instigator]],
  description         = [[Raider Vehicle]],
  acceleration        = 0.05,
  bmcode              = [[1]],
  brakeRate           = 0.05,
  buildCostEnergy     = 130,
  buildCostMetal      = 130,
  builder             = false,
  buildPic            = [[corgator.png]],
  buildTime           = 130,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Veículo escaramuçador]],
    description_fr = [[V?hicule Pilleur]],
    helptext       = [[Capable of taking damage and dishing it out, the Instigator is a versatile unit that remains very useful for more than just raiding, though it pays the price in manueverability and in cost. Its regeneration dramatically decreases its losses vs inferior opposition- it is impossible to kill the gator with attrition. Though able to hold its own in combat, it is no match for anti-swarm or riot units or defenses.]],
    helptext_bp    = [[Instigator é um tanque agressor. ? capaz de aguentar dano considerável e muito versátil, mas n?o t?o ágil quanto outras unidades agressoras. Sua regeneraç?o rápida lhe dá vantagem em pequenos combates onde estiver em maior número. Embora capaz em combate, n?o é pareo para unidades e defesas dispersadoras.]],
    helptext_fr    = [[ Le Instigator est rapide et solide. ?quip? d'une mitrailleuse laser il saura faire face de lui m?me ? un combat et ses nano-robots auto r?g?nerants se chargeront de le remettre sur pied pour la suite. Particuli?rement allergique aux anti-nu?es et au ?meutiers.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[vehicleraider]],
  idleAutoHeal        = 10,
  idleTime            = 100,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 65,
  maxDamage           = 445,
  maxSlope            = 18,
  maxVelocity         = 3.65,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[TANK2]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[corgator_512.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:BEAMWEAPON_MUZZLE_RED]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 360,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  trackOffset         = 5,
  trackStrength       = 5,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 21,
  turninplace         = 0,
  turnRate            = 650,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[GATOR_LASERX]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    GATOR_LASERX = {
      name                    = [[Laser Blaster]],
      areaOfEffect            = 8,
      beamWeapon              = true,
      cegTag                  = [[redlaser_ak]],
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 16.59,
        planes  = 16.59,
        subs    = 0.829,
      },

      duration                = 0.02,
      energypershot           = 0,
      explosionGenerator      = [[custom:GATORLASERFLASH]],
      fireStarter             = 50,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 230,
      reloadtime              = 0.19,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundStart              = [[OTAunit/lasrlit3]],
      soundTrigger            = true,
      targetMoveError         = 0.15,
      thickness               = 3.76646385884692,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 1500,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Instigator]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 890,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 65,
      object           = [[gatorwreck.s3o]],
      reclaimable      = true,
      reclaimTime      = 65,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Instigator]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 890,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 65,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 65,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Instigator]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 890,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 32.5,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 32.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corgator = unitDef })
