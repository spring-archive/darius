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
		effect = function()
			local monsters = Spring.GetTeamUnits(0)
			for _, unitID in ipairs(monsters) do
				Spring.SetUnitRulesParam(unitID, "on_fire", 1)
			end
		end,
	},
	desc       = "(DOESN'T WORK)\nAll enemy units in the playfield catch fire and start losing their HP."
}

return card