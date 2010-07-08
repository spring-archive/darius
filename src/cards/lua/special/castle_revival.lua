local card = {
    name       = "Castle revival",
    type       = "Special",
    img        = 'cards/images/special/castle_revival.png',
    health     = 0,
    reloadTime = 0,
    range      = 0,
    damage     = 0,
    greenballs = 0,
    effect     = function()
        -- some kind of particle aura swings over the castle
    end,
    desc       = "Instantly recovers HP of the castle to 60% of the maximum."
}

return card