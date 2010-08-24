weapons             = {

    {
      def                = [[WEAPON]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT GUNSHIP SHIP HOVER]],
    },

  },


  weaponDefs          = {

    WEAPON = {
      name                    = [[Blob]],
      areaOfEffect            = 100,
      burst                   = 3,
      burstrate               = 0.01,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = %%DAMAGE%%,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:green_goo]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = %%RANGE%%,
      reloadtime              = %%RELOADTIME%%,
      renderType              = 4,
      rgbColor                = [[0.2 0.6 0]],
      size                    = 8,
      sizeDecay               = 0,
      soundHit                = [[weapons/acid2]],
      soundStart              = [[weapons/acid]],
      sprayAngle              = 1024,
      startsmoke              = [[0]],
      tolerance               = 5000,
      turret                  = true,
      weaponTimer             = 0.2,
      weaponType              = [[Cannon]],
      weaponVelocity          = 400,
    },

  },