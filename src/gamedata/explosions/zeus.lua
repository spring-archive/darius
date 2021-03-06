-- lightningplosion_yellowbolts
-- zeusmuzzle
-- panther_spark
-- lightningplosion
-- lightningplosion_bluebolts1
-- lightningplosion_stormbolt
-- zeusgroundflash

return {
  ["lightningplosion_yellowbolts"] = {
    ["electric thingies"] = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0.5  0.5 1 0.01  0.5 0.5 1 0.01 1 1 0 0.01  0.5 0.5 1 0.01   0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 180,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 5,
        particlelife       = 2,
        particlelifespread = 5,
        particlesize       = 40,
        particlesizespread = 0,
        particlespeed      = 2,
        particlespeedspread = 0,
        pos                = [[0, 1.0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[whitelightb]],
      },
    },
    sparks = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.97,
        colormap           = [[0.2 0.2 1 0.01   0.4 0.4 1 0.01   0.0 0.0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 60,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.2, 0]],
        numparticles       = 40,
        particlelife       = 20,
        particlelifespread = 5,
        particlesize       = 5,
        particlesizespread = 0,
        particlespeed      = 5,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[spark]],
      },
    },
  },

  ["zeusmuzzle"] = {
    usedefaultexplosions = false,
    lightball = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0.7 0.7 0.7 0.01  1 1 1 0.01  0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 20,
        particlelifespread = 0,
        particlesize       = 15,
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[lightb3]],
        useairlos          = false,
      },
    },
    lightball2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0 0 0 0.01 0 0 0 0.01 0.7 0.7 0.7 0.01  1 1 1 0.01  0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 20,
        particlelifespread = 0,
        particlesize       = 15,
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[lightb4]],
        useairlos          = false,
      },
    },
    lightring = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0.3 0.3 0.7 0.01  0.7 0.7 1 0.01  0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 20,
        particlelifespread = 0,
        particlesize       = 1,
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 1,
        sizemod            = 1.0,
        texture            = [[lightring]],
        useairlos          = false,
      },
    },
  },

  ["panther_spark"] = {
    lightningballs = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0 0 0 0.01 1 1 1 0.01 0 0 0 0.01]],
        directional        = true,
        emitrot            = 80,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 3,
        particlelifespread = 0,
        particlesize       = 2,
        particlesizespread = 2,
        particlespeed      = 0.01,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[lightb]],
        useairlos          = false,
      },
    },
  },

  ["lightningplosion"] = {
    bluebolts1 = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 3,
        explosiongenerator = [[custom:LIGHTNINGPLOSION_BLUEBOLTS1]],
        pos                = [[0, 0, 0]],
      },
    },
    electricstorm = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 20,
      ground             = true,
      water              = true,
      properties = {
        delay              = [[10 r200]],
        explosiongenerator = [[custom:LIGHTNINGPLOSION_STORMBOLT]],
        pos                = [[-100 r200, 1, -100 r200]],
      },
    },
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.3,
      flashsize          = 86,
      ttl                = 12,
      color = {
        [1]  = 0.5,
        [2]  = 0.5,
        [3]  = 1,
      },
    },
    pikes = {
      air                = true,
      class              = [[explspike]],
      count              = 15,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 0.8,
        alphadecay         = 0.1,
        color              = [[0.5,0.5,1]],
        dir                = [[-15 r30,-15 r30,-15 r30]],
        length             = 30,
        width              = 5,
      },
    },
    yellowbolts = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 0,
        explosiongenerator = [[custom:LIGHTNINGPLOSION_YELLOWBOLTS]],
        pos                = [[0, 0, 0]],
      },
    },
  },

  ["lightningplosion_bluebolts1"] = {
    ["electric thingies2"] = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.1,
        colormap           = [[1 1 1 0.01  1 1 1 0.01   1 1 1 0.01  1 1 1 0.01  1 1 1 0.01 0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 80,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 10,
        particlelife       = 8,
        particlelifespread = 4,
        particlesize       = 15,
        particlesizespread = 15,
        particlespeed      = 20,
        particlespeedspread = 20,
        pos                = [[0, 1.0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[lightb]],
      },
    },
  },

  ["lightningplosion_stormbolt"] = {
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.3,
      flashsize          = 46,
      ttl                = 3,
      color = {
        [1]  = 0.5,
        [2]  = 0.5,
        [3]  = 1,
      },
    },
    lightningballs = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0 0 0 0.01 1 1 1 0.01 0 0 0 0.01]],
        directional        = true,
        emitrot            = 80,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 3,
        particlelifespread = 0,
        particlesize       = 2,
        particlesizespread = 20,
        particlespeed      = 0.01,
        particlespeedspread = 0,
        pos                = [[-10 r20, 1.0, -10 r20]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[lightb]],
      },
    },
  },

  ["zeusgroundflash"] = {
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.3,
      flashsize          = 46,
      ttl                = 12,
      color = {
        [1]  = 0.5,
        [2]  = 0.5,
        [3]  = 1,
      },
    },
  },

}

