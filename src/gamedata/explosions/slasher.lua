-- slashmuzzle
-- slashrearmuzzle

return {
  ["slashmuzzle"] = {
    fire = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 10,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.6,
        colormap           = [[1 1 0 0.9      1 0.8  0.3 08    0 0 0 0.01]],
        directional        = false,
        emitrot            = 30,
        emitrotspread      = 15,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 10,
        particlelifespread = 0,
        particlesize       = 0.5,
        particlesizespread = 0.5,
        particlespeed      = 2,
        particlespeedspread = 2,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.5,
        sizemod            = 1.0,
        texture            = [[orangesmoke2]],
      },
    },
    fluffy = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 10,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.6,
        colormap           = [[1 1 1 1  1 1 1 1 0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 15,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 30,
        particlelifespread = 0,
        particlesize       = [[10 i-0.9]],
        particlesizespread = 0,
        particlespeed      = [[2 i1.5]],
        particlespeedspread = 2,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.2,
        sizemod            = 1.0,
        texture            = [[smokesmall]],
      },
    },
  },

  ["slashrearmuzzle"] = {
    fire = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 10,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.6,
        colormap           = [[1 1 0 0.9      1 0.8  0.3 08    0 0 0 0.01]],
        directional        = false,
        emitrot            = 30,
        emitrotspread      = 15,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 10,
        particlelifespread = 0,
        particlesize       = 0.5,
        particlesizespread = 0.5,
        particlespeed      = 2,
        particlespeedspread = 2,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.5,
        sizemod            = 1.0,
        texture            = [[orangesmoke2]],
      },
    },
    fluffy = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 10,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.6,
        colormap           = [[1 1 1 1  1 1 1 1 0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 45,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 30,
        particlelifespread = 0,
        particlesize       = [[10 i-0.5]],
        particlesizespread = 0,
        particlespeed      = [[15 i-1.5]],
        particlespeedspread = 2,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.2,
        sizemod            = 1.0,
        texture            = [[smokesmall]],
      },
    },
  },

}
