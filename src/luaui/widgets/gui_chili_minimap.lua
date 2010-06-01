function widget:GetInfo()
  return {
    name      = "Chili Minimap",
    desc      = "v0.8 Chili Minimap",
    author    = "Licho",
    date      = "@2010",
    license   = "GNU GPL, v2 or later",
    layer     = 50,
    experimental = false,
    enabled   = false --  loaded by default?
  }
end


local window_minimap
local Chili
local glDrawMiniMap = gl.DrawMiniMap
local glResetState = gl.ResetState
local glResetMatrices = gl.ResetMatrices



local function AdjustToMapAspectRatio(w,h)
	if (Game.mapX > Game.mapY) then
		return w, w*Game.mapY/Game.mapX
	end
	return h*Game.mapX/Game.mapY, h
end


options_section = 'Interface'
options = {
	order = { 'use_map_ratio' },
	use_map_ratio = {
		name = 'Obey Map Aspect Ratio',
		type = 'bool',
		value = true,
		OnChange = function()
			if (options.use_map_ratio.value) then 
				local w,h = AdjustToMapAspectRatio(300, 300)
				window_minimap:Resize(w,h,false,false)
			end 
			window_minimap.fixedRatio = options.use_map_ratio.value;			
		end,
	},
}


function widget:Initialize()
	if (Spring.GetMiniMapDualScreen()) then
		Spring.Echo("ChiliMinimap: auto disabled (DualScreen is enabled).")
		widgetHandler:RemoveWidget()
		return
	end

	if (not WG.Chili) then
		widgetHandler:RemoveWidget()
		return
	end

	Chili = WG.Chili

	local w,h = 300,300
	if (options.use_map_ratio.value) then
		w,h = AdjustToMapAspectRatio(w,h)
	end

	window_minimap = Chili.Window:New{  
		dockable = true,
		name = "minimap",
		x = 0,  
		y = 0,
		width  = w,
		height = h,
		parent = Chili.Screen0,
		draggable = true,
		resizable = true,
		fixedRatio = options.use_map_ratio.value,
		dragUseGrip = true,
		minimumSize = {50,50},
	}
	gl.SlaveMiniMap(true)
end


function widget:Shutdown()
	--// reset engine default minimap rendering
	gl.SlaveMiniMap(false)
	Spring.SendCommands("minimap geo " .. Spring.GetConfigString("MiniMapGeometry"))

	--// free the chili window
	if (window_minimap) then
		window_minimap:Dispose()
	end
end 


local lx, ly, lw, lh

function widget:DrawScreen() 
	if (lw ~= window_minimap.width or lh ~= window_minimap.height or lx ~= window_minimap.x or ly ~= window_minimap.y) then 
		local cx,cy,cw,ch = Chili.unpack4(window_minimap.clientArea)
		cx,cy = window_minimap:LocalToScreen(cx,cy)
		local vsx,vsy = gl.GetViewSizes()
		gl.ConfigMiniMap(cx,vsy-ch-cy,cw,ch)
		lx = window_minimap.x
		ly = window_minimap.y
		lh = window_minimap.height
		lw = window_minimap.width
	end

	gl.PushAttrib(GL.ALL_ATTRIB_BITS)
	gl.MatrixMode(GL.PROJECTION)
	gl.PushMatrix()
	gl.MatrixMode(GL.MODELVIEW)
	gl.PushMatrix()

	glDrawMiniMap()

	gl.MatrixMode(GL.PROJECTION)
	gl.PopMatrix()
	gl.MatrixMode(GL.MODELVIEW)
	gl.PopMatrix()
	gl.PopAttrib()
end 
