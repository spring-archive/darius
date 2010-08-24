  weapons               = {

    {
      def                = [[GAS]],
      badTargetCategory  = [[FIREPROOF]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER GUNSHIP FIXEDWING]],
    },

  },


  weaponDefs            = {

    GAS = {
      name                    = [[Poison Gas]],
      areaOfEffect            = 200,
      avoidFeature            = false,
      collideFeature          = false,
      craterBoost             = 0,
      craterMult              = 0,
      damage                  = {
        default       = %%DAMAGE%%,
      },

      fireStarter             = 1000,
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
      sizeGrowth              = 3,
      soundTrigger            = true,
      tolerance               = 2500,
	  sprayAngle			  = 0,
	  texture1				  = [[poison]],
      turret                  = true,
      weaponType              = [[Flame]],
      weaponVelocity          = 100,
    },

  },
