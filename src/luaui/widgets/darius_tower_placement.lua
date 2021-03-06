function widget:GetInfo()
	return {
		name = "Simple Tower Placement Widget",
		desc = "Click anywhere to send a command for gadget to build a tower there",
		author = "Jammer",
		date = "June 2010",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true,
	}
end

local spEcho = Spring.Echo

local tower

function widget:Update()
	if WG.Darius then
		tower = WG.Darius:GetTower()
	end
end

function widget:MousePress(x,y,button)
	if (button == 1) then
		-- If we are over a chili element then return
		if (WG.Chili) then if (WG.Chili:IsAbove(x,y)) then return end end
		if not (tower == nil) then
			-- Converts 2d coordinates of the mouse position to 3d coordinates
			local _,pos = Spring.TraceScreenRay(x,y,true,false) 
			-- Widgets can't create units so sends message to a gadget
			if (pos) then
				Spring.SendLuaRulesMsg("PlaceTower "..tower.." "..tostring(pos[1]).." "..tostring(pos[2]).." "..tostring(pos[3]))
				--spEcho("PlaceTower "..tower.." "..tostring(pos[1]).." "..tostring(pos[2]).." "..tostring(pos[3]))
			end
		end
	end	
end