-- vulcanfx

return {
  ["vulcanfx"] = {
    usedefaultexplosions = false,
    exhale = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
        colormap           = [[1.0 0.8 0.5 0.1 0.15 0.15 0.15 0.2 0.0 0.0 0.0 0.01]],
        directional        = false,
        emitrot            = 80,
        emitrotspread      = 5,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 2,
        particlelife       = 17,
        particlelifespread = 15,
        particlesize       = 8,
        particlesizespread = 1,
        particlespeed      = 1,
        particlespeedspread = 1,
        pos                = [[0, 1, 0]],
        sizegrowth         = 0.16,
        sizemod            = 1.0,
        texture            = [[smoke]],
      },
    },
    exhale2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
        colormap           = [[1.0 0.7 0.4 0.1 0.1 0.1 0.1 0.2 0.0 0.0 0.0 0.01]],
        directional        = false,
        emitrot            = 80,
        emitrotspread      = 5,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 2,
        particlelife       = 17,
        particlelifespread = 15,
        particlesize       = 8,
        particlesizespread = 1,
        particlespeed      = 1,
        particlespeedspread = 1,
        pos                = [[0, 1, 0]],
        sizegrowth         = 0.16,
        sizemod            = 1.0,
        texture            = [[smoke]],
      },
    },
    spikes = {
      air                = true,
      class              = [[explspike]],
      count              = 3,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 1,
        alphadecay         = 0.15,
        color              = [[1.0, 0.8, 0.5]],
        dir                = [[-10 r20,-10 r20,-10 r20]],
        length             = 1,
        width              = 22,
      },
    },
  },

}

