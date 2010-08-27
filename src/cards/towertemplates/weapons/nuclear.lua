weapons             = {

    {
      def                = [[NUKE]],
      onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    NUKE = {
      name                    = [[Nuclear missile]],
	  avoidFriendly			  = true,
      areaOfEffect            = 300,
      craterBoost             = 0,
      craterMult              = 2,

      damage                  = {
        default = %%DAMAGE%%,
      },

	  explosionGenerator      = [[custom:NUKE_150]],
      fireStarter             = 70,
      flightTime              = 15,
      guidance                = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      model                   = [[wep_m_avalanche.s3o]],
      noSelfDamage            = true,
      predictBoost            = 1,
      range                   = %%RANGE%%,
      reloadtime              = %%RELOADTIME%%,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[.1]],
      smokeTrail              = true,
      soundHit                = [[weapons/xplosml2]],
      soundHitVolume          = 8,
      soundStart              = [[weapons/rocklit1]],
      soundStartVolume        = 7,
      startsmoke              = [[1]],
      startVelocity           = 370,
      tracks                  = false,
      trajectoryHeight        = 0.6,
      turret                  = true,
      weaponTimer             = 3,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 700,
    },

}