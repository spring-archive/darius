unitDef = {
  unitname            = [[corhunt]],
  name                = [[Basshunter]],
  description         = [[Stealth Radar/Sonar Plane]],
  acceleration        = 0.06,
  altfromsealevel     = [[1]],
  amphibious          = true,
  bankscale           = [[1]],
  bmcode              = [[1]],
  brakeRate           = 3.75,
  buildCostEnergy     = 300,
  buildCostMetal      = 300,
  builder             = false,
  buildPic            = [[CORHUNT.png]],
  buildTime           = 300,
  canAttack           = false,
  canDropFlare        = false,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  canSubmerge         = false,
  category            = [[UNARMED FIXEDWING]],
  collide             = false,
  corpse              = [[HEAP]],
  cruiseAlt           = 190,
  defaultmissiontype  = [[VTOL_standby]],
  energyUse           = 1.5,
  explodeAs           = [[BIG_UNITEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[scoutplane]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[1280]],
  mass                = 150,
  maxDamage           = 1560,
  maxVelocity         = 14.3,
  minCloakDistance    = 75,
  moverate1           = [[8]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  objectName          = [[CORHUNT]],
  radarDistance       = 2400,
  seismicSignature    = 0,
  selfDestructAs      = [[BIG_UNITEX]],
  side                = [[CORE]],
  sightDistance       = 1330,
  smoothAnim          = true,
  sonarDistance       = 1200,
  stealth             = true,
  steeringmode        = [[1]],
  TEDClass            = [[VTOL]],
  turnRate            = 450,
  workerTime          = 0,

  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Basshunter]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 3120,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 150,
      object           = [[ARMHAM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 150,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Basshunter]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3120,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 150,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 150,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Basshunter]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3120,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 75,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 75,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corhunt = unitDef })
