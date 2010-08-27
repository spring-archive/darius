weapons             = {

    {
      def                = [[Sniper]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    Sniper = {
      name                    = [[Long Range Pulse Rifle]],
      areaOfEffect            = 1,
	  avoidFriendly			  = false,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = %%DAMAGE%%,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:smoke]],
      impactOnly              = false,
      impulseBoost            = 0,
      impulseFactor           = 0,
      intensity               = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noGap                   = true,
      noSelfDamage            = true,
      range                   = %%RANGE%%,
      reloadtime              = %%RELOADTIME%%,
      renderType              = 1,
      separation              = 0.5,
      sizeDecay               = 0,
      soundStart              = [[weapons/flashemg]],
      sprayAngle              = 1,
      startsmoke              = [[0]],
      tolerance               = 5000,
      turret                  = true,
      weaponTimer             = 0.1,
      weaponType              = [[Melee]],
      weaponVelocity          = 1,
    },

  },
