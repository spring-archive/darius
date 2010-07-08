local card = {
    name       = "Quad Damage",
    type       = "Special",
    img        = 'cards/images/special/quad_damage.png',
    health     = 0,
    reloadTime = 0,
    range      = 0,
    damage     = 0,
    greenballs = 0,
    effect     = function()
        -- towers partially transparent/blue
    end,
    desc       = "Multiplies damages of all towers by four for 30 seconds."
}

return card