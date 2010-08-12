-- IMPORTANT NOTES
--   Only works in Windows for now
--   Only attempt to run while in the same directory as the script
--   Run it ie. <path_to_lua>/lua.exe generatecards.lua
--   Overwrites all the files in the generatedtowers directory

local outputDirectory = "generatedtowers\\"

-- HACK: Lua does not support reading directory content directly
function ListFiles(query)
	dir = io.popen("dir /b "..query)
	files = {}
	for l in dir:lines() do
	    print("Found file: "..l)
		table.insert(files,l)
	end
	return files
end

function VerifyVarType(fromTable,variableName,variableType)
	if (type(fromTable[variableName]) ~= variableType) then
		print("Fatal error: Variable '"..variableName.."' should be "..variableType)
		os.exit()
	end
end

function LoadCardsFromDirectory(dir)
	mainDirectory = "lua\\"
	path = mainDirectory .. dir .. "\\"
	print("Loading directory: "..dir)
	query = path .. "*.lua"
	cards = {}
	for _,scriptFile in pairs(ListFiles(query)) do
		card = dofile(path .. scriptFile)
		if (type(card) ~= "table") then
			print("Fatal error: Did not get table from "..scriptFile)
			os.exit()
		end
		VerifyVarType(card,"name","string")
		table.insert(cards,card)
	end
	return cards
end

function SimplifyString(str)
	-- Anything that is not alphanumeric is removed and string is turned to lowercase
	return string.lower(string.gsub(str,"[^%w]",""))
end

materialCards = LoadCardsFromDirectory("material")
weaponCards = LoadCardsFromDirectory("weapon")
print("Loaded "..#materialCards.." material cards, "..#weaponCards.." weapon cards, ")

local towers = {}
for _,material in pairs(materialCards) do
	for _,weapon in pairs(weaponCards) do
	
		-- Variables present in both cards will be combined, numbers added together and strings concatenated
		local combined = {}
		for key,_ in pairs(weapon) do
			-- Template in weapon card tells us the weapon template to use for the unit definition
			if key == "template" then
				combined["weaponTemplate"] = weapon[key]
			elseif material[key] then
				-- The variable is present in both cards, now need to combine the values
				if type(material[key]) == "number" and type(weapon[key]) == "number" then
					combined[key] = material[key]+weapon[key]
				elseif type(material[key]) == "string" and type(weapon[key]) == "string" then
					combined[key] = material[key]..weapon[key]
				else
					print("WARNING: Ignoring "..key.." variable!!")
				end
			else
				-- The variable is present in only in the weapon card
				combined[key] = weapon[key]
			end
		end
		for key,_ in pairs(material) do
			-- Template in material card tells us the base template to use for the unit definition
			if key == "template" then
				combined["materialTemplate"] = material[key]
			elseif not weapon[key] then
				-- The variable is present in only in the material card
				combined[key] = material[key]
			end
		end
		-- This name will be used for the filename, unit name etc
		combined["shortname"] = SimplifyString(combined["name"])
		table.insert(towers,combined)
	end
end

for _,tower in pairs(towers) do
	local materialTemplate = "towertemplates\\materials\\"..tower["materialTemplate"]..".lua"
	local weaponTemplate = "towertemplates\\weapons\\"..tower["weaponTemplate"]..".lua"
	file = io.open(outputDirectory..tower["shortname"]..".lua","w")
	if not file then
		print("Fatal error: Unable to open file for writing: "..tower[name])
		os.exit()
	end
	if not tower["materialTemplate"] then
		print("Fatal error: Material template missing for "..tower["name"])
		os.exit()
	end
	-- TODO: Check and do something if template file is missing
	for line in io.lines(materialTemplate) do
		if string.match(line,"%%WEAPONS%%") then
			if tower["weaponTemplate"] then
				-- TODO: Check and do something if template file is missing
				for weaponLine in io.lines(weaponTemplate) do
					if string.match(weaponLine,"%%%%") then
						for key,value in pairs(tower) do
							pattern = "%%%%"..string.upper(key).."%%%%"
							weaponLine = string.gsub(weaponLine,pattern,value)
						end
					end
					file:write(weaponLine.."\n")
				end
				line = ""
			else
				print("Fatal error: Weapon template missing for "..tower["name"])
				os.exit()
			end
		elseif string.match(line,"%%%%") then
			for key,value in pairs(tower) do
				pattern = "%%%%"..string.upper(key).."%%%%"
				line = string.gsub(line,pattern,value)
			end
		end
		file:write(line.."\n")
	end
	file:close()
end