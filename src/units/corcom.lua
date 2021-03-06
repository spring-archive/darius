unitDef = {
  unitname            = [[corcom]],
  name                = [[Commander]],
  description         = [[Commander, Builds at 12 m/s]],
  acceleration        = 0.18,
  activateWhenBuilt   = true,
  amphibious          = [[1]],
  autoHeal            = 5,
  bmcode              = [[1]],
  brakeRate           = 0.375,
  buildCostEnergy     = 1800,
  buildCostMetal      = 1800,
  buildDistance       = 120,
  builder             = true,

  buildoptions        = {
--  	[[pylon]],
--	[[mexpylon]],
    [[cormex]],
    [[corsolar]],
    [[corfus]],
    [[cafus]],
    [[corwin]],
    [[corgeo]],
    [[cormstor]],
    [[corestor]],
    [[cornanotc]],
    [[corasp]],
    [[corlab]],
    [[corvp]],
    [[coraap]],
    [[corap]],
    [[corfhp]],
    [[coralab]],
    [[coravp]],
    [[corsy]],
    [[corrad]],
    [[corarad]],
    [[corfmd]],
    [[corjamt]],
    [[corrl]],
    [[corllt]],
    [[corgrav]],
    [[corpre]],
    [[cordl]],
    [[corhlt]],
    [[corvipe]],
    [[cordoom]],
    [[corint]],
    [[corbhmth]],
    [[corbeac]],
    [[corrazor]],
    [[corflak]],
    [[screamer]],
    [[cortron]],
    [[corsilo]],
    [[corcsa]],
    [[cortide]],
    [[corsonar]],
    [[cortl]],
    [[coratl]],
    [[cormine1]],
  },

  buildPic            = [[corcom.png]],
  buildTime           = 1800,
  canAttack           = true,
  canDGun             = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canreclamate        = [[1]],
  canstop             = [[1]],
  category            = [[LAND FIREPROOF]],
  cloakCost           = 10,
  cloakCostMoving     = 50,
  commander           = true,
  corpse              = [[DEAD]],

  customParams        = {
    fireproof = [[1]],
  },

  defaultmissiontype  = [[Standby]],
  energyMake          = 3,
  energyStorage       = 0,
  energyUse           = 0,
  explodeAs           = [[ESTOR_BUILDINGEX]],
  footprintX          = 2,
  footprintZ          = 2,
  hideDamage          = true,
  iconType            = [[building]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  immunetoparalyzer   = [[1]],
  maneuverleashlength = [[640]],
  mass                = 2500,
  maxDamage           = 2500,
  maxSlope            = 36,
  maxVelocity         = 1.25,
  maxWaterDepth       = 5000,
  metalMake           = 3,
  metalStorage        = 0,
  minCloakDistance    = 100,
  movementClass       = [[SMALL]],
  moveState           = 0,
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  norestrict          = [[1]],
  objectName          = [[corcom.s3o]],
  seismicSignature    = 16,
  selfDestructAs      = [[ESTOR_BUILDINGEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:COMGATE]],
      [[custom:BEAMWEAPON_MUZZLE_RED]],
    },

  },

  showNanoSpray       = false,
  showPlayerName      = true,
  side                = [[HUMANS]],
  sightDistance       = 500,
  smoothAnim          = true,
  sonarDistance       = 300,
  steeringmode        = [[2]],
  TEDClass            = [[COMMANDER]],
  terraformSpeed      = 600,
  turnRate            = 1133,
  upright             = true,
  workerTime          = 12,

  weapons             = {

    [1] = {
      def                = [[FAKELASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    [3] = {
      def = [[DISINTEGRATOR]],
    },


    [4] = {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    DISINTEGRATOR = {
      name                    = [[Disintegrator]],
      areaOfEffect            = 36,
      avoidFeature            = false,
      avoidFriendly           = false,
      avoidNeutral            = false,
      commandfire             = true,
      craterBoost             = 1,
      craterMult              = 6,

      damage                  = {
        default    = 99999,
      },

      energypershot           = 0,
      explosionGenerator      = [[custom:DGUNTRACE]],
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      noExplode               = true,
      noSelfDamage            = true,
      range                   = 250,
      reloadtime              = 1,
      renderType              = 3,
      soundHit                = [[weapons/xplomas2]],
      soundStart              = [[weapons/disigun1]],
      soundTrigger            = true,
      tolerance               = 10000,
      turret                  = true,
      weaponTimer             = 4.2,
      weaponType              = [[DGun]],
      weaponVelocity          = 300,
    },


    FAKELASER     = {
      name                    = [[Fake Laser]],
      areaOfEffect            = 12,
      beamlaser               = 1,
      beamTime                = 0.1,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 0,
      },

      duration                = 0.11,
      edgeEffectiveness       = 0.99,
      explosionGenerator      = [[custom:flash1green]],
      fireStarter             = 70,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 5.53,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 250,
      reloadtime              = 0.11,
      renderType              = 0,
      rgbColor                = [[0 1 0]],
      soundHit                = [[weapons/burning]],
      soundStart              = [[weapons/build2]],
      soundTrigger            = true,
      targetMoveError         = 0.05,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 5.53,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 900,
    },


    LASER         = {
      name                    = [[Commander Laser]],
      areaOfEffect            = 12,
      beamWeapon              = true,
      canattackground         = true,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 27.75,
      },

      duration                = 0.02,
      edgeEffectiveness       = 0.99,
      explosionGenerator      = [[custom:COMLASERFLASH]],
      fireStarter             = 70,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      lodDistance             = 10000,
      noSelfDamage            = true,
      range                   = 300,
      reloadtime              = 0.2,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundHit                = [[weapons/laser_hit]],
      soundStart              = [[weapons/laser_shoot]],
      soundTrigger            = true,
      targetMoveError         = 0.05,
      thickness               = 4.74835497830564,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 1900,
    },

  },


  featureDefs         = {

    DEAD      = {
      description      = [[Wreckage - Commander]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 5000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 900,
      object           = [[CORCOM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 900,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2     = {
      description      = [[Debris - Commander]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 5000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[100]],
      metal            = 900,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 900,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP      = {
      description      = [[Debris - Commander]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 5000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[100]],
      metal            = 450,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 450,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    RIOT_HEAP = {
      description      = [[Commander Debris]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 20000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 500,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corcom = unitDef })
