-- fire1_burn1_flame1
-- fire1_smoke1
-- fire1_burnlight
-- fire1_burn1_flame3
-- fire1_burn1_flame4
-- fire1_burn1
-- fire1_burn1_flame2
-- fire1

return {
  ["fire1_burn1_flame1"] = {
    fire = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0 0 0 0.01  1 1 1 0.01  0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 15.3,
        particlelifespread = 0,
        particlesize       = 5.23,
        particlesizespread = 10.23,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[fire1]],
      },
    },
  },

  ["fire1_smoke1"] = {
    fire = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0 0 0 0.01    1 1 1 1    0.7 0.7  0.7 1     0.5 0.5 0.5 0.7      0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 5,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0.05]],
        numparticles       = 1,
        particlelife       = 30,
        particlelifespread = 30,
        particlesize       = 9,
        particlesizespread = 11,
        particlespeed      = 2,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.05,
        sizemod            = 1.0,
        texture            = [[orangesmoke]],
      },
    },
  },

  ["fire1_burnlight"] = {
    air                = true,
    count              = 1,
    ground             = true,
    usedefaultexplosions = false,
    water              = true,
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 1,
      flashalpha         = 1,
      flashsize          = 20,
      ttl                = 15,
      color = {
        [1]  = 1,
        [2]  = 0.44999998807907,
        [3]  = 0.69999998807907,
      },
    },
  },

  ["fire1_burn1_flame3"] = {
    fire = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0 0 0 0.01  1 1 1 0.01  0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 15.3,
        particlelifespread = 0,
        particlesize       = 5.23,
        particlesizespread = 10.23,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[fire3]],
      },
    },
  },

  ["fire1_burn1_flame4"] = {
    fire = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0 0 0 0.01  1 1 1 0.01  0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 15.3,
        particlelifespread = 0,
        particlesize       = 5.23,
        particlesizespread = 10.23,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[fire4]],
      },
    },
  },

  ["fire1_burn1"] = {
    flame1 = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 0,
        explosiongenerator = [[custom:FIRE1_BURN1_FLAME1]],
        pos                = [[0, 1, 0]],
      },
    },
    flame2 = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 5,
        explosiongenerator = [[custom:FIRE1_BURN1_FLAME2]],
        pos                = [[0, 1, 0]],
      },
    },
    flame3 = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 10,
        explosiongenerator = [[custom:FIRE1_BURN1_FLAME3]],
        pos                = [[0, 1, 0]],
      },
    },
    flame4 = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 15,
        explosiongenerator = [[custom:FIRE1_BURN1_FLAME4]],
        pos                = [[0, 1, 0]],
      },
    },
  },

  ["fire1_burn1_flame2"] = {
    fire = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0 0 0 0.01  1 1 1 0.01  0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 15.3,
        particlelifespread = 0,
        particlesize       = 5.23,
        particlesizespread = 10.23,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[fire2]],
      },
    },
  },

  ["fire1"] = {
    flame = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 5,
      ground             = true,
      water              = true,
      properties = {
        delay              = [[0 i20]],
        explosiongenerator = [[custom:FIRE1_BURN1]],
        pos                = [[0, 1, 0]],
      },
    },
    groundflash = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 100,
      ground             = true,
      water              = true,
      properties = {
        delay              = [[0 i1]],
        explosiongenerator = [[custom:FIRE1_BURNLIGHT]],
        pos                = [[0, 1, 0]],
      },
    },
    smoke1 = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 100,
      ground             = true,
      water              = true,
      properties = {
        delay              = [[0 i1]],
        explosiongenerator = [[custom:FIRE1_SMOKE1]],
        pos                = [[0, 1, 0]],
      },
    },
  },

}

