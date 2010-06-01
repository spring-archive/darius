unitDef = {
  unitname            = [[corawac]],
  name                = [[Vulture]],
  description         = [[Stealth Radar/Sonar Plane]],
  altfromsealevel     = [[1]],
  amphibious          = true,
  buildCostEnergy     = 340,
  buildCostMetal      = 340,
  builder             = false,
  buildPic            = [[CORAWAC.png]],
  buildTime           = 340,
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
  cruiseAlt           = 250,

  customParams        = {
    description_bp = [[Avi?o invisível a radar com radar e sonar]],
    description_fr = [[Avion Sonar/Radar Furtif]],
    helptext_bp    = [[Este avi?o possui radar, sonar e um grande raio de vis?o, e desta forma pode encontrar inimigos escondidos com maior facilidade que a maioria das unidades batedoras.]],
    helptext_fr    = [[Summum de la technologie d'information, ses multiples capteurs vous renseigneront sur toutes les activit?s ennemies: terrestre aerienne ou sousmarine.]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  energyUse           = 1.5,
  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[radarplane]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[1280]],
  mass                = 170,
  maxAcc              = 0.5,
  maxDamage           = 890,
  maxVelocity         = 11,
  minCloakDistance    = 75,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  objectName          = [[armpnix.s3o]],
  radarDistance       = 2400,
  scale               = [[1]],
  seismicSignature    = 0,
  selfDestructAs      = [[GUNSHIPEX]],
  side                = [[CORE]],
  sightDistance       = 1250,
  smoothAnim          = true,
  sonarDistance       = 1200,
  stealth             = true,
  TEDClass            = [[VTOL]],
  workerTime          = 0,

  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Vulture]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1780,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 170,
      object           = [[ARMHAM_DEAD]],
      reclaimable      = true,
      reclaimTime      = 170,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Vulture]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1780,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 170,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 170,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Vulture]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1780,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 85,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 85,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corawac = unitDef })
