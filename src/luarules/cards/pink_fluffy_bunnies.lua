local card = {
    name       = "Pink Fluffy Bunnies",
    type       = "Special",
    img        = 'LuaUI/images/friendly.png',
    health     = 0,
    reloadTime = 0,
    range      = 0,
    damage     = 0,
    greenballs = 0,
    effect     = function(pos)
                    spEcho("HELLO!")
                 end,
    desc       = "Huh?"
}

return card