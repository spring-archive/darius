weapons             = {

    {
      def                = [[ICE]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    ICE = {
      name                    = [[Ice Beam]],
	  avoidFriendly			  = false,
      areaOfEffect            = 40,
	  beamWeapon              = true,
      collideFriendly         = true,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default 	   = 99999,
      },

	  duration                = 8,
      energypershot           = 0,
      explosionGenerator      = [[custom:smoke2]],
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
      renderType              = 4,
	  rgbColor                = [[0.5 0.5 1]],
      soundHit                = [[weapons/xplomed3]],
      soundStart              = [[weapons/cannon1]],
	  soundTrigger            = true,
	  targetMoveError         = 0.2,
	  thickness               = 3,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 300,
    },

  },