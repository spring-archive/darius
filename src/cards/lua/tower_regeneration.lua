local card = {
    name       = "Tower regeneration",
    type       = "Special",
    img        = 'cards/images/special/tower_regeneration.png',
    health     = 0,
    reloadTime = 0,
    range      = 0,
    damage     = 0,
    greenballs = 0,
    effect     = function()
        -- do something
    end,
    desc       = "Starts recovering HP of the player's all towers slowly to their maximum."
}

return card