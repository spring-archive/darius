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
local spEcho           = Spring.Echo
local spGetGameSeconds = Spring.GetGameSeconds

--local debug_message = spEcho

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

local card = nil
local effect = nil
local pos = nil
local unit = nil

local active = {}

local function RunEffects()
	for index, effect in pairs(active) do
		if (effect.continuous) then effect.continuous() end
		if (spGetGameSeconds() - effect.time) > (effect.duration or 0) then
			if (effect.stop) then effect.stop() end
			table.remove(active, index)
		end
	end
end

function gadget:Initialize()
	effect = nil
	pos = nil
	unit = nil
end

function gadget:GameFrame(f)
	RunEffects()
	if not GG.Darius then return end
	if (debug_message) then debug_message("Darius is Accessible") end
	if not (effect == GG.Darius:GetEffect()) then
		if (debug_message) then debug_message("Getting Effect") end
		card = GG.Darius:GetSelectedSpecial() --So we discard the right card
		effect = GG.Darius:GetEffect()
		pos = nil
		unit = nil
	end

	if (effect) and (type(effect) == "table") then
		if (debug_message) then debug_message("Effect is valid") end
		if ((effect.reqPos) and (not pos)) then return end
		if ((effect.reqUnit) and (not unit)) then return end

		if (debug_message) then debug_message("Starting Effect") end
		effect.time = spGetGameSeconds()
		table.insert(active, effect)
		GG.Darius:DiscardCard(card, true)

		if (effect.start) then effect.start(pos, unit) end

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
