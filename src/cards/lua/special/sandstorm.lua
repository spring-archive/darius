local card = {
	name       = "Sandstorm",
	type       = "Special",
	img        = 'cards/images/special/sandstorm.png',
	health     = 0,
	reloadTime = 0,
	range      = 0,
	damage     = 0,
	greenballs = 1,
	effect     = {
		effect = function()
		end,
	},
	desc       = "(DOESN'T WORK)\nMovement speed of all enemies in the playfield slows down for 60 seconds."
}

return card