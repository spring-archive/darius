weapons             = {

    {
      def                = [[Lightning]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    Lightning  = {
      name                    = [[Electro-Stunner]],
      areaOfEffect            = 1,
      beamWeapon              = true,
      collideFriendly         = true,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default        = 99999,
      },

      duration                = 8,
      energypershot           = 0,
      explosionGenerator      = [[custom:YELLOW_LIGHTNINGPLOSION]],
      fireStarter             = 0,
      heightMod               = 1,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 12,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      paralyzer               = true,
      paralyzeTime            =	%%PARALYZE%%,
      range                   = %%RANGE%%,
      reloadtime              = %%RELOADTIME%%,
      renderType              = 7,
      rgbColor                = [[1 1 0.25]],
      soundHit                = [[weapons/laser_hit]],
      soundStart              = [[weapons/laser_shoot]],
      soundTrigger            = true,
      targetMoveError         = 0.2,
      texture1                = [[lightning]],
      thickness               = 10,
      turret                  = true,
      weaponType              = [[LightingCannon]],
      weaponVelocity          = 450,
    },

  },