unitDef = {
  unitname              = [[random_comm]],
  name                  = [[Castle]],
  description           = [[Save me!]],
  acceleration          = 0,
  activateWhenBuilt     = false,
  amphibious            = [[1]],
  autoHeal              = 0,
  bmcode                = [[1]],
  brakeRate             = 0,
  buildCostEnergy       = 3000,
  buildCostMetal        = 3000,
  buildDistance         = 120,
  builder               = true,

  buildoptions          = {
  },

  buildPic              = [[random_comm.png]],
  buildTime             = 3000,
  canAttack             = false,
  canCapture            = false,
  canDGun               = false,
  canGuard              = false,
  canMove               = false,
  canPatrol             = false,
  canreclamate          = [[1]],
  canstop               = [[1]],
  captureSpeed          = 0,
  category              = [[LAND FIREPROOF]],
  cloakCost             = 10,
  cloakCostMoving       = 50,
  commander             = true,
  corpse                = [[DEAD]],

  customParams          = {
    fireproof = [[1]],
  },

  defaultmissiontype    = [[Standby]],
  energyMake            = 0,
  energyStorage         = 0,
  energyUse             = 0,
  explodeAs             = [[COMMANDER_BLAST]],
  footprintX            = 2,
  footprintZ            = 2,
  hideDamage            = true,
  iconType              = [[armcommander]],
  idleAutoHeal          = 0,
  idleTime              = 0,
  immunetoparalyzer     = [[1]],
  maneuverleashlength   = [[640]],
  mass                  = 2500,
  maxDamage             = 0,
  maxSlope              = 36,
  maxVelocity           = 0,
  maxWaterDepth         = 5000,
  metalMake             = 0,
  metalStorage          = 0,
  minCloakDistance      = 100,
  movementClass         = [[AKBOT2]],
  noChaseCategory       = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  norestrict            = [[1]],
  objectName            = [[box.3do]],
  reclaimable           = false,
  seismicSignature      = 16,
  selfDestructAs        = [[COMMANDER_BLAST]],
  selfDestructCountdown = 10,

  sfxtypes              = {

    explosiongenerators = {
      [[custom:COMGATE]],
    },

  },

  showPlayerName        = true,
  side                  = [[ARM]],
  sightDistance         = 500,
  smoothAnim            = true,
  sonarDistance         = 300,
  steeringmode          = [[2]],
  TEDClass              = [[COMMANDER]],
  terraformSpeed        = 600,
  turnRate              = 0,
  upright               = true,
  workerTime            = 12,

  weapons               = {
  },


  weaponDefs            = {
  },


  featureDefs           = {

    DEAD  = {
      description      = [[Wreckage - Castle]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1400,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 5,
      footprintZ       = 5,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 40,
      object           = [[CORUWADVMS_DEAD]],
      reclaimable      = true,
      reclaimTime      = 40,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Castle]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1400,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 5,
      footprintZ       = 5,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 40,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 40,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Castle]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1400,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 5,
      footprintZ       = 5,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 20,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 20,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


	RIOT_HEAP = {
      description      = [[Castle Debris]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 20000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 937.5,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ random_comm = unitDef })
