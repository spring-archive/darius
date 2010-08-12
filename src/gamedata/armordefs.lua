
local armorDefs = {
	EMPRESISTANT75 = {
		"arm_venom",
		"armartic",
	},

	BURROWED = {
		"chicken_digger_b",
		"chicken_listener_b",
	},
	
	-- populated automatically
	PLANES = {}, 
	ELSE   = {},
}



local function tobool(val)
	local t = type(val)
	if (t == 'nil') then
		return false
	elseif (t == 'boolean') then
		return val
	elseif (t == 'number') then
		return (val ~= 0)
	elseif (t == 'string') then
		return ((val ~= '0') and (val ~= 'false'))
	end
	return false
end


-- put any unit that doesn't go in any other category in ELSE
for name, ud in pairs(DEFS.unitDefs) do
	local found
	for categoryName, categoryTable in pairs(armorDefs) do
		for _, usedName in pairs(categoryTable) do
			if (usedName == name) then
				found = true
			end
		end
	end
	if (not found) then
		if (tobool(ud.canfly)) then
			table.insert(armorDefs.PLANES, name)
		else
			table.insert(armorDefs.ELSE, name)
		end
	end
end


-- use categories to set default weapon damages
for name, wd in pairs(DEFS.weaponDefs) do
	local max = -0.000001
	for _, dAmount in pairs(wd.damage) do
		max = math.max(max, dAmount)
	end
	for categoryName, _ in pairs(armorDefs) do
		wd.damage[categoryName] = wd.damage[categoryName] or wd.damage.default
	end
	wd.damage.default = wd.paralyzer and max/3 or max
end


-- convert to named maps  (does anyone know what 99 is for?  :)
for categoryName, categoryTable in pairs(armorDefs) do
	local t = {}
	for _, unitName in pairs(categoryTable) do
		t[unitName] = 99
	end
	armorDefs[categoryName] = t
end



local system = VFS.Include('gamedata/system.lua')
return system.lowerkeys(armorDefs)