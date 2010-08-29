local card = {
	name       = "Invisibility",
	type       = "Special",
	img        = 'cards/images/special/invisibility.png',
	health     = 0,
	reloadTime = 0,
	range      = 0,
	damage     = 0,
	greenballs = 1,
	effect     = {
		reqPos = false,
		reqUnit = false,
		duration = 60,
		start = function(pos, unit)
		end,
		continuous = function()
		end,
		stop = function()
		end,
	},
	desc       = "(DOESN'T WORK)\nMakes all towers invisible for 60 seconds. None of the enemies will attack towers during that."
}

return card