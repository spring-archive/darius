unitDef = {
  unitname            = [[armbrtha]],
  name                = [[Big Bertha]],
  description         = [[Strategic Plasma Cannon]],
  acceleration        = 0,
  antiweapons         = [[1]],
  bmcode              = [[0]],
  brakeRate           = 0,
  buildAngle          = 32700,
  buildCostEnergy     = 6000,
  buildCostMetal      = 6000,
  builder             = false,
  buildPic            = [[ARMBRTHA.png]],
  buildTime           = 6000,
  canAttack           = true,
  canstop             = [[1]],
  category            = [[SINK]],
  collisionVolumeTest = 1,
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Canon ? Plasma Strat?gique]],
    helptext       = [[The Bertha is a massive cannon that fires high-energy plasmoids across the map. Used appropriately, it can effectively suppress enemy operations from the safety of your base. Do not expect it to win battles alone for you, however.]],
    helptext_fr    = [[Le Big Bertha est un canon ? plasma lourd, tr?s lourd. Un seul impact de son tir peut r?duire ? n?ant plusieurs unit?s ou structures. Sa port?e de tir op?rationnelle est immense et n'?gale que son co?t de cr?ation et d'entretient. En effet chaque tir consomme 300 unit?s d'?nergie. Notez que le Big Bertha effectue des tirs tendus. Autrement dit, pensez ? le placer en hauteur, ou chaque colline servira de refuge ? l'ennemi.]],
  },

  defaultmissiontype  = [[GUARD_NOMOVE]],
  explodeAs           = [[ATOMIC_BLAST]],
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[defense]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  levelGround         = false,
  mass                = 3000,
  maxDamage           = 4200,
  maxSlope            = 18,
  maxVelocity         = 0,
  maxWaterDepth       = 0,
  minCloakDistance    = 150,
  noChaseCategory     = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName          = [[armbrtha]],
  seismicSignature    = 4,
  selfDestructAs      = [[ATOMIC_BLAST]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:ARMBRTHA_SHOCKWAVE]],
      [[custom:ARMBRTHA_SMOKE]],
      [[custom:ARMBRTHA_FLARE]],
    },

  },

  side                = [[HUMANS]],
  sightDistance       = 660,
  smoothAnim          = true,
  TEDClass            = [[FORT]],
  turnRate            = 0,
  workerTime          = 0,
  yardMap             = [[oooooooooooooooo]],
  
  sounds = {
    underattack = {
      "voices/unit_under_attack"
    },
    ok = {
      "voices/unit_selected"
    },
    select = {
      "voices/unit_selected"
    }
  },
  
  weapons             = {

    {
      def                = [[PLASMA]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    PLASMA = {
      name                    = [[Heavy Plasma Cannon]],
      accuracy                = 500,
      areaOfEffect            = 192,
      cegTag                  = [[vulcanfx]],
      craterBoost             = 0.25,
      craterMult              = 0.5,

      damage                  = {
        default = 2000,
        planes  = 2000,
      },

      energypershot           = 0,
      explosionGenerator      = [[custom:lrpc_expl]],
      holdtime                = [[1]],
      impulseBoost            = 0.5,
      impulseFactor           = 0.2,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 6200,
      reloadtime              = 7,
      renderType              = 4,
      soundHit                = [[weapons/lrpchit]],
      soundStart              = [[weapons/big_begrtha_gun_fire]],
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 1100,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Big Bertha]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 8400,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 3000,
      object           = [[ARMBRTHA_DEAD]],
      reclaimable      = true,
      reclaimTime      = 3000,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Big Bertha]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 8400,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 3000,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 3000,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Big Bertha]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 8400,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 1500,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 1500,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armbrtha = unitDef })
