function gadget:GetInfo()
	return {
		name      = "Card Award System",
		desc      = "Awards the player with cards at the end of a session",
		author    = "xcompwiz",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true,  --  loaded by default
	}
end

--------------
-- Speed Up --
--------------

local spEcho = Spring.Echo

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

function gadget:GameOver()
	--TODO: Check victory
	if (debug_message) then debug_message(gadget:GetInfo().name .. ": Selecting Award") end
	--Decide on award
	--TODO: Generate Award
	award = {"Stone", "Lightning", "Nuclear"} --Test example

	if (debug_message) then debug_message(gadget:GetInfo().name .. ": Awarding Player") end
	str = ""
	for _, name in pairs(award) do
		--Give award
		GG.CardPool:AddCardToPlayer(name, 1)
		str = str .. " " .. name
	end

	--Notify UI
	if (debug_message) then debug_message(gadget:GetInfo().name .. ": Awarded player with " .. str) end
	SendToUnsynced("awardstr", str) --Note: Could be sent seperately too
end

------------------------------------------------
else --unsynced
------------------------------------------------

local function RecvAwardStr(_, str)
	if Script.LuaUI('AddAwardDisplay') then
		if (debug_message) then debug_message(gadget:GetInfo().name .. ": Notifying UI of " .. str .. " award") end
		Script.LuaUI.AddAwardDisplay(str)
	end
end

function gadget:Initialize()
	gadgetHandler:AddSyncAction("awardstr", RecvAwardStr)--This is the one that gets called on the SendToUnsynced
end

end -- End synced check
