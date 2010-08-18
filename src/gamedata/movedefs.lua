
local moveDefs = {
	SMALL = {
		footprintx = 1,
		footprintz = 1,
		maxslope = 32,
		slopemod = 20,
		crushstrength = 5,
	},

	MEDIUM = {
		footprintx = 3,
		footprintz = 3,
		maxslope = 32,
		slopemod = 20,
		crushstrength = 50,
	},

	LARGE = {
		footprintx = 5,
		footprintz = 5,
		maxslope = 32,
		slopemod = 20,
		crushstrength = 500,
	},
}


-- convert from map format to the expected array format
local array = {}
local i = 1

for k,v in pairs(moveDefs) do
	array[i] = v
	v.name = k
	i = i + 1
end


return array