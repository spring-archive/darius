local card = {
    name       = "Invisibility",
    type       = "Special",
    img        = 'cards/images/special/invisibility.png',
    health     = 0,
    reloadTime = 0,
    range      = 0,
    damage     = 0,
    greenballs = 0,
    effect     = function()
        -- towers almost completely transparent
    end,
    desc       = "Makes all towers invisible for 60 seconds. None on the enemies will attack towers during that."
}

return card