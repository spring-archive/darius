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

local spEcho = Spring.Echo

if (not gadgetHandler:IsSyncedCode()) then
	return false -- no unsynced code
end

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
	if (effect ~= GG.Darius:GetEffect()) then
		effect = GG.Darius:GetEffect()
		pos = nil
		unit = nil
	end

	if (effect ~= nil) and (type(effect) == "table") then
		if ((effect.needsPos) and (not pos)) then return end
		if ((effect.needsUnit) and (not unit)) then return end

		effect.effect(pos, unit)

		GG.Darius:DiscardSelected()
		pos = nil
		unit = nil
	end
end

function gadget:RecvLuaMsg(msg, playerID)
	-- "EffectPos:"
	-- "EffectUnit:"
end
