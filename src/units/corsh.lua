unitDef = {
  unitname            = [[corsh]],
  name                = [[Scrubber]],
  description         = [[Fast Attack Hovercraft]],
  acceleration        = 0.12,
  bmcode              = [[1]],
  brakeRate           = 0.112,
  buildCostEnergy     = 110,
  buildCostMetal      = 110,
  builder             = false,
  buildPic            = [[CORSH.png]],
  buildTime           = 110,
  canAttack           = true,
  canGuard            = true,
  canHover            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[HOVER]],
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Hovercraft d'Attaque Éclair]],
    helptext       = [[The Scrubber is the Logos hover plant's scout. It provides a cheap, disposable method of getting intel, and can also hit economic targets of oppurtunity.]],
    helptext_fr    = [[Le Scrubber est petit, maniable, rapide et n'a qu'une faible puissance de feu. Idéal pour les attaques surprises depuis la mer, il surprendra bien des ennemis. Son blindage est cependant trop faible pour faire face r une quelquonque résistance. ]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[SMALL_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[hoverraider]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 55,
  maxDamage           = 230,
  maxSlope            = 36,
  maxVelocity         = 4.46,
  minCloakDistance    = 75,
  movementClass       = [[HOVER3]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[corsh.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[SMALL_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:HOVERS_ON_GROUND]],
      [[custom:BEAMWEAPON_MUZZLE_RED]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 500,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  turninplace         = 0,
  turnRate            = 615,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    LASER = {
      name                    = [[Laser Blaster]],
      areaOfEffect            = 8,
      beamWeapon              = true,
      cegTag                  = [[redlaser_ak]],
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 12,
        planes  = 12,
        subs    = 0.6,
      },

      duration                = 0.02,
      explosionGenerator      = [[custom:FLASH1nd]],
      fireStarter             = 50,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 230,
      reloadtime              = 0.2,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundStart              = [[OTAunit/lasrlit3]],
      soundTrigger            = true,
      targetMoveError         = 0.15,
      thickness               = 3.1224989991992,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 920,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Scrubber]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 460,
      energy           = 0,
      featureDead      = [[DEAD2]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 55,
      object           = [[CORSH_DEAD]],
      reclaimable      = true,
      reclaimTime      = 55,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Scrubber]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 460,
      energy           = 0,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 55,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 55,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Scrubber]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 460,
      energy           = 0,
      footprintX       = 3,
      footprintZ       = 3,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 27.5,
      object           = [[debris3x3a.s3o]],
      reclaimable      = true,
      reclaimTime      = 27.5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corsh = unitDef })
