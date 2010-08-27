  weapons               = {

    {
      def                = [[FLAMETHROWER]],
      badTargetCategory  = [[FIREPROOF]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER GUNSHIP FIXEDWING]],
    },

  },


  weaponDefs            = {

    FLAMETHROWER = {
      name                    = [[Flame Thrower]],
      areaOfEffect            = 250,
	  avoidFriendly			  = false,
      avoidFeature            = false,
      collideFeature          = false,
      craterBoost             = 0,
      craterMult              = 0,
	  cegTag                  = [[fire1_burn1_flame1]],
      damage                  = {
        default       = %%DAMAGE%%,
      },

      explosionGenerator      = [[custom:SMOKE]],
      fireStarter             = 0,
      flameGfxTime            = 2.6,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 1.1,
      interceptedByShieldType = 0,
      lineOfSight             = true,
      noExplode               = true,
      noSelfDamage            = true,	 
      range                   = %%RANGE%%,
      reloadtime              = %%RELOADTIME%%,
      renderType              = 5,
      sizeGrowth              = 2.5,
      soundStart              = [[weapons/flamhvy1]],
      soundTrigger            = true,
      tolerance               = 2500,
	  sprayAngle			  = 50000,
      turret                  = true,
	  texture1				  = [[fire2]],
      weaponType              = [[Flame]],
      weaponVelocity          = 200,
    },

  },