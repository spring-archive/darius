unitDef = {
  unitname           = [[corape]],
  name               = [[Rapier]],
  description        = [[Raider Gunship]],
  acceleration       = 0.152,
  amphibious         = true,
  bankscale          = [[1]],
  bmcode             = [[1]],
  brakeRate          = 3.563,
  buildCostEnergy    = 300,
  buildCostMetal     = 300,
  builder            = false,
  buildPic           = [[CORAPE.png]],
  buildTime          = 300,
  canAttack          = true,
  canFly             = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = [[1]],
  canSubmerge        = false,
  category           = [[GUNSHIP]],
  collide            = true,
  corpse             = [[DEAD]],
  cruiseAlt          = 100,

  customParams       = {
    description_bp = [[Aeronave flutuadora agressora]],
    description_fr = [[ADAV Pilleur]],
    helptext       = [[Logos' light raider gunship. Its missiles are accurate and hit air, and it is good against small targets and defending against other raiders.]],
    helptext_bp    = [[A aeronave flutuante agressora leve de Logos. Seus mísseis s?o precisos e pode atingir o ar, tornando-a útil contra alvos pequenos e outras aeronaves agressoras.]],
    helptext_fr    = [[des missiles pr?cis et une vitesse de vol appr?ciable, le Rapier saura vous d?fendre contre d'autres pilleurs ou mener des assauts rapides.]],
  },

  defaultmissiontype = [[VTOL_standby]],
  explodeAs          = [[GUNSHIPEX]],
  floater            = true,
  footprintX         = 3,
  footprintZ         = 3,
  hoverAttack        = true,
  iconType           = [[gunship]],
  idleAutoHeal       = 5,
  idleTime           = 1800,
  mass               = 150,
  maxDamage          = 1100,
  maxVelocity        = 5.39,
  minCloakDistance   = 75,
  noAutoFire         = false,
  noChaseCategory    = [[TERRAFORM SATELLITE SUB]],
  objectName         = [[corape.s3o]],
  scale              = [[1]],
  seismicSignature   = 0,
  selfDestructAs     = [[GUNSHIPEX]],

  sfxtypes           = {

    explosiongenerators = {
      [[custom:rapiermuzzle]],
    },

  },

  side               = [[CORE]],
  sightDistance      = 550,
  smoothAnim         = true,
  steeringmode       = [[1]],
  TEDClass           = [[VTOL]],
  turnRate           = 594,
  workerTime         = 0,

  weapons            = {

    {
      def                = [[VTOL_ROCKET]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs         = {

    VTOL_ROCKET = {
      name                    = [[Light Homing Missiles]],
      areaOfEffect            = 16,
      avoidFeature            = false,
      burnblow                = true,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 100,
        subs    = 5,
      },

      explosionGenerator      = [[custom:DEFAULT]],
      fireStarter             = 70,
      flightTime              = 2.2,
      guidance                = true,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      model                   = [[wep_m_maverick.s3o]],
      noSelfDamage            = true,
      pitchtolerance          = [[12000]],
      range                   = 300,
      reloadtime              = 1.6,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      soundHit                = [[OTAunit/XPLOMED2]],
      soundStart              = [[OTAunit/ROCKLIT3]],
      soundTrigger            = true,
      startsmoke              = [[1]],
      startVelocity           = 100,
      tolerance               = 20000,
      tracks                  = true,
      turnRate                = 30000,
      turret                  = false,
      weaponAcceleration      = 300,
      weaponTimer             = 6,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 800,
    },

  },


  featureDefs        = {

    DEAD  = {
      description      = [[Wreckage - Rapier]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2200,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 150,
      object           = [[rapier_d.s3o]],
      reclaimable      = true,
      reclaimTime      = 150,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Rapier]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 150,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 150,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Rapier]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2200,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 75,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 75,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corape = unitDef })
