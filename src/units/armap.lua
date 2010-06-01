unitDef = {
  unitname                      = [[armap]],
  name                          = [[Airplane Plant]],
  description                   = [[Produces Airplanes, Builds at 6 m/s]],
  acceleration                  = 0,
  activateWhenBuilt             = false,
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
    [[armca]],
    [[armfig]],
    [[armhawk]],
    [[armthund]],
    [[armpnix]],
    [[armstiletto_laser]],
    [[armcybr]],
    [[armawac]],
  },

  buildPic                      = [[ARMAP.png]],
  buildTime                     = 550,
  canMove                       = true,
  canPatrol                     = true,
  canstop                       = [[1]],
  category                      = [[SINK UNARMED]],
  collisionVolumeTest           = 1,
  corpse                        = [[DEAD]],

  customParams                  = {
    helptext = [[The Airplane Plant offers a variety of fixed-wing aircraft to suit your needs. Choose between multirole fighters that can double as light attackers or specialized interceptors, and between precision bombers for taking down specific targets or their saturation counterparts for destroying swarms.]],
    sortName = [[4]],
  },

  energyMake                    = 0.225,
  energyUse                     = 0,
  explodeAs                     = [[LARGE_BUILDINGEX]],
  footprintX                    = 8,
  footprintZ                    = 6,
  iconType                      = [[facair]],
  idleAutoHeal                  = 5,
  idleTime                      = 1800,
  isAirBase                     = true,
  mass                          = 275,
  maxDamage                     = 4000,
  maxSlope                      = 15,
  maxVelocity                   = 0,
  metalMake                     = 0.225,
  minCloakDistance              = 150,
  noAutoFire                    = false,
  objectName                    = [[ARMAP]],
  seismicSignature              = 4,
  selfDestructAs                = [[LARGE_BUILDINGEX]],
  showNanoSpray                 = false,
  side                          = [[ARM]],
  sightDistance                 = 273,
  smoothAnim                    = true,
  TEDClass                      = [[PLANT]],
  turnRate                      = 0,
  useBuildingGroundDecal        = true,
  workerTime                    = 6,
  yardMap                       = [[ooooooo ooooooo occccco occccco occccco occccco]],

  featureDefs                   = {

    DEAD  = {
      description      = [[Wreckage - Airplane Plant]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 8000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 7,
      footprintZ       = 6,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 275,
      object           = [[ARMAP_DEAD]],
      reclaimable      = true,
      reclaimTime      = 275,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Airplane Plant]],
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
      description      = [[Debris - Airplane Plant]],
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

return lowerkeys({ armap = unitDef })
