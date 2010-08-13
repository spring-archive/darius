function widget:GetInfo()
  return {
    name      = "Widget selector",
    desc      = "ChiliUI-based widget enabling/disabling menu",
    author    = "malloc (based on original gui_crudemenu.lua code by CarRepairer)",
    date      = "13th of August",
    layer     = 0,
    handler   = true,
    enabled   = true,
  }
end



--------------
-- Speed-up --
--------------

local spGetConfigInt = Spring.GetConfigInt
local spSendCommands = Spring.SendCommands
local spEcho         = Spring.Echo



-------------------
-- Config loader --
-------------------

local VFSMODE      = VFS.RAW_FIRST
local file = LUAUI_DIRNAME .. "Configs/gui_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color = confdata.color



---------------------
-- Local variables --
---------------------

local window_widgetlist
local widget_categorize = true

local C_HEIGHT = 20
local scrH, scrW = 0,0

local settings = {
	widgets = {}
}

local widget_checks = {}

local groupDescs = {
	api     = "For Developers",
	camera  = "Camera",
	cmd     = "Commands",
	dbg     = "For Developers",
	gfx     = "Effects",
	gui     = "GUI",
	hook    = "Commands",
	ico     = "GUI",
	init    = "Initialization",
	minimap = "Minimap",
	snd     = "Sound",
	test    = "For Developers",
	unit    = "Units",
	ungrouped  = "Ungrouped",
}



---------------------
-- Local functions --
---------------------

local function KillWidgetList()
	if window_widgetlist then
		settings.wl_x = window_widgetlist.x
		settings.wl_y = window_widgetlist.y
		settings.wl_h = window_widgetlist.clientHeight
		settings.wl_w = window_widgetlist.clientWidth
	end

	window_widgetlist:Dispose()
	window_widgetlist = nil
end


-- Update colors for labels of widget checkboxes in widgetlist window
local function checkWidget(widget)
	local name = (type(widget) == 'string') and widget or widget.whInfo.name
	local wcheck = widget_checks[name]

	if wcheck then
		local wdata = widgetHandler.knownWidgets[name]
		local order = widgetHandler.orderList[name]
		local enabled = order and (order > 0)
		local hilite_color = (wdata.active and color.green) or (enabled and color.orange) or color.gray
		wcheck.font:SetColor(hilite_color)
	end
end


