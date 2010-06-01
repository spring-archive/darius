unitDef = {
  unitname                      = [[dughole]],
  name                          = [[dug hole]],
  description                   = [[hole that was dug]],
  acceleration                  = 0,
  bmcode                        = [[0]],
  brakeRate                     = 0,
  buildAngle                    = 1024,
  buildCostEnergy               = 500,
  buildCostMetal                = 500,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 0.03,
  buildingGroundDecalSizeX      = 3,
  buildingGroundDecalSizeY      = 3,
  buildingGroundDecalType       = [[dughole.dds]],

  buildoptions                  = {
  },

  buildPic                      = [[ARMLAB.DDS]],
  buildTime                     = 500,
  category                      = [[SINK UNARMED]],
  footprintX                    = 1,
  footprintZ                    = 1,
  iconType                      = [[special]],
  idleAutoHeal                  = 5,
  idleTime                      = 1800,
  levelGround                   = false,
  mass                          = 100000,
  maxDamage                     = 3000,
  maxSlope                      = 255,
  maxVelocity                   = 0,
  maxWaterDepth                 = 0,
  minCloakDistance              = 150,
  noAutoFire                    = false,
  objectName                    = [[ARMMINE1]],
  seismicSignature              = 0,
  side                          = [[ARM]],
  sightDistance                 = 0,
  smoothAnim                    = true,
  TEDClass                      = [[PLANT]],
  turnRate                      = 0,
  useBuildingGroundDecal        = true,
  workerTime                    = 6,
}

return lowerkeys({ dughole = unitDef })