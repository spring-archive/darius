function gadget:GetInfo()
	return {
		name      = "Effect Controller",
		desc      = "",
		author    = "xcompwiz",
		date      = "July 08, 2010",
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

local effect = nil
local pos = nil
local unit = nil

function gadget:Initialize()
	effect = nil
	pos = nil
	unit = nil
end

function gadget:GameFrame(f)
	if not GG.Darius then return end
	if (debug_message) then debug_message("Darius is Accessible") end
	local selectedCard = GG.Darius:GetSelectedSpecial()
	if not (effect == GG.Darius:GetEffect()) then
		if (debug_message) then debug_message("Getting Effect") end
		effect = GG.Darius:GetEffect()
		pos = nil
		unit = nil
	end

	if (effect) and (type(effect) == "table") then
		if (debug_message) then debug_message("Effect is valid") end
		if ((effect.needsPos) and (not pos)) then return end
		if ((effect.needsUnit) and (not unit)) then return end

		if (debug_message) then debug_message("Calling Effect") end
		effect.effect(pos, unit)

		GG.Darius:DiscardCard(selectedCard, true)
		pos = nil
		unit = nil
	end
end

function gadget:RecvLuaMsg(msg, playerID)
	if string.find(msg, "EffectPos:") then
		pos = nil
		coords = msg:gsub("EffectPos:","")
		if (debug_message) then debug_message(coords) end
		pos = {}
		for word in string.gmatch(coords, "%w+.%w+") do
			table.insert(pos, word)
		end
		if (debug_message) then if (pos) then debug_message(tostring(pos[1]) ..",".. tostring(pos[2]) ..",".. tostring(pos[3])) else debug_message(tostring(pos)) end end
		if (not pos[3]) then pos = nil end
		if (debug_message) then if (pos) then debug_message(tostring(pos[1]) ..",".. tostring(pos[2]) ..",".. tostring(pos[3])) else debug_message(tostring(pos)) end end
	end
	if string.find(msg, "EffectUnit:") then
		unit = tonumber(msg:gsub("EffectUnit:",""), 10)
		if (debug_message) then debug_message(tostring(unit)) end
	end
end

------------------------------------------------
else --unsynced
------------------------------------------------

end -- End synced check
