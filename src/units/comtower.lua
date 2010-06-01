unitDef = {
  unitname            = [[comtower]],
  name                = [[Command Tower]],
  description         = [[Commands!, Builds at 12 m/s]],
  acceleration        = 0,
  activateWhenBuilt   = true,
  brakeRate           = 1.5,
  buildCostEnergy     = 2200,
  buildCostMetal      = 2200,
  buildDistance       = 800,
  builder             = true,

  buildoptions        = {
    [[armmex]],
    [[armsolar]],
    [[armfus]],
    [[armgeo]],
    [[aafus]],
    [[armwin]],
    [[armmstor]],
    [[armestor]],
    [[armnanotc]],
    [[armasp]],
    [[armlab]],
    [[armvp]],
    [[armaap]],
    [[armap]],
    [[armfhp]],
    [[armalab]],
    [[armavp]],
    [[armsy]],
    [[armrad]],
    [[armarad]],
    [[armamd]],
    [[armjamt]],
    [[armrl]],
    [[armllt]],
    [[armartic]],
    [[armdeva]],
    [[armdl]],
    [[armhlt]],
    [[armpb]],
    [[armanni]],
    [[armbrtha]],
    [[mahlazer]],
    [[armarch]],
    [[armcir]],
    [[armemp]],
    [[mercury]],
    [[armsilo]],
    [[armcsa]],
    [[armtide]],
    [[armsonar]],
    [[armtl]],
    [[armatl]],
    [[armmine1]],
  },

  buildPic            = [[comtower.png]],
  buildTime           = 2200,
  canGuard            = true,
  canMove             = false,
  canPatrol           = true,
  canreclamate        = [[1]],
  canstop             = [[1]],
  cantBeTransported   = true,
  category            = [[FLOAT UNARMED]],
  corpse              = [[DEAD]],
  defaultmissiontype  = [[Standby]],
  energyMake          = 7.2,
  explodeAs           = [[ESTOR_BUILDINGEX]],
  floater             = true,
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[staticbuilder]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  levelGround         = false,
  maneuverleashlength = [[380]],
  mass                = 100000,
  maxDamage           = 5000,
  maxSlope            = 15,
  maxVelocity         = 0,
  metalMake           = 3,
  minCloakDistance    = 150,
  movementClass       = [[KBOT1]],
  noAutoFire          = false,
  objectName          = [[comtower.s3o]],
  onoffable           = true,
  seismicSignature    = 4,
  selfDestructAs      = [[ESTOR_BUILDINGEX]],
  showNanoSpray       = false,
  side                = [[ARM]],
  sightDistance       = 380,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[CNSTR]],
  terraformSpeed      = 600,
  turnRate            = 1,
  upright             = true,
  workerTime          = 12,

  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Command Tower]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 10000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 1100,
      object           = [[ARMANNI_DEAD]],
      reclaimable      = true,
      reclaimTime      = 1100,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Command Tower]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 10000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 1100,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 1100,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Command Tower]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 10000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 550,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 550,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ comtower = unitDef })