unitDef = {
  unitname               = [[armtick_mine]],
  name                   = [[Tick mine]],
  description            = [[All-Terrain EMP Crawling Bomb]],
  acceleration           = 0.18,
  bmcode                 = [[1]],
  brakeRate              = 0.6,
  buildCostEnergy        = 100,
  buildCostMetal         = 100,
  buildPic               = [[armtick.png]],
  buildTime              = 100,
  canAttack              = false,
  canGuard               = false,
  canMove                = false,
  canstop                = [[0]],
  cantBeTransported      = false,
  category               = [[SINK]],
  cloakCost              = 0.5,
  corpse                 = [[DEAD]],

  customParams           = {
    helptext = [[The Tick is an all terrain, EMP suicide bomber. Used skillfully it can be worth dozens of times its cost. Use it to paralyze defenses, heavy units, and tightly packed units armed with slow weapons. Other units can then eliminate the helpless enemies without risk. Counter with defenders and missile trucks, or single cheap units to set off a premature detonation.]],
  },

  designation            = [[ARM-PASPD2]],
  explodeAs              = [[ARMTICK_DEATH]],
  footprintX             = 1,
  footprintZ             = 1,
  iconType               = [[staticbomb]],
  initCloaked            = true,
  kamikaze               = true,
  kamikazeDistance       = 40,
  mass                   = 750,
  maxDamage              = 50,
  maxSlope               = 255,
  maxVelocity            = 0,
  maxWaterDepth          = 15,
  minCloakDistance       = 0,
  movementClass          = [[TKBOT1]],
  noChaseCategory        = [[FIXEDWING LAND SINK SHIP SATELLITE SWIM GUNSHIP FLOAT SUB HOVER]],
  objectName             = [[ARMTICK]],
  seismicSignature       = 16,
  selfDestructAs         = [[ARMTICK_DEATH]],
  selfDestructCountdown  = 0,
  shootme                = [[1]],
  side                   = [[ARM]],
  sightDistance          = 160,
  smoothAnim             = true,
  stealth                = true,
  steeringmode           = [[1]],
  TEDClass               = [[TANK]],
  threed                 = [[1]],
  turnRate               = 1500,
  wpri_badtargetcategory = [[VTOL]],
  yardMap                = [[o]],
  zbuffer                = [[1]],

  featureDefs            = {

    DEAD  = {
      description      = [[Wreckage - Tick mine]],
      blocking         = true,
      category         = [[arm_corpses]],
      damage           = 100,
      featureDead      = [[DEAD2]],
      featurereclamate = [[smudge01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 50,
      object           = [[armtick_dead]],
      reclaimable      = true,
      reclaimTime      = 50,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Tick mine]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 100,
      featureDead      = [[HEAP]],
      featurereclamate = [[smudge01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 50,
      object           = [[debris1x1b.s3o]],
      reclaimable      = true,
      reclaimTime      = 50,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Tick mine]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 100,
      featurereclamate = [[smudge01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 25,
      object           = [[debris1x1b.s3o]],
      reclaimable      = true,
      reclaimTime      = 25,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armtick_mine = unitDef })