-- Make widgetlist window
local function MakeWidgetList()
	widget_checks = {}

	if window_widgetlist then
		window_widgetlist:Dispose()
	end

	local widget_children = {}
	local widgets_cats = {}
	local window_height = settings.wl_h
	local window_width = settings.wl_w
	local buttonWidth = window_width - 20

	for name,data in pairs(widgetHandler.knownWidgets) do
		local name = name
		local name_display = name .. (data.fromZip and ' (mod)' or '')
		local data = data
		local _, _, category = string.find(data.basename, "([^_]*)")

		if not groupDescs[category] then
			category = 'ungrouped'
		end

		local catdesc = groupDescs[category]

		if not widget_categorize then
			catdesc = 'Ungrouped'
		end

		widgets_cats[catdesc] = widgets_cats[catdesc] or {}

		widgets_cats[catdesc][#(widgets_cats[catdesc]) + 1] =
		{
			catname      = catdesc,
			name_display = name_display,
			name         = name,
			active       = data.active,
			desc         = data.desc,
			author       = data.author,
		}
	end

	local widgets_cats_i = {}

	for catdesc, catwidgets in pairs(widgets_cats) do
		widgets_cats_i[#widgets_cats_i + 1] = {catdesc, catwidgets}
	end

	--Sort widget categories
	table.sort(widgets_cats_i, function(t1,t2)
		return t1[1] < t2[1]
	end)

	i = 0
	for _, data in pairs(widgets_cats_i) do
		local catdesc = data[1]
		local catwidgets = data[2]

		--Sort widget names within this category
		table.sort(catwidgets, function(t1,t2)
			return t1.name_display < t2.name_display
		end)
		i = i + 1
		widget_children[#widget_children + 1] =
			Label:New{ caption = '- '.. catdesc ..' -', textColor = color.sub_header, align= 'center', }

		for _, wdata in ipairs(catwidgets) do
			i = i + 1

			local order = widgetHandler.orderList[wdata.name]
			local enabled = order and (order > 0)

			--Add checkbox to table that is used to update checkbox label colors when widget becomes active/inactive
			widget_checks[wdata.name] = Checkbox:New{
					caption = wdata.name_display,
					checked = enabled,
					tooltip = '(By ' .. wdata.author .. ")\n" .. wdata.desc,
					OnChange = {
						function(self)
							widgetHandler:ToggleWidget(wdata.name)
						end,
					},
				}

			widget_children[#widget_children + 1] = widget_checks[wdata.name]
			checkWidget(wdata.name) --sets color of label for this widget checkbox
		end
	end

	window_widgetlist = Window:New{
		x = settings.wl_x,
		y = settings.wl_y,
		clientWidth  = window_width,
		clientHeight = window_height,
		parent = screen0,
		backgroundColor = color.sub_bg,
		caption = 'Widget List (F11)',
		minimumSize = {300, 400},

		children = {
			ScrollPanel:New{
				x = 1,
				y = 15,
				right = 5,
				bottom = C_HEIGHT * 2,
				children = {
					StackPanel:New {
						x = 1,
						y = 1,
						height = #widget_children * C_HEIGHT,
						right = 1,
						itemPadding = {1, 1,1 ,1 },
						itemMargin = {0, 0, 0,0 },
						children = widget_children,
					},
				},
			},
			--close button
			Button:New{
				caption = 'Close',
				OnMouseUp = { KillWidgetList },
				backgroundColor=color.sub_close_bg,
				textColor=color.sub_close_fg,
				x=1,
				bottom=1,
				width='40%',
				height=C_HEIGHT,

			},
			-- categorization checkbox
			Checkbox:New{
				caption = 'Categorize',
				tooltip = 'List widgets by category',
				OnMouseUp = { function() widget_categorize = not widget_categorize end, KillWidgetList, MakeWidgetList },
				textColor=color.sub_fg,
				checked = widget_categorize,
				x = '50%',
				width = '30%',
				height= C_HEIGHT,
				bottom=1,
			},
		},
	}
	AdjustWindow(window_widgetlist)
end


-- Original widget list
local function ShowWidgetList(self)
	spSendCommands{"luaui selector"}
end



--------------
-- Call-ins --
--------------

function ActionWidgetList()
	if window_widgetlist then
		KillWidgetList()
	else
		MakeWidgetList()
	end
end


function widget:Initialize()
	if (not WG.Chili) then
		widgetHandler:RemoveWidget(widget)
		return
	end

	WG.crude = {}

	-- Chili-UI widget list
	WG.crude.ShowWidgetList2 = function(self)
		MakeWidgetList()
	end

	if not WG.Layout then
		WG.Layout = {}
	end

	-- clears all saved settings of custom widgets stored in crudemenu's config
	WG.crude.ResetWidgets = function()
		for wname,_ in pairs(settings.widgets) do
			local order = widgetHandler.orderList[wname]
			local enabled = order and (order > 0)
			settings.widgets[wname] = {}
			if enabled then
				widgetHandler:ToggleWidget(wname)
				widgetHandler:ToggleWidget(wname)
			end
		end
	end

	-- setup Chili
	Chili = WG.Chili
	Button = Chili.Button
	Label = Chili.Label
	Checkbox = Chili.Checkbox
	Window = Chili.Window
	ScrollPanel = Chili.ScrollPanel
	StackPanel = Chili.StackPanel
	screen0 = Chili.Screen0

	widget:ViewResize(Spring.GetViewGeometry())

	-- set default positions of windows on first run
	if not settings.pos_x then
		settings.pos_x = scrW/3
		settings.pos_y = scrH
		settings.sub_pos_x = scrW/2
		settings.sub_pos_y = scrH/2
		settings.vol_x = scrW/3
		settings.vol_y = scrH/2
	end
	if not settings.wl_x then -- widget list
		settings.wl_h = 0.7*scrH
		settings.wl_w = 300

		settings.wl_x = (scrW - settings.wl_w)/2
		settings.wl_y = (scrH - settings.wl_h)/2
	end
	if not settings.keybounditems then
		settings.keybounditems = {}
	end

	widgetHandler.actionHandler:AddAction(widget, "crudewidgetlist", ActionWidgetList, nil, "t")

	Spring.SendCommands({"unbindkeyset f11"})
	Spring.SendCommands("bind f11 crudewidgetlist")

	-- when widgets are loaded, unloaded or toggled
	widgetHandler.OriginalInsertWidget = widgetHandler.InsertWidget

	-- insert widget
	widgetHandler.InsertWidget = function(self, widget)
		local ret = self:OriginalInsertWidget(widget)

		checkWidget(widget)
		return ret
	end

	widgetHandler.OriginalRemoveWidget = widgetHandler.RemoveWidget

	-- remove widget
	widgetHandler.RemoveWidget = function(self, widget)
		local ret = self:OriginalRemoveWidget(widget)
		checkWidget(widget)
		return ret
	end

	widgetHandler.OriginalToggleWidget = widgetHandler.ToggleWidget

	-- toggle widget
	widgetHandler.ToggleWidget = function(self, name)
		local ret = self:OriginalToggleWidget(name)
		local w = widgetHandler:FindWidget(name)
		if w then
			checkWidget(w)
		else
			checkWidget(name)
		end
		return ret
	end

end


function widget:Shutdown()
	-- Restore widgethandler functions to original states
	if widgetHandler.OriginalRemoveWidget then
		widgetHandler.InsertWidget = widgetHandler.OriginalInsertWidget
		widgetHandler.OriginalInsertWidget = nil
		widgetHandler.RemoveWidget = widgetHandler.OriginalRemoveWidget
		widgetHandler.OriginalRemoveWidget = nil
		widgetHandler.ToggleWidget = widgetHandler.OriginalToggleWidget
		widgetHandler.OriginalToggleWidget = nil
	end

	widgetHandler.actionHandler:RemoveAction(widget, "crudewidgetlist", nil)
  Spring.SendCommands({"bind f11 luaui selector"})
  Spring.SendCommands("unbind f11 crudewidgetlist")
end


function widget:ViewResize(vsx, vsy)
	scrW = vsx
	scrH = vsy
end