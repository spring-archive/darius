local card = {
	name       = "IDDQD",
	type       = "Special",
	img        = 'cards/images/special/degreelessness.png',
	health     = 0,
	reloadTime = 0,
	range      = 0,
	damage     = 0,
	greenballs = 1,
	effect     = {
		reqPos = false,
		reqUnit = false,
		duration = 30,
		start = function(pos, unit)
		end,
		continuous = function()
		end,
		stop = function()
		end,
	},
	desc       = "(DOESN'T WORK)\nActivates god mode... for 30 seconds."
}

return card