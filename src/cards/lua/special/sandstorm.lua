local card = {
    name       = "Sandstorm",
    type       = "Special",
    img        = 'cards/images/special/sandstorm.png',
    health     = 0,
    reloadTime = 0,
    range      = 0,
    damage     = 0,
    greenballs = 0,
    effect     = function()
        -- particle storm?
    end,
    desc       = "Movement speed of all enemies in the playfield slows down for 60 seconds."
}

return card