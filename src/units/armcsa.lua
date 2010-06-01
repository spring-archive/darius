unitDef = {
  unitname            = [[armcsa]],
  name                = [[Athena]],
  description         = [[Airborne SpecOps Engineer, Builds at 6 m/s]],
  acceleration        = 0.084,
  airStrafe           = 0,
  amphibious          = true,
  autoHeal            = 2,
  bankscale           = [[1.5]],
  bmcode              = [[1]],
  brakeRate           = 1.875,
  buildCostEnergy     = 500,
  buildCostMetal      = 500,
  buildDistance       = 60,
  builder             = true,

  buildoptions        = {
    [[armmex]],
    [[armsolar]],
    [[armwin]],
    [[armnanotc]],
    [[armrad]],
    [[armjamt]],
    [[armmine1]],
    [[armrl]],
    [[armllt]],
    [[armartic]],
    [[armdeva]],
    [[armdl]],
    [[armhlt]],
    [[armpb]],
    [[armcomdgun]],
    [[armraz]],
    [[armshock]],
    [[armbanth]],
    [[armorco]],
    [[armtide]],
    [[armsonar]],
    [[armtl]],
    [[arm_spider]],
    [[armpw]],
    [[armsptk]],
    [[armzeus]],
    [[armfast]],
    [[armsnipe]],
    [[armtick]],
    [[armspy]],
  },

  buildPic            = [[ARMCSA.png]],
  buildRange3D        = false,
  buildTime           = 500,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canreclamate        = [[1]],
  canstop             = [[1]],
  canSubmerge         = false,
  category            = [[GUNSHIP UNARMED]],
  cloakCost           = 10,
  cloakCostMoving     = 10,
  collide             = true,
  corpse              = [[HEAP]],
  cruiseAlt           = 80,

  customParams        = {
    description_fr = [[ADAV de Construcion Furtif Camouflable, Construit r 6 m/s]],
    helptext       = [[The Athena is the pinnacle of Nova's stealth strike capability. Equipped with a cloaking device and a radar jammer, it can slip through enemy lines to assemble squads of raiders, inflicting havoc on the opposition's logistics.]],
    helptext_fr    = [[Le Athena est un ingénieur de combat non armé. Équipé d'un brouilleur radar et d'un camouflage optique il peut construire certaines infrastructures et des unités nimporte ou, et ainsi surprendre l'enneme.]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  energyMake          = 0.15,
  energyUse           = 0,
  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[t3builder]],
  initCloaked         = false,
  maneuverleashlength = [[1280]],
  mass                = 250,
  maxDamage           = 200,
  maxSlope            = 36,
  maxVelocity         = 9.17,
  metalMake           = 0.15,
  minCloakDistance    = 50,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  objectName          = [[selene.s3o]],
  radarDistanceJam    = 300,
  scale               = [[0.8]],
  seismicDistance     = 300,
  seismicSignature    = 0,
  selfDestructAs      = [[GUNSHIPEX]],
  showNanoSpray       = false,
  side                = [[ARM]],
  sightDistance       = 380,
  smoothAnim          = true,
  stealth             = true,
  steeringmode        = [[1]],
  TEDClass            = [[VTOL]],
  terraformSpeed      = 300,
  turnRate            = 148,
  workerTime          = 6,

  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Athena]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 400,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 250,
      object           = [[selene_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 250,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Athena]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 400,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 250,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 250,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Athena]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 400,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 125,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armcsa = unitDef })