unitDef = {
  unitname            = [[consul]],
  name                = [[Consul]],
  description         = [[Construction Vehicle, Builds at 9 m/s]],
  acceleration        = 0.0825,
  bmcode              = [[1]],
  brakeRate           = 0.1375,
  buildCostEnergy     = 250,
  buildCostMetal      = 250,
  buildDistance       = 180,
  builder             = true,

  buildoptions        = {
  },

  buildPic            = [[CONSUL.png]],
  buildTime           = 250,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canreclamate        = [[1]],
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Veículo de construç?o, constrói a 9 m/s]],
    description_fr = [[V?hicule de construction, Construit ? 9 m/s]],
    helptext       = [[The Consul's jaws are more than just a decoration or a primitive building tool - they house a powerful electric weapon that stuns attackers who would find this otherwise docile constructor easy prey.]],
    helptext_bp    = [[As presas do Consul s?o mais que uma decoraç?o ou ferramenta de construç?o primitiva. Elas cont?m uma poderosa arma elétrica que paraliza inimigos e portanto servem de defesa n?o só para o própio consul mas tamb?m para o local onde estiver.]],
    helptext_fr    = [[Les machoires du Consuls sont plus qu'une d?coration. Elles cachent un canon ? energie EMP qui saura faire comprendre ? ses ennemis qu'il est est bien plus qu'une proie facile sans d?fence.]],
  },

  defaultmissiontype  = [[Standby]],
  energyMake          = 0.225,
  energyUse           = 0,
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[builder]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 125,
  maxDamage           = 2000,
  maxSlope            = 18,
  maxVelocity         = 2.2,
  maxWaterDepth       = 22,
  metalMake           = 0.225,
  minCloakDistance    = 75,
  movementClass       = [[TANK3]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[CONSUL]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],
  showNanoSpray       = false,
  side                = [[ARM]],
  sightDistance       = 325,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[CNSTR]],
  terraformSpeed      = 450,
  trackOffset         = 6,
  trackStrength       = 5,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 31,
  turnRate            = 720,
  workerTime          = 9,

  weapons             = {

    {
      def                = [[consulbite]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    consulbite  = {
      name                    = [[Mini Electro-Stunner]],
      areaOfEffect            = 16,
      beamWeapon              = true,
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default        = 600,
        commanders     = 60,
        empresistant75 = 150,
        empresistant99 = 6,
        planes         = 6,
      },

      duration                = 8,
      energypershot           = 3,
      explosionGenerator      = [[custom:YELLOW_LIGHTNINGPLOSION]],
      fireStarter             = 0,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 6,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      paralyzer               = true,
      paralyzeTime            = 5,
      range                   = 220,
      reloadtime              = 3,
      renderType              = 7,
      rgbColor                = [[1 1 0.25]],
      soundHit                = [[OTAunit/Lashit]],
      soundStart              = [[OTAunit/LGHTHVY1]],
      soundTrigger            = true,
      targetMoveError         = 0.2,
      texture1                = [[lightning]],
      thickness               = 6,
      turret                  = true,
      weaponType              = [[LightingCannon]],
      weaponVelocity          = 450,
    },


    consulbite2 = {
      name                    = [[lazer]],
      areaOfEffect            = 10,
      beamWeapon              = true,
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 6,
        planes  = 6,
        subs    = 0.3,
      },

      duration                = 0.0025,
      energypershot           = 0,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0,
      interceptedByShieldType = 0,
      lineOfSight             = true,
      noradar                 = [[1]],
      noSelfDamage            = true,
      range                   = 440,
      reloadtime              = 2.5,
      renderType              = 7,
      rgbColor                = [[1 1 1]],
      targetMoveError         = 0.2,
      thickness               = 0,
      turret                  = true,
      weaponType              = [[LightingCannon]],
      weaponVelocity          = 450,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Consul]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 4000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 125,
      object           = [[CONSUL_DEAD]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Consul]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 125,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Consul]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 62.5,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 62.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ consul = unitDef })