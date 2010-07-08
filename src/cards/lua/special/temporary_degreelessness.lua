local card = {
    name       = "Temporary Degreelessness",
    type       = "Special",
    img        = 'cards/images/special/temporary_degreelessness.png',
    health     = 0,
    reloadTime = 0,
    range      = 0,
    damage     = 0,
    greenballs = 0,
    effect     = function()
        -- towers and the castle partially transparent/red
    end,
    desc       = "Makes all towers and the castle completely invulnerable for 30 seconds."
}

return card