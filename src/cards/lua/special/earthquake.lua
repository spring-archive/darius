local card = {
	name       = "Earthquake",
	type       = "Special",
	img        = 'cards/images/special/earthquake.png',
	health     = 0,
	reloadTime = 0,
	range      = 0,
	damage     = 0,
	greenballs = 2,
	effect     = {
		start = function(pos, unit)
			local units = Spring.GetAllUnits()
			for _,unitID in ipairs(units) do
				local health, maxhealth, _,_,_ = Spring.GetUnitHealth(unitID)
				if (health > maxhealth * 0.3) then
					Spring.SetUnitHealth(unitID, {health = maxhealth*0.3})
				end
			end
		end,
	},
	desc       = "Reduces the health of everything to 30% of its maximum."
}

return card