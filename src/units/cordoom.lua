unitDef = {
  unitname            = [[cordoom]],
  name                = [[Doomsday Machine]],
  description         = [[Medium Range Defense Fortress]],
  acceleration        = 0,
  activateWhenBuilt   = true,
  bmcode              = [[0]],
  brakeRate           = 0,
  buildAngle          = 4096,
  buildCostEnergy     = 2600,
  buildCostMetal      = 2600,
  builder             = false,
  buildPic            = [[CORDOOM.png]],
  buildTime           = 2600,
  canAttack           = true,
  canstop             = [[1]],
  category            = [[SINK]],
  collisionVolumeTest = 1,
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Forteresse Arm?e]],
    helptext       = [[Armed with a heavy plasma cannon and a Heat Ray, the Doomsday Machine forms a focal defense point against enemy assault pushes. It can bunker down to survive attack by long-range artillery or air attacks, although it cannot fire its weapons while doing so.]],
    helptext_fr    = [[Arm?e d'un canon plasma lourd de moyenne port?e et d'un rayon ? chaleur la Doomday Machine ou DDM comme on la surnomme, est capable de faire face ? tous type de menace. Nu?e, unit?s blind?es voire aerienne si assez proche, tout y passe! Son prix relativement ?lev? en limite cependant l'usage.]],
  },

  damageModifier      = 0.25,
  explodeAs           = [[ESTOR_BUILDING]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[fixedtachyon]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  levelGround         = false,
  mass                = 1300,
  maxDamage           = 10000,
  maxSlope            = 18,
  maxVelocity         = 0,
  maxWaterDepth       = 0,
  minCloakDistance    = 150,
  noChaseCategory     = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName          = [[CORDOOM]],
  onoffable           = true,
  seismicSignature    = 4,
  selfDestructAs      = [[ESTOR_BUILDING]],
  side                = [[CORE]],
  sightDistance       = 780,
  smoothAnim          = true,
  TEDClass            = [[FORT]],
  turnRate            = 0,
  workerTime          = 0,
  yardMap             = [[ooooooooo]],

  weapons             = {

    {
      def                = [[PLASMA]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },


    {
      def                = [[HEATRAY]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    ATA     = {
      name                    = [[Tachyon Accelerator]],
      areaOfEffect            = 20,
      avoidFeature            = false,
      avoidNeutral            = false,
      beamlaser               = 1,
      beamTime                = 1,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 1,

      damage                  = {
        default = 3000,
        planes  = 3000,
        subs    = 150,
      },

      energypershot           = 150,
      explosionGenerator      = [[custom:megapartgunblue]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 0,
      largeBeamLaser          = true,
      laserFlareSize          = 11.93,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 950,
      reloadtime              = 6,
      renderType              = 0,
      rgbColor                = [[0.5 0.5 1]],
      soundHit                = [[OTAunit/XPLOSML3]],
      soundStart              = [[OTAunit/ANNIGUN1]],
      targetMoveError         = 0.3,
      texture1                = [[corelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 11.93,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 1500,
    },


    HEATRAY = {
      name                    = [[Heat Ray]],
      accuracy                = 512,
      areaOfEffect            = 20,
      beamWeapon              = true,
      cegTag                  = [[HEATRAY_CEG]],
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 75,
        planes  = 75,
        subs    = 3.75,
      },

      duration                = 0.3,
      dynDamageExp            = 1,
      dynDamageInverted       = false,
      energypershot           = 0.75,
      explosionGenerator      = [[custom:HEATRAY_HIT]],
      fallOffRate             = 0.9,
      fireStarter             = 90,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      lodDistance             = 10000,
      noSelfDamage            = true,
      proximityPriority       = 4,
      range                   = 430,
      reloadtime              = 0.1,
      renderType              = 0,
      rgbColor                = [[1 0.1 0]],
      rgbColor2               = [[1 1 0.25]],
      soundStart              = [[Kargcant]],
      thickness               = 3.95284707521047,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 860,
    },


    PLASMA  = {
      name                    = [[Heavy Plasma]],
      areaOfEffect            = 192,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 1200,
        planes  = 1200,
        subs    = 60,
      },

      edgeEffectiveness       = 0.7,
      explosionGenerator      = [[custom:FLASHSMALLBUILDINGEX]],
      fireStarter             = 99,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 700,
      reloadtime              = 3,
      renderType              = 4,
      soundHit                = [[OTAunit/XPLOLRG3]],
      soundStart              = [[OTAunit/XPLONUK3]],
      sprayangle              = 1024,
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 750,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Doomsday Machine]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 20000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 1300,
      object           = [[CORDOOM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 1300,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Doomsday Machine]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 20000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 1300,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 1300,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Doomsday Machine]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 20000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 650,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 650,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ cordoom = unitDef })
