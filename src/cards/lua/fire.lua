local card = {
    name       = "Fire",
    type       = "Weapon",
    img        = 'cards/images/weapon/fire.png',  -- needs graphics
    health     =  -150,
    reloadTime = 0.80,
    range      = 350,
    damage     = 100,
    greenballs = 0,
    effect     = nil,
    desc       = "Shoots fireballs that do good damage, but with limited range and\n" ..
                 "projectile speed. Also due to the unpredictable nature of fire,\n" ..
                 "costs tower healthpoints."
}

return card