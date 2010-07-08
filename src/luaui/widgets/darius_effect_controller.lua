function widget:GetInfo()
	return {
		name = "Effect Controller Widget",
		desc = "Sends information on clicked units or positions",
		author = "xcompwiz",
		date = "July 08, 2010",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true,
	}
end

local spEcho            = Spring.Echo
local spSendLuaRulesMsg = Spring.SendLuaRulesMsg

function widget:MousePress(x,y,button)
	-- If we are over a chili element then return
	if (WG.Chili) then if (WG.Chili:IsAbove(x,y)) then return end end
	if not (WG.Darius) then return end

	if (WG.Darius:GetEffect() ~= nil) then
		-- Converts 2d coordinates of the mouse position to 3d coordinates
		local _, pos = Spring.TraceScreenRay(x,y,true,false) 
		local type, unitID = Spring.TraceScreenRay(x,y)
		if (pos) then
			--spEcho("EffectPos:" .. tostring(pos[1]) ..",".. tostring(pos[2]) ..",".. tostring(pos[3]))
			spSendLuaRulesMsg("EffectPos:" .. tostring(pos[1]) ..",".. tostring(pos[2]) ..",".. tostring(pos[3]))
		end
		if ((type == "unit") and (unitID)) then
			--spEcho("EffectUnit:" .. unitID)
			spSendLuaRulesMsg("EffectUnit:" .. unitID)
		end
	end
end