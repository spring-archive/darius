function gadget:GetInfo()
	return {
		name      = "Card Pool",
		desc      = "Stores the cards the player owns",
		author    = "xcompwiz",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true,  --  loaded by default?
	}
end
-----------------------------------------
-- This system is presently just a dummy.
-----------------------------------------

--------------
-- Speed Up --
--------------
local spEcho = Spring.Echo

---------------------
-- Table Functions --
---------------------
function table.copy(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end


----------------
-- Local Vars --
----------------

cards = {	--should probably have their own files
	{ -- 1
		name = "Stone", 
		type = "Material", 
		img = 'LuaUI/images/stone.png',
		health =   1200,
		reloadTime = 0.5,
		range =  50,
		LOS = 500,
		damage =  0,
		weaponVelocity = 0,
		desc = "Creates tall stone towers with decent range and good amount of health,\n" ..
			"but due to tall design, adds additional weapon reloading time.",
	},

	{ -- 2
		name = "Fire",
		type = "Weapon",
		img = 'LuaUI/images/fire.png',
		health =   -150,
		reloadTime = 0.80,
		range =  350,
		LOS = 0,
		damage =  100,
		weaponVelocity = 900,
		desc = "Shoots fireballs that do good damage, but with limited range and\n" ..
			"projectile speed. Also due to the unpredictable nature of fire,\n" .. 
			"costs tower healthpoints.",
	},

	{ -- 3
		name = "Metal",
		type = "Material",
		img = 'LuaUI/images/ibeam.png',
		health = 0,
		reloadTime = 0,
		range =  0,
		LOS = 0,
		damage =  0,
		weaponVelocity = 0,
		desc = "Metal material card",
	},

	{ -- 4
		name = "Lightning",
		type = "Weapon",
		img = 'LuaUI/images/energy.png',
		health = 0,
		reloadTime = 0,
		range =  0,
		LOS = 0,
		damage =  0,
		weaponVelocity = 0,
		desc = "Lightning material card",
	},

	{ -- 5
		name = "Pink Fluffy Bunnies",
		type = "Special",
		img = 'LuaUI/images/friendly.png',
		health = 0,
		reloadTime = 0,
		range = 0,
		LOS = 0,
		damage = 0,
		weaponVelocity = 0,
		desc = "Huh?",
	},
}

if (not gadgetHandler:IsSyncedCode()) then
	return false -- no unsynced code
end

local function SendDecks()  -- Sends the decks to the instance game manager
	for i = 1, 3 do
		Darius:AddCard(table.copy(cards[1]), 1) --Stone
	end
	for i = 1, 2 do
		Darius:AddCard(table.copy(cards[3]), 1) --Metal
	end
	for i = 1, 3 do
		Darius:AddCard(table.copy(cards[2]), 2) --Fire
	end
	for i = 1, 2 do
		Darius:AddCard(table.copy(cards[4]), 2) --Lightning
	end
	Darius:AddCard(table.copy(cards[5]), 1) --Pink Fluffy Bunnies
end

local function StartGame()
	if (not GG.Darius) then
		spEcho("Game failed to load properly")
		return
	end
	Darius = GG.Darius
	Darius:ClearGame()
	SendDecks()
	Darius:AddGreenballs(40)
end

function gadget:Initialize()
	StartGame()
end
