local card = {
    name       = "Tower Regeneration",
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
    desc       = "Recovers HP of the all built towers slowly to their maximum."
}

return card