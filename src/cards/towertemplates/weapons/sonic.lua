  weapons               = {

    {
      def                = [[GAUSS]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
  },


  weaponDefs            = {

    GAUSS         = {
      name                    = [[Gauss Battery]],
	  avoidFriendly			  = false,
      alphaDecay              = 0.12,
      areaOfEffect            = 40,
      cegTag                  = [[gauss_tag_h]],
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = %%DAMAGE%%,
      },

      explosionGenerator      = [[custom:gauss_hit_h]],
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      minbarrelangle          = [[-15]],
      noExplode               = true,
      noSelfDamage            = true,
      range                   = %%RANGE%%,
      reloadtime              = %%RELOADTIME%%,
      renderType              = 4,
      rgbColor                = [[0 0.7 1]],
      separation              = 0.5,
      size                    = 0.8,
      sizeDecay               = -0.1,
      soundHit                = [[weapons/armcomhit]],
      soundStart              = [[weapons/armcomgun]],
      sprayangle              = 800,
      stages                  = 32,
      startsmoke              = [[1]],
      tolerance               = 4096,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 500,
    },
  },