local card = {
	name       = "Regeneration",
	type       = "Special",
	img        = 'cards/images/special/regeneration.png',
	health     = 0,
	reloadTime = 0,
	range      = 0,
	damage     = 0,
	greenballs = -10,
	effect     = {
		start = function(pos, unit)
			local towers = Spring.GetTeamUnits(1)
			for _,unitID in ipairs(towers) do
				--checks if the isCommander attribute is true in current unit's unitDef -file
				if not (UnitDefs[Spring.GetUnitDefID(unitID)].isCommander) then
					local health, maxhealth, _,_,_ = Spring.GetUnitHealth(unitID)
					Spring.SetUnitHealth(unitID, {health = maxhealth})
				end
			end
		end,
	},
	desc       = "Recovers HP of the all built towers to their maximum."
}

return card