local card = {
    name       = "Earthquake",
    type       = "Special",
    img        = 'cards/images/special/earthquake.png',
    health     = 0,
    reloadTime = 0,
    range      = 0,
    damage     = 0,
    greenballs = 0,
    effect     = function()
        -- shake camera for some time
    end,
    desc       = "Quickly lowers HP of the enemies to 30% of their maximum."
}

return card