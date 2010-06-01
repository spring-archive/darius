unitDef = {
  unitname                      = [[armvp]],
  name                          = [[Light Vehicle Factory]],
  description                   = [[Produces light Vehicles, Builds at 6 m/s]],
  acceleration                  = 0,
  bmcode                        = [[0]],
  brakeRate                     = 0,
  buildCostEnergy               = 550,
  buildCostMetal                = 550,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 0.01,
  buildingGroundDecalSizeX      = 9,
  buildingGroundDecalSizeY      = 7,
  buildingGroundDecalType       = [[asphalt512.dds]],

  buildoptions                  = {
    [[pioneer]],
    [[armfav]],
    [[armflash]],
    [[armsam]],
    [[tawf013]],
    [[armstump]],
    [[armjanus]],
  },

  buildPic                      = [[ARMVP.png]],
  buildTime                     = 550,
  canMove                       = true,
  canPatrol                     = true,
  canstop                       = [[1]],
  category                      = [[SINK UNARMED]],
  collisionVolumeTest           = 1,
  corpse                        = [[DEAD]],

  customParams                  = {
    description_es = [[Fábrica de vehículos ligeros]],
    description_it = [[Fabbrica di veicoli leggeri]],
    helptext       = [[With its agile tanks and lethal skirmishers, the Nova Vehicle Plant is the factory of choice for mobile assault, especially on wide open maps. It particularly excels in moving engagements against slow assault or riot forces. Key Units: Flash, Stumpy, Samson, Janus]],
    helptext_es    = [[Con sus tanques ágiles y sus escaramuzadores letales, la fábrica de vehículos Nova es la mejor fábrica para el asalto móbil, espcialmente en mapas con espacios abiertos. Sobresale más en batalles móbiles contra unidades lentas de asalto u unidades de alboroto.]],
    helptext_it    = [[Con i suoi carri armati agili e quelli da scaramuccia, la fabbrica di veicoli Nova ? la fabbrica di scelta per l'assalto mobile, specialmente in mappen con spazi aperti. Eccele in battaglie mobili contro unitá d'assalto lente e da rissa.]],
    sortName       = [[2]],
  },

  energyMake                    = 0.15,
  energyUse                     = 0,
  explodeAs                     = [[LARGE_BUILDINGEX]],
  footprintX                    = 7,
  footprintZ                    = 7,
  iconType                      = [[facvehicle]],
  idleAutoHeal                  = 5,
  idleTime                      = 1800,
  mass                          = 275,
  maxDamage                     = 4000,
  maxSlope                      = 15,
  maxVelocity                   = 0,
  maxWaterDepth                 = 0,
  metalMake                     = 0.15,
  minCloakDistance              = 150,
  noAutoFire                    = false,
  objectName                    = [[cremfactory.s3o]],
  seismicSignature              = 4,
  selfDestructAs                = [[LARGE_BUILDINGEX]],
  showNanoSpray                 = false,
  side                          = [[ARM]],
  sightDistance                 = 273,
  smoothAnim                    = true,
  sortbias                      = [[0]],
  TEDClass                      = [[PLANT]],
  turnRate                      = 0,
  useBuildingGroundDecal        = true,
  workerTime                    = 6,
  yardMap                       = [[ooooooo ooooooo ooooooo oocccoo oocccoo oocccoo oocccoo]],

  featureDefs                   = {

    DEAD  = {
      description      = [[Wreckage - Light Vehicle Factory]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 8000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 6,
      footprintZ       = 6,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 275,
      object           = [[cremfactorywreck.s3o]],
      reclaimable      = true,
      reclaimTime      = 275,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Light Vehicle Factory]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 8000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 6,
      footprintZ       = 6,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 275,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 275,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Light Vehicle Factory]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 8000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 6,
      footprintZ       = 6,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 137.5,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 137.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armvp = unitDef })