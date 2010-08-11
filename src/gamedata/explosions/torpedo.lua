-- torpedo_hit
-- torpedo_hit_main

return {
  ["torpedo_hit"] = {
    usedefaultexplosions = false,
    droplets = {
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      water              = true,
      properties = {
        airdrag            = 0.95,
        alwaysvisible      = false,
        colormap           = [[0.75 0.75 1 1  0 0 0 0]],
        directional        = false,
        emitrot            = 85,
        emitrotspread      = 5,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.1, 0]],
        numparticles       = 16,
        particlelife       = 8,
        particlelifespread = 0,
        particlesize       = 12,
        particlesizespread = 8,
        particlespeed      = 2,
        particlespeedspread = 4,
        pos                = [[0, 15, 0]],
        sizegrowth         = 0.5,
        sizemod            = 1.0,
        texture            = [[randdots]],
      },
    },
    mainhit = {
      class              = [[CExpGenSpawner]],
      count              = 1,
      water              = true,
      properties = {
        delay              = 0,
        dir                = [[dir]],
        explosiongenerator = [[custom:TORPEDO_HIT_MAIN]],
        pos                = [[0, 15, 0]],
      },
    },
    pikes = {
      air                = true,
      class              = [[explspike]],
      count              = 16,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 1,
        alphadecay         = 0.125,
        color              = [[1,0.5,0]],
        dir                = [[-4 r8, -4 r8, -4 r8]],
        length             = 1,
        width              = 8,
      },
    },
    watersphere = {
      class              = [[CSpherePartSpawner]],
      count              = 1,
      water              = true,
      properties = {
        alpha              = 0.25,
        alwaysvisible      = false,
        color              = [[0.8,0.8,1]],
        expansionspeed     = 4,
        ttl                = 8,
      },
    },
  },

  ["torpedo_hit_main"] = {
    mainhit = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 4,
      ground             = true,
      water              = true,
      properties = {
        colormap           = [[0.45 0.45 0.5 0.5  0.045 0.045 0.05 0.05]],
        dir                = [[-0.1 r0.2, 1, -0.1 r0.2]],
        frontoffset        = 0,
        fronttexture       = [[splashbase]],
        length             = [[36 r24]],
        sidetexture        = [[splashside]],
        size               = [[9 r6]],
        sizegrowth         = 1,
        ttl                = 12,
      },
    },
  },

}

