unitDef = {
  unitname               = [[corsktl]],
  name                   = [[Skuttle]],
  description            = [[Advanced Cloakable Crawling Bomb (Raider/Anti-Armor)]],
  acceleration           = 0.12,
  bmcode                 = [[1]],
  brakeRate              = 0.188,
  buildCostEnergy        = 550,
  buildCostMetal         = 550,
  builder                = false,
  buildPic               = [[CORSKTL.png]],
  buildTime              = 550,
  canAttack              = true,
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  canstop                = [[1]],
  category               = [[LAND]],
  cloakCost              = 5,
  cloakCostMoving        = 15,

  customParams           = {
    canjump        = [[1]],
    description_bp = [[Bomba rastejante avançada e camuflável]],
    description_fr = [[Bombe Rampante Avancée Camouflable]],
    helptext_bp    = [[]],
    helptext_fr    = [[Le Skuttle est une arme redoutable, il s'agit en fait d'un mine armée d'une tete nucléaire légcre, équipée d'un camouflage optique et d'un jetpack. Capable de se faufiler dans les endroits les plus inatendus, le souffle de son explosion est capable de faire des dégâts effroyables. Il se fera cependant détecter si il approche trop d'une cible ennemie. ]],
  },

  defaultmissiontype     = [[Standby]],
  explodeAs              = [[CORSKTL_DEATH]],
  fireState              = 0,
  footprintX             = 1,
  footprintZ             = 1,
  iconType               = [[jumpjetbomb]],
  idleAutoHeal           = 5,
  idleTime               = 1800,
  initCloaked            = true,
  kamikaze               = true,
  kamikazeDistance       = 25,
  kamikazeUseLOS 		 = true,
  maneuverleashlength    = [[140]],
  mass                   = 275,
  maxDamage              = 320,
  maxSlope               = 36,
  maxVelocity            = 1.5225,
  maxWaterDepth          = 15,
  minCloakDistance       = 150,
  movementClass          = [[KBOT1]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING LAND SINK SHIP SATELLITE SWIM GUNSHIP FLOAT SUB HOVER]],
  objectName             = [[CORSKTL]],
  seismicSignature       = 16,
  selfDestructAs         = [[CORSKTL_DEATH]],
  selfDestructCountdown  = 0,
  side                   = [[CORE]],
  sightDistance          = 280,
  smoothAnim             = true,
  stealth                = true,
  steeringmode           = [[1]],
  TEDClass               = [[KBOT]],
  turninplace            = 0,
  turnRate               = 1122,
  upright                = true,
  workerTime             = 0,
  wpri_badtargetcategory = [[VTOL]],

}

return lowerkeys({ corsktl = unitDef })
