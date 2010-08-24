  weapons                = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs             = {

    LASER = {
      name                    = [[Laser Blaster]],
      areaOfEffect            = 24,
      beamWeapon              = true,
      canattackground         = true,
      cegTag                  = [[redlaser_llt]],
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = %%DAMAGE%%,
      },

      duration                = 0.02,
      energypershot           = 0.0,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_RED]],
      fireStarter             = 0,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      lodDistance             = 10000,
      noSelfDamage            = true,
      range                   = %%RANGE%%,
      reloadtime              = %%RELOADTIME%%,
      renderType              = 0,
      rgbColor                = [[1 0 0]],
      soundHit                = [[weapons/laserhit]],
      soundStart              = [[weapons/laser]],
      soundTrigger            = true,
      sweepfire               = false,
      targetMoveError         = 0.1,
      thickness               = 4.03112887414927,
      tolerance               = 5000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 1720,
    },

  }