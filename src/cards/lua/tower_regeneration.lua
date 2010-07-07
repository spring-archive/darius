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
        -- some kind of particle aura swings over the castle
    end,
    desc       = "Starts recovering HP of the player's all towers slowly to their maximum."
}

return card