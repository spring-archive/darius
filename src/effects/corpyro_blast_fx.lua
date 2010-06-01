-- corpyro_blast_fx

return {
  ["corpyro_blast_fx"] = {
    air                = true,
    class              = [[CSimpleParticleSystem]],
    count              = 1,
    ground             = true,
    water              = true,
    properties = {
      airdrag            = 0.1,
      colormap           = [[1 0 1 0.01  1 0 1 0.01   1 0 1 0.01  1 0 1 0.01  1 0 1 0.01 0 0 0 0.01]],
      directional        = true,
      emitrot            = 0,
      emitrotspread      = 80,
      emitvector         = [[0, 1, 0]],
      gravity            = [[0, 0, 0]],
      numparticles       = 10,
      particlelife       = 80,
      particlelifespread = 4,
      particlesize       = 15,
      particlesizespread = 15,
      particlespeed      = 20,
      particlespeedspread = 20,
      pos                = [[0, 1.0, 0]],
      sizegrowth         = 0,
      sizemod            = 1.0,
      texture            = [[flame]],
    },
  },

}

