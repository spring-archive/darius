local card = {
	name       = "Radiation",
	type       = "Special",
	img        = 'cards/images/special/radiation.png',
	health     = 0,
	reloadTime = 0,
	range      = 0,
	damage     = 0,
	greenballs = 0,
	effect     = {
		reqPos = false,
		reqUnit = false,
		duration = 10,
		continuous = function()
			local monsters = Spring.GetTeamUnits(0)
			for _, unitID in ipairs(monsters) do
				local health,maxhealth,_,_,_ = Spring.GetUnitHealth(unitID)
				Spring.SetUnitHealth(unitID, {health = maxhealth*0.97})
			end
		end,
	},
	desc       = "(UNTESTED)\nAll enemy units in the playfield catch fire and start losing their HP."
}

return card