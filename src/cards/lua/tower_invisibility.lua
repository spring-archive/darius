local card = {
    name       = "Tower Invisibility",
    type       = "Special",
    img        = 'cards/images/special/tower_invisibility.png',
    health     = 0,
    reloadTime = 0,
    range      = 0,
    damage     = 0,
    greenballs = 0,
    effect     = function()
        -- towers almost completely transparent
    end,
    desc       = "Makes towers invisible for 60 seconds. None on the enemies will attack player's towers during that."
}

return card