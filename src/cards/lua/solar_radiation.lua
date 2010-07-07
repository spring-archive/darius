local card = {
    name       = "Solar Radiation",
    type       = "Special",
    img        = 'cards/images/special/solar_radiation.png',
    health     = 0,
    reloadTime = 0,
    range      = 0,
    damage     = 0,
    greenballs = 0,
    effect     = function()
        -- do something
    end,
    desc       = "All enemy units currently in the playfield catch fire and start losing their HP."
}

return card