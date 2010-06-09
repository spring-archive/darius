unitDef = {
  unitname            = [[corgol]],
  name                = [[Goliath]],
  description         = [[Very Heavy Tank Buster]],
  acceleration        = 0.018,
  bmcode              = [[1]],
  brakeRate           = 0.03,
  buildCostEnergy     = 1900,
  buildCostMetal      = 1900,
  builder             = false,
  buildPic            = [[corgol.png]],
  buildTime           = 1900,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND FIREPROOF]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Tanque dispersador pesado]],
    description_fr = [[Tank Émeutier Lourd]],
    fireproof      = [[1]],
    helptext       = [[The Goliath is the single heaviest tank on the field, a testament to Logos firepower. Its main gun is a hefty cannon designed to smash lesser tanks into oblivion, while mounted on the turret is a light flamethrower which quickly cooks anything that invades the Golly's privacy. However, it turns like a tub of water, and its short range makes it easy prey for advanced skirmishers, or air attacks.]],
    helptext_bp    = [[Goliath é o tanque mais pesado do jogo, uma prova do poder de fogo de Logos. Sua arma principal é um grande canh?o que acaba facilmente com unidades pequenas, e seu lança chamas pode destruir rapidamente qualquer coisa que se aproxime demais. Porém, ele manobra lentamente e seu curto alcançe o torna presa fácil para escaramuçadores e ataques aéreos.]],
    helptext_fr    = [[Le Goliath est tout simplement le plus gros tank jamais construit. Un blindage lourd, un énorme canon plasma r moyenne portée fera voler en éclat les ennemis apeurés tandis que son lance flamme s'occupera des plus téméraires. Le Goliath est facile r repérer, il ne laisse que des ruines derricre lui.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[tankskirm]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 950,
  maxDamage           = 12000,
  maxSlope            = 18,
  maxVelocity         = 2.05,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[TANK4]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[corgol_512.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:LARGE_MUZZLE_FLASH_FX]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 605,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  trackOffset         = 8,
  trackStrength       = 10,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 45,
  turnRate            = 200,
  workerTime          = 0,

  weapons             = {

    [1] = {
      def                = [[COR_GOL]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },


    [2] = {
      def                = [[CORGOL_FLAMETHROWER]],
      badTargetCategory  = [[FIREPROOF]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },


    [3] = {
      def                = [[DISINTEGRATOR]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    COR_GOL             = {
      name                    = [[Tankbuster Cannon]],
      areaOfEffect            = 32,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 1000,
        planes  = 1000,
        subs    = 50,
      },

      explosionGenerator      = [[custom:TESS]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 450,
      reloadtime              = 3.5,
      renderType              = 4,
      soundHit                = [[golgotha/supergun]],
      soundStart              = [[OTAunit/CANNHVY2]],
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 310,
    },


    CORGOL_FLAMETHROWER = {
      name                    = [[Flame Thrower]],
      areaOfEffect            = 64,
      avoidFeature            = false,
      collideFeature          = false,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default       = 2,
        flamethrowers = 0.4,
        planes        = 2,
        subs          = 0.001,
      },

      explosionGenerator      = [[custom:SMOKE]],
      fireStarter             = 100,
      flameGfxTime            = 1.6,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 0.1,
      interceptedByShieldType = 0,
      lineOfSight             = true,
      noExplode               = true,
      noSelfDamage            = true,
      range                   = 180,
      reloadtime              = 0.16,
      renderType              = 5,
      sizeGrowth              = 1.05,
      soundStart              = [[OTAunit/FLAMHVY1]],
      soundTrigger            = true,
      sprayAngle              = 50000,
      tolerance               = 2500,
      turret                  = true,
      weaponType              = [[Flame]],
      weaponVelocity          = 150,
    },


    DISINTEGRATOR       = {
      name                    = [[Tankbuster High-Energy Cannon]],
      areaOfEffect            = 15,
      craterBoost             = 1,
      craterMult              = 6,

      damage                  = {
        default = 300,
        planes  = 300,
        subs    = 30,
      },

      energypershot           = 300,
      explosionGenerator      = [[custom:DGUNTRACE]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      noExplode               = true,
      noSelfDamage            = true,
      range                   = 400,
      reloadtime              = 8,
      renderType              = 4,
      soundHit                = [[golgotha/supergun]],
      soundStart              = [[OTAunit/CANNHVY2]],
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[DGun]],
      weaponVelocity          = 350,
    },

  },


  featureDefs         = {

    DEAD       = {
      description      = [[Wreckage - Goliath]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 24000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 950,
      object           = [[golly_d.s3o]],
      reclaimable      = true,
      reclaimTime      = 950,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2      = {
      description      = [[Debris - Goliath]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 24000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 950,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 950,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    FLAME_HEAP = {
      description      = [[Wreckage]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 80000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 510,
      object           = [[debris4x4b.s3o]],
      reclaimable      = true,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP       = {
      description      = [[Debris - Goliath]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 24000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      hitdensity       = [[100]],
      metal            = 475,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 475,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corgol = unitDef })
