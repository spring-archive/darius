unitDef = {
  unitname            = [[corpre]],
  name                = [[Scorcher]],
  description         = [[Anti-Swarm Heat Ray (weaker at range)]],
  bmcode              = [[0]],
  buildCostEnergy     = 220,
  buildCostMetal      = 220,
  builder             = false,
  buildPic            = [[corpre.png]],
  buildTime           = 220,
  canAttack           = true,
  canstop             = [[1]],
  category            = [[FLOAT]],
  collisionVolumeTest = 1,
  corpse              = [[DEAD]],

  customParams        = {
    description_fr = [[Rayon ? Chaleur Anti-Nu?e]],
    helptext       = [[The Scorcher is armed with the Heat Ray. It is incredibly powerful close up, but unfortunately the beam gradually dissipates as it travels and loses most of its lethality at long range.]],
    helptext_fr    = [[Le Scorcheur est une tourelle ?quip?e d'un rayon ? chaleur dense. Une pr?cision instantan?e pour des d?g?ts croissant avec la proximit?, il est la d?fense absolue contre les nu?es de petits (et moins petit) ennemis.]],
  },

  defaultmissiontype  = [[GUARD_NOMOVE]],
  explodeAs           = [[MEDIUM_BUILDINGEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  healtime            = [[-1]],
  iconType            = [[defenseriot]],
  levelGround         = false,
  mass                = 110,
  maxDamage           = 1500,
  maxSlope            = 18,
  minCloakDistance    = 150,
  noAutoFire          = false,
  noChaseCategory     = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName          = [[corpre]],
  seismicSignature    = 4,
  selfDestructAs      = [[MEDIUM_BUILDINGEX]],
  shootme             = [[1]],
  side                = [[CORE]],
  sightDistance       = 473,
  TEDClass            = [[FORT]],
  workerTime          = 0,
  yardMap             = [[ooooooooo]],

  weapons             = {

    {
      def                = [[HEATRAY]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    HEATRAY = {
      name                    = [[Heat Ray]],
      accuracy                = 512,
      areaOfEffect            = 20,
      beamWeapon              = true,
      cegTag                  = [[HEATRAY_CEG]],
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 75,
        planes  = 75,
        subs    = 3.75,
      },

      duration                = 0.3,
      dynDamageExp            = 1,
      dynDamageInverted       = false,
      energypershot           = 0.75,
      explosionGenerator      = [[custom:HEATRAY_HIT]],
      fallOffRate             = 0.9,
      fireStarter             = 90,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      lodDistance             = 10000,
      noSelfDamage            = true,
      proximityPriority       = 4,
      range                   = 460,
      reloadtime              = 0.1,
      renderType              = 0,
      rgbColor                = [[1 0.1 0]],
      rgbColor2               = [[1 1 0.25]],
      soundStart              = [[Kargcant]],
      thickness               = 3.95284707521047,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 860,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Scorcher]],
      blocking         = true,
      category         = [[core_corpses]],
      damage           = 3000,
      featureDead      = [[DEAD2]],
      featurereclamate = [[smudge01]],
      footprintX       = 5,
      footprintZ       = 5,
      height           = [[25]],
      hitdensity       = [[100]],
      metal            = 110,
      object           = [[corpre_dead]],
      reclaimable      = true,
      reclaimTime      = 110,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Scorcher]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3000,
      featureDead      = [[HEAP]],
      featurereclamate = [[smudge01]],
      footprintX       = 5,
      footprintZ       = 5,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 110,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 110,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Scorcher]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 3000,
      featurereclamate = [[smudge01]],
      footprintX       = 5,
      footprintZ       = 5,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 55,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 55,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corpre = unitDef })
