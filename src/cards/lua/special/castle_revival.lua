local function GetCommanders(teamID) --Finds the commander IDs for the given team

	local units = Spring.GetTeamUnits(teamID)
	local commanders = {}

	for _,unitID in ipairs(units) do
		if (UnitDefs[Spring.GetUnitDefID(unitID)].isCommander) then
			--checks if the isCommander attribute is true in current unit's unitDef -file
			commanders[#commanders + 1] = unitID
		end
	end

	return commanders

end

local card = {
	name	     = "Revival",
	type	     = "Special",
	img	     = 'cards/images/special/revival.png',
	health     = 0,
	reloadTime = 0,
	range      = 0,
	damage     = 0,
	greenballs = 0,
	effect     = {
		start = function(pos, unit)
			local commander = GetCommanders(1)[1]
			local health, maxhealth, _,_,_ = Spring.GetUnitHealth(commander)
			if (health < maxhealth*0.6) then
				Spring.SetUnitHealth(commander, {health = maxhealth*0.6})
			end
		end,
	},
	desc       = "Instantly recovers HP of the castle upto 60% of the maximum."
}

return card