unitDef = {
  unitname            = [[corbtrans]],
  name                = [[Vindicator]],
  description         = [[Armed Heavy Air Transport]],
  acceleration        = 0.2,
  amphibious          = true,
  antiweapons         = [[1]],
  bankscale           = [[1]],
  bmcode              = [[1]],
  brakeRate           = 6.25,
  buildCostEnergy     = 500,
  buildCostMetal      = 500,
  builder             = false,
  buildPic            = [[corbtrans.png]],
  buildTime           = 500,
  canAttack           = true,
  canFly              = true,
  canGuard            = true,
  canload             = [[1]],
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  canSubmerge         = false,
  category            = [[GUNSHIP]],
  collide             = false,
  copyright           = [[Copyright 1997 Humongous Entertainment. All rights reserved.]],
  corpse              = [[HEAP]],
  cruiseAlt           = 250,

  customParams        = {
    description_bp = [[Transporte aéreo pesado armado]],
    description_fr = [[Transport Aerien Arm? Lourd]],
    helptext       = [[Vindicator means bad news in the Nova dialect. Shoot at the dropship and it will shoot back with its two rapid-fire laser guns. Kill it and it will release its deadly cargo, thanks to a cargo ejection mechanism.]],
    helptext_bp    = [[Essa aeronave de transporte é resistente o suficiente para aguentar algum fogo anti-aéreo e vem armada com canh?es laser que dispara contra aquilo que a ataca. Se for destruída durante o voo sua carga é ejetada e com sorte pousa em segurança. ]],
    helptext_fr    = [[Le Vindicator est le summum du transport aerien. Rapide et puissant il peut transporter toutes vos unit?s sur le champ de bataille, il riposte aux tirs gr?ce ? ses multiples canons laser, et s'il est abattu, il ejecte sa livraison au sol avant d'exploser.]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  designation         = [[AFD-T4]],
  downloadable        = [[1]],
  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 4,
  footprintZ          = 4,
  frenchdescription   = [[Avion de transport lourd]],
  frenchname          = [[Vindicator]],
  germandescription   = [[Schwerer Lufttransporter]],
  germanname          = [[Vindicator]],
  iconType            = [[airtransport]],
  idleAutoHeal        = 5,
  idleTime            = 3000,
  maneuverleashlength = [[1280]],
  mass                = 250,
  maxDamage           = 1100,
  maxVelocity         = 8,
  minCloakDistance    = 75,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[CORBTRANS]],
  releaseHeld         = true,
  scale               = [[0.8]],
  seismicSignature    = 0,
  selfDestructAs      = [[GUNSHIPEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:VINDIMUZZLE]],
      [[custom:VINDIBACK]],
      [[custom:BEAMWEAPON_MUZZLE_RED]],
    },

  },

  shootme             = [[1]],
  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[VTOL]],
  transportCapacity   = 1,
  transportSize       = 25,
  turnInPlace         = 0,
  turnRate            = 420,
  unitnumber          = [[2345]],
  version             = [[1]],
  verticalSpeed       = 30,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    LASER = {
      name                    = [[Light Laser Blaster]],
      areaOfEffect            = 8,
      avoidFeature            = false,
      beamWeapon              = true,
      collideFriendly         = false,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 7,
        subs    = 0.35,
      },

      duration                = 0.02,
      energypershot           = 0,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_RED]],
      fireStarter             = 50,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 350,
      reloadtime              = 0.2,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundHit                = [[laserhit]],
      soundStart              = [[OTAunit/lasrlit3]],
      soundTrigger            = true,
      targetMoveError         = 0.15,
      thickness               = 2.38484800354236,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 2400,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Vindicator]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2200,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 250,
      object           = [[ARMHAM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 250,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Vindicator]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 250,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 250,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Vindicator]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 125,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corbtrans = unitDef })
