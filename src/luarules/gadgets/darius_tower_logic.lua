function gadget:GetInfo()
	return {
		name      = "Tower Selector Logic",
		desc      = "The Logic controller which selects the appropriate tower based on the currently selected cards.",
		author    = "xcompwiz",
		date      = "June 7, 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

--------------
-- Speed Up --
--------------
local spEcho = Spring.Echo

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

---------------------
-- Synced Call-ins --
---------------------
function gadget:Initialize()
	-- Setup Darius
	Darius = GG.Darius
end

function gadget:GameFrame(f)
	if not (Darius) then Darius = GG.Darius end
	if not (Darius) then return end
	if (Darius:GetSelectedMaterial() and Darius:GetSelectedWeapon()) then
		Darius:SetTower("corllt")
	else
		Darius:SetTower(nil)
	end
end

------------------------------------------------
else --unsynced
------------------------------------------------

-----------------------
-- Unsynced Call-ins --
-----------------------

end -- End synced check