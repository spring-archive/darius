unitDef = {
  unitname            = [[cormak]],
  name                = [[Outlaw]],
  description         = [[Riot Bot]],
  acceleration        = 0.099874,
  bmcode              = [[1]],
  brakeRate           = 0.12366,
  buildCostEnergy     = 250,
  buildCostMetal      = 250,
  builder             = false,
  buildPic            = [[cormak.png]],
  buildTime           = 250,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Robô dispersador]],
    description_es = [[Robot de alboroto]],
    description_fr = [[Robot ?meurier]],
    description_it = [[Robot da rissa]],
    helptext       = [[The Outlaw's job is simple: destroy anything that crosses its way. Its cannon shoots high speed, explosive projectiles that can fling away any small unit that isn't instantly killed. Survivors are finished off with the rapid-fire laser. Keep the Outlaw away from units that can out-range it: the heavy load of weapons and ammo it needs to carry make it slow and lightly armored.]],
    helptext_bp    = [[O trabalho do Outlaw é simples: Destruir tudo que atravessar seu caminho. Seu canh?o atira projéteis rápidos e explosivos que podem lançar longe qualquer unidade pequena que n?o morra na hora. Vítimas que n?o morrem s?o ent?o atingidas por sua arma secundária, uma metralhadora a laser. Mantenha-o longe de unidades que superam seu alcançe, pois ele é lento e um pouco instável.]],
    helptext_es    = [[El trabajo del Outlaw es simple: destruir qualquier cosa che encuentre en su camino. Su ca?on dispara proyéctiles explosivos de alta velocidad che hacen que las unidades peque?as che no sean destruidas inmediatamente salgan volando. Sobrevivientes son terminados por el láser de alto rato de fuego. Ten el Outlaw lejo de unidades con un alcance mayor: el peso de sus armas y municiones lo hace lento y con poca armadura.]],
    helptext_fr    = [[Le Outlow est l'?meutier par excellence. Son canon principal adapt? du Leveler tire des projectiles ? haute v?locit? projetant les ennemis en arri?re et infligeant de gros d?g?ts. Son deuxi?me canon est une adaptation du canon AK qui lui permet d'achever ses cibles rapidement. Son blindage et son armement en font une unit? solide mais lente et dont la port?e est le principal d?faut.]],
    helptext_it    = [[Il lavoro del Outlaw é semplice: distruggere tutto quello che si trova davanti. Il suo cannone spara proiettili esplosivi ad alta velocita che fanno volare via qualunque unitá piccola che non é distrutta immediatamente. Superstiti sono finiti dal laser ad alto rato di fuoco. Tieni lontano l'Outlaw da unitá con raggio maggiore: il peso delle armi ed munizione che porta lo fanno lento e con poca armatura.]],
  },

  defaultmissiontype  = [[Standby]],
  designation         = [[CP-CMAK]],
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[kbotriot]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[500]],
  mass                = 125,
  maxDamage           = 1100,
  maxSlope            = 36,
  maxVelocity         = 1.5,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[KBOT2]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[cormak]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:RAIDMUZZLE]],
      [[custom:LEVLRMUZZLE]],
      [[custom:RIOT_SHELL_L]],
      [[custom:BEAMWEAPON_MUZZLE_RED]],
    },

  },

  shootme             = [[1]],
  side                = [[CORE]],
  sightDistance       = 347,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  threed              = [[1]],
  trackOffset         = 0,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ComTrack]],
  trackWidth          = 22,
  turninplace         = 0,
  turnRate            = 1050,
  unitnumber          = [[3203]],
  upright             = true,
  version             = [[1.2]],
  workerTime          = 0,
  zbuffer             = [[1]],

  weapons             = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[RIOT]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    LASER = {
      name                    = [[Laser Blaster]],
      areaOfEffect            = 8,
      beamWeapon              = true,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 19,
        planes  = 19,
        subs    = 0.95,
      },

      duration                = 0.02,
      energypershot           = 0,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_RED]],
      fireStarter             = 30,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 260,
      reloadtime              = 0.2,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundHit                = [[laserhit]],
      soundStart              = [[OTAunit/lasrlit3]],
      soundStartVolume        = 0.3,
      soundTrigger            = true,
      targetMoveError         = 0.15,
      thickness               = 3.92905841137543,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 1040,
    },


    RIOT  = {
      name                    = [[Impulse Cannon]],
      areaOfEffect            = 144,
      burnblow                = true,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 190,
        planes  = 190,
        subs    = 9.5,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:FLASH64]],
      impulseBoost            = 0,
      impulseFactor           = 0.3,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 290,
      reloadtime              = 2.1,
      renderType              = 4,
      soundHit                = [[OTAunit/XPLOSML3]],
      soundStart              = [[openQuarz/sattck1]],
      startsmoke              = [[1]],
      targetMoveError         = 0.6,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 550,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Outlaw]],
      blocking         = true,
      catagory         = [[corcorpses]],
      damage           = 2200,
      featureDead      = [[DEAD2]],
      featurereclamate = [[smudge01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[10]],
      hitdensity       = [[23]],
      metal            = 125,
      object           = [[cormak_dead]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[all]],
    },


    DEAD2 = {
      description      = [[Debris - Outlaw]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      featureDead      = [[HEAP]],
      featurereclamate = [[smudge01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[4]],
      metal            = 125,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 125,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[all]],
    },


    HEAP  = {
      description      = [[Debris - Outlaw]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      featurereclamate = [[smudge01]],
      footprintX       = 2,
      footprintZ       = 2,
      hitdensity       = [[4]],
      metal            = 62.5,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 62.5,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[all]],
    },

  },

}

return lowerkeys({ cormak = unitDef })
