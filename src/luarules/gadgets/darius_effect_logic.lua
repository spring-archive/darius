function gadget:GetInfo()
	return {
		name      = "Effect Logic",
		desc      = "Sets effect appropriately",
		author    = "xcompwiz",
		date      = "July 8, 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default
	}
end

--------------
-- Speed Up --
--------------
local spEcho = Spring.Echo

--local debug_message = spEcho

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

Darius = GG.Darius

---------------------
-- Synced Call-ins --
---------------------
function gadget:GameFrame(f)
	Darius = GG.Darius
	if not (Darius) then return end

	local special = Darius:GetSelectedSpecial()

	if (special) then 
		if (type(special.effect) == "table") and (special.greenballs + Darius:GetGreenballs() >= 0) then
			if (debug_message) then debug_message("Setting Special Card Effect") end
			Darius:SetEffect(special.effect)
		else
			if (debug_message) then debug_message("Clearing Special Card Effect") end
			Darius:SetEffect(nil)
		end
	else
		if (debug_message) then debug_message("Clearing Special Card Effect") end
		Darius:SetEffect(nil)
	end
end

------------------------------------------------
else --unsynced
------------------------------------------------

-----------------------
-- Unsynced Call-ins --
-----------------------

end -- End synced check
