function widget:GetInfo()
  return {
    name      = "Crude Menu",
    desc      = "v0.97.3 Extremely Powerful Chili Menu.",
    author    = "CarRepairer",
    date      = "2009-06-02",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    handler   = true,
    experimental = false,	
    enabled   = true,
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local spGetConfigInt    		= Spring.GetConfigInt
local spSendCommands			= Spring.SendCommands

local echo = Spring.Echo

--------------------------------------------------------------------------------

-- Config file data
local VFSMODE      = VFS.RAW_FIRST
local file = LUAUI_DIRNAME .. "Configs/crudemenu_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local menu_tree = confdata.menu_tree
local game_menu_tree = confdata.game_menu_tree 
local color = confdata.color
local title_text = confdata.title
local help_menu_tree = confdata.help_tree
local menu_tree2 = {}
local game_menu_tree2 = {}
local help_menu_tree2 = {}
local game_menu_index = -1
local main_menu_index = -1
local flatwindowlist = {}

--------------------------------------------------------------------------------

-- Chili control classes
local Chili
local Button
local Label
local Colorbars
local Checkbox
local Window
local ScrollPanel
local StackPanel
local LayoutPanel
local Grid
local Trackbar
local TextBox
local Image
local Progressbar
local Colorbars
local screen0

--------------------------------------------------------------------------------
-- Global chili controls
local window_widgetlist
local window_crude 
local window_flags
local window_help
local window_getkey
local lbl_gtime, lbl_fps
local cmsettings_index = -1
local window_sub_cur
local widget_categorize = true

--------------------------------------------------------------------------------
-- Misc
local B_HEIGHT = 35
local C_HEIGHT = 20

local scrH, scrW = 0,0
local cycle = 1
local curSubKey = ''

--------------------------------------------------------------------------------
-- Key bindings
include("keysym.h.lua")
local keybinds = {}
local keybounditems = {}
local keybounditems_i = {}
local keysyms = {}
for k,v in pairs(KEYSYMS) do
	keysyms['' .. v] = k	
end
--[[
for k,v in pairs(KEYSYMS) do
	keysyms['' .. k] = v
end
--]]
local get_key = false
local kbval
local kb_mkey
local kb_mindex
local kb_item


--------------------------------------------------------------------------------
-- widget settings
local custom_widget_settings = {}
local custsettings = {
	Misc = {},
	Effects = {},
	View = {},
	Video = {},
	Interface = {},
	Game = {},
}
	
--------------------------------------------------------------------------------
-- Widget globals
WG.crude = {}
if not WG.Layout then
	WG.Layout = {}
end

--------------------------------------------------------------------------------
-- Luaui config settings
local settings = {
	versionmin = 50,
	lang = 'en',
	widgets = {},
	show_crudemenu = false,
}


--------------------------------------------------------------------------------
--For widget list
local widget_checks = {}
local green = {0,1,0,1}
local orange =  {1,0.5,0,1}
local gray =  {0.7,0.7,0.7,1}
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
	ungrouped    = "Ungrouped",
}

--------------------------------------------------------------------------------
--Mouse cursor icons

local cursorNames = {
  'cursornormal',
  'cursorareaattack',
  'cursorattack',
  'cursorattack',
  'cursorbuildbad',
  'cursorbuildgood',
  'cursorcapture',
  'cursorcentroid',
  'cursordwatch',
  'cursorwait',
  'cursordgun',
  'cursorattack',
  'cursorfight',
  'cursorattack',
  'cursorgather',
  'cursorwait',
  'cursordefend',
  'cursorpickup',
  'cursormove',
  'cursorpatrol',
  'cursorreclamate',
  'cursorrepair',
  'cursorrevive',
  'cursorrepair',
  'cursorrestore',
  'cursorrepair',
  'cursorselfd',
  'cursornumber',
  'cursorwait',
  'cursortime',
  'cursorwait',
  'cursorunload',
  'cursorwait',
}

WG.crude.SetCursor = function(cursorSet)
  for _, cursor in ipairs(cursorNames) do
    local topLeft = (cursor == 'cursornormal' and cursorSet ~= 'k_haos_girl')
    Spring.ReplaceMouseCursor(cursor, cursorSet.."/"..cursor, topLeft)
  end
end

WG.crude.RestoreCursor = function()
  for _, cursor in ipairs(cursorNames) do
    local topLeft = (cursor == 'cursornormal')
    Spring.ReplaceMouseCursor(cursor, cursor, topLeft)
  end
end

--Reset custom widget settings, defined in Initialize
WG.crude.ResetWidgets = function() end

----------------------------------------------------------------

local function CopyTable(outtable,intable)
  for i,v in pairs(intable) do 
    if (type(v)=='table') then
      if (type(outtable[i])~='table') then outtable[i] = {} end
      CopyTable(outtable[i],v)
    else
      outtable[i] = v
    end
  end
end


-- function GetTimeString() taken from trepan's clock widget
local function GetTimeString()
  local secs = math.floor(Spring.GetGameSeconds())
  if (timeSecs ~= secs) then
    timeSecs = secs
    local h = math.floor(secs / 3600)
    local m = math.floor((secs % 3600) / 60)
    local s = math.floor(secs % 60)
    if (h > 0) then
      timeString = string.format('%02i:%02i:%02i', h, m, s)
    else
      timeString = string.format('%02i:%02i', m, s)
    end
  end
  return timeString
end

----------------------------------------------------------------
--May not be needed with new chili functionality
local function AdjustWindow(window)
	local nx
	if (0 > window.x) then
		nx = 0
	elseif (window.x + window.width > screen0.width) then
		nx = screen0.width - window.width
	end

	local ny
	if (0 > window.y) then
		ny = 0
	elseif (window.y + window.height > screen0.height) then
		ny = screen0.height - window.height
	end

	if (nx or ny) then
		window:SetPos(nx,ny)
	end
end

-- Kill submenu window
local function KillSubWindow()
	if window_sub_cur then
		if window_sub_cur then
			settings.sub_pos_x = window_sub_cur.x
			settings.sub_pos_y = window_sub_cur.y
		end
		window_sub_cur:Dispose()
		window_sub_cur = nil
		curSubKey = ''
	end
end

-- Kill Widgetlist window
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
		local hilite_color = (wdata.active and green) or (enabled and orange) or gray
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
			
		widgets_cats[catdesc][#(widgets_cats[catdesc])+1] = 
		{	
			catname 		= catdesc,
			name_display	= name_display,
			name		 	= name,
			active 			= data.active,
			desc 			= data.desc,
			author 			= data.author,
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
	
	i=0
	for _, data in pairs(widgets_cats_i) do
		local catdesc = data[1]
		local catwidgets = data[2]
	
		--Sort widget names within this category
		table.sort(catwidgets, function(t1,t2)
			return t1.name_display < t2.name_display
		end)
		i=i+1
		widget_children[#widget_children + 1] = 
			Label:New{ caption = '- '.. catdesc ..' -', textColor = color.sub_header, align='center', }
		
		for _, wdata in ipairs(catwidgets) do
			i=i+1
			
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
		minimumSize = {300,400},
		
		children = {
			ScrollPanel:New{
				x=1,
				y=15,
				right=5, 
				bottom = C_HEIGHT*2,
				
				children = {
					StackPanel:New{
						x=1,
						y=1,
						height = #widget_children*C_HEIGHT,
						right = 1,
						
						itemPadding = {1,1,1,1},
						itemMargin = {0,0,0,0},		
						children = widget_children,
					},
				},
			},
			
			--Close button
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
			--Categorization checkbox
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

--Make country chooser window
local function MakeFlags()
	local countries = {
		'au',
		'br',
		'bz',
		'ca',
		'es',
		'fi', 
		'fr', 
		'gb',
		'it',
		'my', 
		'nz',
		'pl',
		'pt',
		'pr',
		'us', 
	}
	local country_langs = {
		br='bp',
		es='es',
		fi='fi', 
		fr='fr',
		it='it',
		my='my', 
		pl='pl',
		pt='pt',
		pr='es',
	}

	local flagChildren = {}
	local flagCount = 0
	for _,country in ipairs(countries) do
		local countryLang = country_langs[country] or 'en'
		flagCount = flagCount + 1
		flagChildren[#flagChildren + 1] = Image:New{ file=":cn:".. LUAUI_DIRNAME .. "Images/flags/".. country ..'.png', }
		flagChildren[#flagChildren + 1] = Button:New{ caption = country:upper(), 
			textColor = color.sub_button_fg,
			backgroundColor = color.sub_button_bg,
			OnMouseUp = { 
				function(self) 
					Spring.Echo('Setting local language to "' .. countryLang .. '"') 
					WG.lang = countryLang 
					settings.lang = countryLang
				end 
			} 
		}
	end
	local window_height = 300
	local window_width = 170
	window_flags = Window:New{
		caption = 'Choose Your Location',
		x = settings.sub_pos_x,  
		y = settings.sub_pos_y,  
		clientWidth  = window_width,
		clientHeight = window_height,
		parent = screen0,
		backgroundColor = color.sub_bg,
		children = {
			ScrollPanel:New{
				x=0,y=15,
				right=5,bottom=0+B_HEIGHT,
				
				children = {
					Grid:New{
						columns=2,
						x=0,y=0,
						width=window_width-40,
						height=500,
						children = flagChildren,
					}
				}
			},
			--close button
			Button:New{ caption = 'Close',  x=10, y=0-B_HEIGHT, bottom=5, right=5, 
				OnMouseUp = { function(self) window_flags:Dispose() end },  
				width=window_width-20, backgroundColor = color.sub_close_bg, textColor = color.sub_close_fg,
				},
		}
	}
end

--Make help text window
local function MakeHelp(caption, text)
	local window_height = 400
	local window_width = 400
	
	window_help = Window:New{
		caption = caption or 'Help?',
		x = settings.sub_pos_x,  
		y = settings.sub_pos_y,  
		clientWidth  = window_width,
		clientHeight = window_height,
		parent = screen0,
		backgroundColor = color.sub_bg,
		children = {
			ScrollPanel:New{
				x=0,y=15,
				right=5,
				bottom=B_HEIGHT,
				height = window_height - B_HEIGHT*3 ,
				children = {
					TextBox:New{ x=0,y=10, text = text, textColor = color.sub_fg, width  = window_width - 40, }
				}
			},
			--Close button
			Button:New{ caption = 'Close', OnMouseUp = { function(self) self.parent:Dispose() end }, x=10, bottom=1, right=50, height=B_HEIGHT, backgroundColor = color.sub_close_bg, textColor = color.sub_close_fg, },
		}
	}
end

--Integrate widget's settings into menu settings tree
local function IntegrateWidgetSettings(w, options)

	local name = w.whInfo.name
	if not settings.widgets then
		settings.widgets = {}
	end
	
	--Add empty onchange function if doesn't exist
	for k,option in pairs(options) do
		if not option.OnChange or type(option.OnChange) ~= 'function' then
			options[k].OnChange = function() end
		end
	end	
	
	-- Add custom widget settings data to crudemenu config if it doesn't exist, pull stored settings if it does
	if not settings.widgets[name] then
		settings.widgets[name] = {}
	end
	for k,option in pairs(options) do
		if settings.widgets[name][k] ~= nil then --can be false
			options[k].value = settings.widgets[name][k]
		end
	end

	--Generate order table if it doesn't exist
	local options_ordered = {}
	if not options.order then
		options.order = {}
		for k,v in pairs(options) do
			options.order[#(options.order) + 1] = k
		end
	end
	
	-- Use order table to order the options
	for i,v in ipairs(options.order) do
		local option = options[v]
		option.key = v
		options_ordered[i] = options[v]
	end
	
	local tree = {}
	
	for _,option in ipairs(options_ordered) do
		local k = option.key
		
		
		if not option.OnChange or type(option.OnChange) ~= 'function' then
			--option.OnChange = function() end
		end
		
		local origOnChange = w.options[k].OnChange
		
		if option.type == 'bool' then
			option.OnChange = 
				function(self)
					if self then
						w.options[k].value = self.checked
					end
					settings.widgets[w.whInfo.name][k] = w.options[k].value
					--w.options[k].OnChange()
					
					origOnChange()
				end
			option.value = w.options[k].value
		
		elseif option.type == 'number' then
			option.OnChange = 
				function(self) 
					if self then
						w.options[k].value = self.value
					end
					settings.widgets[w.whInfo.name][k] = w.options[k].value
					--w.options[k].OnChange()
					origOnChange()
				end
			option.value = w.options[k].value	
		
		elseif option.type == 'list' then
			option.OnChange = 
				function(key) 
					w.options[k].value = key
					settings.widgets[w.whInfo.name][k] = w.options[k].value
					origOnChange()
				end
			option.value = w.options[k].value
		
		elseif option.type == 'colors' then
			option.OnChange = 
				function(self) 
					if self then
						w.options[k].value = self.color
					end
					settings.widgets[w.whInfo.name][k] = w.options[k].value
					--w.options[k].OnChange()
					origOnChange()
				end
			option.value = w.options[k].value	
					
		else
			--option.value = w.options[k].value
		end
		
		--Don't run onchange if setting is a button
		if option.type ~= 'button' and (origOnChange ~= nil) then
			origOnChange()
		end
		
		tree[#tree+1] = option
	end
	return tree
end

--Store custom widget settings for a widget
local function AddCustSettings(widget)
	local options = widget.options
	if type(options) == 'table' then
		options = IntegrateWidgetSettings(widget, options)
		local section = widget.options_section or 'Misc'
		custsettings[section][widget.whInfo.name] = {name=widget.whInfo.name, options=options, desc=widget.whInfo.desc}
	end
end

--Unstore custom widget settings for a widget
local function RemCustSettings(widget)
	local options = widget.options
	if type(options) == 'table' then
		local section = widget.options_section or 'Misc'
		custsettings[section][widget.whInfo.name] = nil
	end
end

--Store custom widget settings for all active widgets
local function AddAllCustSettings()
	local cust_tree = {}
	for _,widget in ipairs(widgetHandler.widgets) do
		AddCustSettings(widget)
	end
end

-- Convert shorthand settings tree (from crudemenu_conf file) 
-- to longhand (IceUI style) settings tree
local function ShorthandTree2Long(tree, name)
	local rettree = {}
	
	local name = name
	
	local tooltip_start = name and name:find('|')
	local tooltip = ''
	if tooltip_start then
		tooltip = name:sub(tooltip_start+1)
		name 	= name:sub(1,tooltip_start-1)
	end

	rettree.desc = tooltip
	
	if type(tree) == 'table'  and #tree > 0 and type(tree[1]) == 'table' then
		rettree.name = name
		rettree.type = 'menu'
		
		local subtree = {}
		local order = {}
		for _,data in ipairs( tree ) do
			local subname = ''
			if #data == 2 then
				if type(data[1]) == 'string' and type(data[2]) == 'string' then
					subname = data[1]
					subtree[ subname ] = {
						type = 'text',
						name = subname,
						value = data[2],
					}
				else
					subname = data[1]
					subtree[ subname ] = ShorthandTree2Long(data[2], data[1])
				end
			elseif #data == 1 then
				subname = 'lbl'.. data[1]
				subtree[ subname ] = {
					type = 'label',
					name = data[1],
					value = data[1],
				}
			elseif #data == 0 then
				subname = 'lblempty' .. (math.random()) 
				subtree[ subname ] = {
					type = 'label',
					name = 'empty',
					value = '',
				}
			end
			order[#order+1] = subname
		end
		
		--subtree.order = order
		rettree.order = order
		rettree.value = subtree

	-- TERMINAL
	else
		-- Add trackbar for settings that start with "tr_"
		if name and name:sub(1,3) == 'tr_' then
			rettree.name = name:sub(4)
			rettree.type = 'number'
			rettree.value = tree.value
			rettree.min = tree.min
			rettree.max = tree.max
			rettree.step = tree.step
			rettree.OnChange = tree.action
		
		else
			rettree.type = 'button'
			rettree.name = name or 'missing'
			rettree.OnChange = tree
		end
		
		
	end
	
	return rettree
end

-- Make submenu window based on index from flat window list
-- Defined later
local function MakeSubWindow(key)
end

-- Assign a keybinding to settings and other tables that keep track of related info
local function AssignKeyBind(hotkey, menukey, itemindex, item)
	if not keybinds[hotkey.key] then
		keybinds[hotkey.key] = {}
	end
	local kbfunc = item.OnChange
	if item.type == 'bool' then
		kbfunc = function()
			newval = not flatwindowlist[menukey].tree[itemindex].value	
			flatwindowlist[menukey].tree[itemindex].value = newval 
			item.OnChange({checked=newval})
			
			if menukey == curSubKey then
				MakeSubWindow(menukey)
			end
		end
	end
	keybinds[hotkey.key][hotkey.mod] = kbfunc
	keybounditems_i[menukey .. '_' .. itemindex] = hotkey
	settings.keybounditems[menukey .. '_' .. item.name] = hotkey
end

-- Unsssign a keybinding from settings and other tables that keep track of related info
local function UnassignKeyBind(hotkey, menukey, itemindex, item)
	keybinds[hotkey.key][hotkey.mod] = nil

	keybounditems_i[menukey .. '_' .. itemindex] = nil
	settings.keybounditems[menukey .. '_' .. item.name] = nil
end


-- Convert settings tree into flat list of settings rather than tree, 
-- indexed by each setting's name in the format: "Settings_Interface_Whatever"
local function flattenTree(tree, parent)
	local tree2 = {}
	CopyTable(tree2, tree)
	
		
	if tree2.type ~= 'menu' then
		return tree2
	end
		
	local curkey = parent .. '_' .. tree2.name
	
	local temptree = {}
	
	--Generate automatic order table if it doesn't exist, to determine order of settings
	if not tree2.order or #(tree2.order) == 0 then
		tree2.order = {}
		local i = 1
		for k,v in pairs(tree2.value) do
			if k ~= 'order' then
				tree2.order[i] = k
				i = i + 1
			end
		end
	end
	
	local valuetree_ordered = {}
	for i, elemname in ipairs(tree2.order) do
		valuetree_ordered[i] = tree2.value[elemname]
	end
	
	-- If this is the section of the settings menu, add custom widget settings to it
	local custsettingsection = custsettings[tree2.name]
	if custsettingsection then
	
		local addedonce = false
		--sort custom widget settings by alpha and add them to windowlist
		local custsettingsection_i = {}
		for _, cust_tree_data in pairs(custsettingsection) do
			custsettingsection_i[#custsettingsection_i+1] = cust_tree_data
		end
		table.sort(custsettingsection_i, function(t1,t2)
			return t1.name < t2.name
		end)
		for _, cust_tree_data in ipairs(custsettingsection_i) do
			
			--add separation
			if not addedonce then
				addedonce = true
				valuetree_ordered[#valuetree_ordered+1] = { type='label', name='lblwidget'..tree2.name, value='Widget settings' }				
			end
		
			valuetree_ordered[#valuetree_ordered+1] = { type='menu', name=cust_tree_data.name, value=cust_tree_data.options, desc=cust_tree_data.desc}
		end
	end
	
	for k, subtree in ipairs(valuetree_ordered) do
		
		local subcount = flattenTree(subtree, curkey)
		if type(subcount) == 'string' then
			temptree[#temptree+1] = { type='menu', name=subtree.name .. '...', subindex=subcount, desc=subtree.desc }
		else
			temptree[#temptree+1] = subcount
			
			--Keybindings
			if subcount.type == 'button' or subcount.type == 'bool' then
				local hotkey = settings.keybounditems[curkey .. '_' .. subcount.name] or subcount.hotkey
				if hotkey then
					AssignKeyBind(hotkey, curkey, #temptree, subcount)
				end
			end
			
		end			
	end

	local curparent = parent
	if parent == 'Settings' or parent == 'Game' or parent == 'Help' then
		curparent = false
	end
	flatwindowlist[curkey] = {parent = curparent, tree = temptree, name=tree2.name }
	return curkey 
	
end


-- Spring's widget list
local function ShowWidgetList(self)
	spSendCommands{"luaui selector"} 
end

-- Crudemenu's widget list
WG.crude.ShowWidgetList2 = function(self)
	MakeWidgetList()
end

WG.crude.ShowFlags = function()
	MakeFlags()
end

--Make little window to indicate user needs to hit a keycombo to save a keybinding
local function MakeKeybindWindow(item, menukey, i, hotkey)
	if hotkey then
		UnassignKeyBind(hotkey, menukey, i, item)
	end
	
	local window_height = 80
	local window_width = 300
	
	get_key = true
	kb_mkey = menukey
	kb_mindex = i
	kb_item = item
		
	window_getkey = Window:New{
		caption = 'Set a HotKey',
		x = (scrW-window_width)/2,  
		y = (scrH-window_height)/2,  
		clientWidth  = window_width,
		clientHeight = window_height,
		parent = screen0,
		backgroundColor = color.sub_bg,
		resizable=false,
		draggable=false,
		children = {
			Label:New{ y=10, caption = 'Press a key combo', textColor = color.sub_fg, },
			Label:New{ y=30, caption = '(Hit "Escape" to clear keybinding)', textColor = color.sub_fg, },
		}
	}
end

local function GetReadableHotkeyMod(mod)
	return (mod:find('a') and 'Alt+' or '') ..
		(mod:find('c') and 'Ctrl+' or '') ..
		(mod:find('m') and 'Meta+' or '') ..
		(mod:find('s') and 'Shift+' or '') ..
		''		
end

--Get hotkey action and readable hotkey string
local function GetHotkeyData_i(key, i)
	local hotkey = keybounditems_i[key .. '_' .. i]
	if hotkey then
		return hotkey, GetReadableHotkeyMod(hotkey.mod) .. keysyms[hotkey.key .. '' ]
	end
	
	return nil, 'None'
end

--Make a stack with control and its hotkey "K" button
local function MakeHotkeyedControl(control, key, i, item)
	local hotkey, hotkeystring = GetHotkeyData_i(key, i)
	local kbfunc = function() 
			MakeKeybindWindow(item, key, i, hotkey ) 
		end

	
	return StackPanel:New{
		width = "100%",
		orientation='horizontal',
		resizeItems = false,
		centerItems = false,
		autosize = true,
		itemMargin = {0,0,0,0},
		margin = {0,0,0,0},
		itemPadding = {2,0,0,0},
		padding = {0,0,0,0},
		
		
		children={
			--menu control
			control,
			
			--hotkey button
			Button:New{
				minHeight = 30,
				right=0,
				x=-30,
				caption = 'K', 
				OnMouseUp = { kbfunc },
				backgroundColor = color.sub_button_bg,
				textColor = color.sub_button_fg, 
				tooltip = 'Hotkey: ' .. hotkeystring,
			},
		},
	}
end

-- Make submenu window based on index from flat window list
--local function MakeSubWindow(key)
MakeSubWindow = function(key)
	local windowdata = flatwindowlist[key]
	local menu_name = windowdata.name	
	local tree = windowdata.tree
	local parent_key = windowdata.parent
	
	local settings_height = #tree * B_HEIGHT
	local settings_width = 270
	
	local tree_children = {}
	local hotkeybuttons = {}
	
	for i, data in ipairs(tree) do
		if not data.OnChange then
			data.OnChange = function(self) end
		end
		if not data.desc then
			data.desc = ''
		end
		if data.type == 'button' then	
			local button = Button:New{
				x=0,
				right = 30,
				minHeight = 30,
				caption = data.name, 
				OnMouseUp = {data.OnChange},
				backgroundColor = color.sub_button_bg,
				textColor = color.sub_button_fg, 
				tooltip = data.desc
			}
			tree_children[#tree_children+1] = MakeHotkeyedControl(button, key, i, data)
			
		elseif data.type == 'label' then	
			tree_children[#tree_children+1] = Label:New{ caption = data.value or data.name, textColor = color.sub_header, }
			
		elseif data.type == 'text' then	
			tree_children[#tree_children+1] = 
				Button:New{
					width = "100%",
					minHeight = 30,
					caption = data.name, 
					OnMouseUp = { function() MakeHelp(data.name, data.value) end },
					backgroundColor = color.sub_button_bg,
					textColor = color.sub_button_fg, 
					tooltip=data.desc
				}
			
			
		elseif data.type == 'number' then	
			settings_height = settings_height + B_HEIGHT
			tree_children[#tree_children+1] = Label:New{ caption = data.name, textColor = color.sub_fg, }
			tree_children[#tree_children+1] = 
				Trackbar:New{ 
					width = "100%",
					caption = data.name, 
					value = data.value, 
					trackColor = color.sub_fg, 
					min=data.min or 0, 
					max=data.max or 100, 
					step=data.step or 1, 
					OnMouseUp = {
						function(self) 
							data.OnChange(self)
							flatwindowlist[key].tree[i].value = self.value  
						end
					}, 
					tooltip=data.desc 
				}
			
		elseif data.type == 'bool' then				
			local chbox = Checkbox:New{ 
				--width   = "100%",
				x=0,
				right = 35,
				caption = data.name, 
				checked = data.value or false, 
				
				OnMouseUp = {
					data.OnChange,
					function(self) 
						--flatwindowlist[key].tree[i].OnChange(self)
						
						flatwindowlist[key].tree[i].value = self.checked --line not needed?
					end,
					
					
				}, 
				textColor = color.sub_fg, 
				tooltip   = data.desc,
			}
			--tree_children[#tree_children+1] = chbox
			tree_children[#tree_children+1] = MakeHotkeyedControl(chbox, key, i, data)
			
		elseif data.type == 'list' then	
			tree_children[#tree_children+1] = Label:New{ caption = data.name, textColor = color.sub_header, }
			for _,item in ipairs(data.items) do
				settings_height = settings_height + B_HEIGHT 
				tree_children[#tree_children+1] = 
					Button:New{
						width = "100%",
						caption = item.name, 
						OnMouseUp = { function(self) data.OnChange(item.key) end },
						backgroundColor = color.sub_button_bg,
						textColor = color.sub_button_fg, 
						tooltip=item.desc,
					}
			end
			
			
		elseif data.type == 'menu' then	
			local button = Button:New{
				x=0,
				right = 0,
				minHeight = 30,
				caption = data.name, 
				OnMouseUp = { function() MakeSubWindow(data.subindex) end },
				backgroundColor = color.sub_button_bg,
				textColor = color.sub_button_fg, 
				tooltip=data.desc,
			}
				
			tree_children[#tree_children+1] = button
		
		elseif data.type == 'colors' then
			settings_height = settings_height + B_HEIGHT*2
			tree_children[#tree_children+1] = Label:New{ caption = data.name, textColor = color.sub_fg, }
			tree_children[#tree_children+1] = 
				Colorbars:New{
					width = "100%",
					height = B_HEIGHT*1.5,
					tooltip=data.desc,
					color = data.value or {1,1,1,1},
					OnMouseUp = {
						function(self)
							flatwindowlist[key].tree[i].value = self.color  
							data.OnChange(self)
						end
					},
				}
				
		end
		
	
			
	end
	
	local window_height = 400
	if settings_height < window_height then
		window_height = settings_height+10
	end
	local window_width = 300
	
		
	local window_children = {}
	window_children[#window_children+1] =
		ScrollPanel:New{
			x=0,y=15,
			bottom=B_HEIGHT+20,
			width = '100%',
			children = {
				StackPanel:New{
					x=0,
					y=0,
					right=0,
					orientation = "vertical",
					--width  = "100%",
					height = "100%",
					backgroundColor = color.sub_bg,
					children = tree_children,
					itemMargin = {2,2,2,2},
					resizeItems = false,
					centerItems = false,
					autosize = true,
				},
				
			}
		}
	
	window_height = window_height + B_HEIGHT
	local backButton 
	--back button
	if parent_key then
		window_height = window_height + B_HEIGHT
		window_children[#window_children+1] = Button:New{ caption = 'Back', OnMouseUp = { KillSubWindow, function() MakeSubWindow(parent_key) end,  }, 
			backgroundColor = color.sub_back_bg,textColor = color.sub_back_fg, x=0, bottom=1, width='50%', height=B_HEIGHT, }
	end
	--close button
	window_children[#window_children+1] = Button:New{ caption = 'Close', OnMouseUp = { KillSubWindow }, 
		textColor = color.sub_close_fg, backgroundColor = color.sub_close_bg, width=settings_width, x='50%', right=1, bottom=1, height=B_HEIGHT, }
	
	KillSubWindow()
	curSubKey = key -- must be done after KillSubWindow
	window_sub_cur = Window:New{  
		caption=menu_name,
		x = settings.sub_pos_x,  
		y = settings.sub_pos_y, 
		clientWidth = window_width,
		clientHeight = window_height+30,
		
		minimumSize = {250,350},		
		
		--resizable = false,
		parent = screen0,
		backgroundColor = color.sub_bg,
		children = window_children,
	}
	AdjustWindow(window_sub_cur)
end

-- Show or hide menubar
local function ShowHideCrudeMenu()
	if settings.show_crudemenu then
		if window_crude then
			screen0:AddChild(window_crude)
			window_crude:UpdateClientArea()
		end
		if window_sub_cur then
			screen0:AddChild(window_sub_cur)
		end
	else
		if window_crude then
			settings.pos_x = window_crude.x
			settings.pos_y = window_crude.y
			screen0:RemoveChild(window_crude)
		end
		if window_sub_cur then
			screen0:RemoveChild(window_sub_cur)
		end
	end
	AdjustWindow(window_crude)
	if window_sub_cur then
		AdjustWindow(window_sub_cur)
	end
end

-- Make menubar
local function MakeCrudeMenu()
	if window_crude then
		window_crude:Dispose()
		window_crude = nil
	end
		
	local crude_width = 440
	local crude_height = B_HEIGHT+0
	
	main_menu_index = flattenTree(menu_tree2, 'Settings')
	game_menu_index = flattenTree(game_menu_tree2, 'Game' )
	help_menu_index = flattenTree(help_menu_tree2, 'Help' )
	
	lbl_fps = Label:New{ name='lbl_fps', caption = 'FPS:', textColor = color.sub_header,  }
	lbl_gtime = Label:New{ name='lbl_gtime', caption = 'Time:', textColor = color.sub_header, align="center" }
	
	window_crude = Window:New{  
		caption=title_text,
		x = settings.pos_x ,  
		y = settings.pos_y ,
		dockable = true,
		name = "crude bar",
		clientWidth = crude_width,
		clientHeight = crude_height,
		draggable = true,
		resizable = false,
		OnMouseUp = {ShowCrudeMenuSettings},
		backgroundColor = color.main_bg,
		
		children = {
			StackPanel:New{
				name='stack_main',
				orientation = 'horizontal',
				width = crude_width,
				height = crude_height,
				resizeItems = false,
				padding = {0,0,0,0},
				itemPadding = {2,0,0,0},
				itemMargin = {0,0,0,0},
				children = {
					Button:New{caption = "Game", OnMouseUp = { function() MakeSubWindow(game_menu_index) end, ShowCrudeMenuSettings,}, backgroundColor=color.game_bg, textColor=color.game_fg, height=B_HEIGHT, width=60, },
					Button:New{caption = "Settings", OnMouseUp = { function() MakeSubWindow(main_menu_index) end, ShowCrudeMenuSettings, }, backgroundColor=color.menu_bg, textColor=color.menu_fg, height=B_HEIGHT, width=60, },
					Label:New{ caption = 'Vol', width = 20, textColor = color.main_fg },
					Trackbar:New{
						x=20,
						height='60%',
						width=80,
						trackColor = color.main_fg,
						value = spGetConfigInt("snd_volmaster", 50),
						OnMouseUp = { ShowCrudeMenuSettings, function(self)	Spring.SendCommands{"set snd_volmaster " .. self.value} end	},
					},
					
					StackPanel:New{
						orientation = 'vertical',
						width = 70,
						height = '100%',
						resizeItems = true,
						autoArrangeV=true,
						autoArrangeH=true,
						padding = {0,0,0,0},
						itemPadding = {0,0,0,0},
						children = {
							lbl_gtime,
							lbl_fps,
						},
					},
					Label:New{ name='lbl_clock', caption = 'Clock:', width = 20, textColor = color.main_fg },
					
					Button:New{caption = "?", OnMouseUp = { function() MakeSubWindow(help_menu_index) end, ShowCrudeMenuSettings,}, backgroundColor=color.menu_bg, textColor=color.menu_fg, height=B_HEIGHT, width=35, },
					Button:New{caption = "Quit", OnMouseUp = { function() spSendCommands{"quitmenu"} end, ShowCrudeMenuSettings,}, backgroundColor=color.menu_bg, textColor=color.menu_fg, height=B_HEIGHT, width=60, },
					
				}
			}
		}
	}
	ShowHideCrudeMenu()
end
--[[
local function checkChecks()
	if WG.Layout.hideUnits ~= settings.hideUnits then
		WG.Layout.hideUnits = settings.hideUnits
		Spring.ForceLayoutUpdate()
	end
	MakeCrudeMenu()
end
--]]
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Currently unused
function ShowCrudeMenuSettings(self, x,y,button,mods) 
	if mods.meta then
		MakeSubWindow(cmsettings_index)
	end
end

function widget:ViewResize(vsx, vsy)
	scrW = vsx
	scrH = vsy
end

-- Adding functions because of "handler=true"
local function AddAction(cmd, func, data, types)
	return widgetHandler.actionHandler:AddAction(widget, cmd, func, data, types)
end
local function RemoveAction(cmd, types)
	return widgetHandler.actionHandler:RemoveAction(widget, cmd, types)
end


function widget:Initialize()
	if (not WG.Chili) then
		widgetHandler:RemoveWidget(widget)
		return
	end
	
	-- Clears all saved settings of custom widgets stored in crudemenu's config
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
		echo 'Cleared all widget settings.'
	end

	-- setup Chili
	Chili = WG.Chili
	Button = Chili.Button
	Label = Chili.Label
	Colorbars = Chili.Colorbars
	Checkbox = Chili.Checkbox
	Window = Chili.Window
	ScrollPanel = Chili.ScrollPanel
	StackPanel = Chili.StackPanel
	LayoutPanel = Chili.LayoutPanel
	Grid = Chili.Grid
	Trackbar = Chili.Trackbar
	TextBox = Chili.TextBox
	Image = Chili.Image
	Progressbar = Chili.Progressbar
	Colorbars = Chili.Colorbars
	screen0 = Chili.Screen0

	-- add custom widget settings to crudemenu
	AddAllCustSettings()
	
	menu_tree2 = ShorthandTree2Long(menu_tree, 'Settings')
	game_menu_tree2 = ShorthandTree2Long(game_menu_tree, 'Game')
	help_menu_tree2 = ShorthandTree2Long(help_menu_tree, 'Help Menu')

	widget:ViewResize(Spring.GetViewGeometry())
	
	-- Set default positions of windows on first run
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
	

	-- Add actions for keybinds
	AddAction("crudemenu", ActionMenu, nil, "t")
	AddAction("crudewidgetlist", ActionWidgetList, nil, "t")
	-- replace default key binds
	Spring.SendCommands({
		"unbind esc quitmenu",
		"unbindkeyset f11"
	})
	Spring.SendCommands("bind esc crudemenu")
	Spring.SendCommands("bind f11 crudewidgetlist")

	--checkChecks() -- calls MakeCrudeMenu()
	MakeCrudeMenu()
	
	-- Override widgethandler functions for the purposes of alerting crudemenu 
	-- when widgets are loaded, unloaded or toggled
	widgetHandler.OriginalInsertWidget = widgetHandler.InsertWidget
	widgetHandler.InsertWidget = function(self, widget)
		local ret = self:OriginalInsertWidget(widget)
		
		if type(widget) == 'table' and type(widget.options) == 'table' then
			AddCustSettings(widget)
			KillSubWindow()
			MakeCrudeMenu()
		end
		
		checkWidget(widget)
		return ret
	end
	
	widgetHandler.OriginalRemoveWidget = widgetHandler.RemoveWidget
	widgetHandler.RemoveWidget = function(self, widget)
		local ret = self:OriginalRemoveWidget(widget)
		
		if type(widget) == 'table' and type(widget.options) == 'table' then
			RemCustSettings(widget)
			KillSubWindow()
			MakeCrudeMenu()
		end
		
		checkWidget(widget)
		return ret
	end
	
	widgetHandler.OriginalToggleWidget = widgetHandler.ToggleWidget
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
	

  if window_crude then
    screen0:RemoveChild(window_crude)
  end
  if window_sub_cur then
    screen0:RemoveChild(window_sub_cur)
  end

  RemoveAction("crudemenu")
  RemoveAction("crudewidgetlist")
 
  -- restore key binds
  Spring.SendCommands({
    "bind esc quitmenu",
    "bind f11  luaui selector"
  })
  Spring.SendCommands("unbind esc crudemenu")
  Spring.SendCommands("unbind f11 crudewidgetlist")
end

function widget:GetConfigData()
	if window_crude then	
		settings.pos_x = window_crude.x
		settings.pos_y = window_crude.y
	end
	return settings
end

function widget:SetConfigData(data)
	if (data and type(data) == 'table') then
		if data.versionmin and data.versionmin >= 50 then
			settings = data
			--settings.hideUnits = WG.Layout.hideUnits
		end
	end
end

function widget:Update()
	cycle = cycle%32+1
	if cycle == 1 then
		--Update clock, game timer and fps meter that show on menubar
		if lbl_fps then
			lbl_fps:SetCaption( 'FPS: ' .. Spring.GetFPS() )
		end
		if lbl_gtime then
			lbl_gtime:SetCaption( '[' .. GetTimeString() ..']' )
		end
		local lbl_clock = window_crude.children[1]:GetChildByName('lbl_clock')
		if lbl_clock then
			--local displaySeconds = true
			--local format = displaySeconds and "%H:%M:%S" or "%H:%M"
			local format = "%H:%M"
			lbl_clock:SetCaption( 'Clock\n ' .. os.date(format) )
		end
	end
end


function widget:KeyPress(key, modifier, isRepeat)
	if key == KEYSYMS.LCTRL 
		or key == KEYSYMS.RCTRL 
		or key == KEYSYMS.LALT
		or key == KEYSYMS.RALT
		or key == KEYSYMS.LSHIFT
		or key == KEYSYMS.RSHIFT
		or key == KEYSYMS.LMETA
		or key == KEYSYMS.RMETA
		then
		
		return
	end
	
	local modstring = 
		(modifier.alt and 'a' or '') ..
		(modifier.ctrl and 'c' or '') ..
		(modifier.meta and 'm' or '') ..
		(modifier.shift and 's' or '')
	
	--Set a keybinding 
	if get_key then
		get_key = false
		window_getkey:Dispose()
		
		kbval = { key = key, mod = modstring }		
		
		if key ~= KEYSYMS.ESCAPE then		
			AssignKeyBind(kbval, kb_mkey, kb_mindex, kb_item)
		end
		
		if kb_mkey == curSubKey then
			MakeSubWindow(kb_mkey)
		end
		
		return true
	end
	
	--Perform an action based on a keybinding
	local action = keybinds[key] and keybinds[key][modstring]
	if action then
		action()
	end
end

function ActionMenu()
	settings.show_crudemenu = not settings.show_crudemenu
	ShowHideCrudeMenu()
end

function ActionWidgetList()
	if window_widgetlist then
		KillWidgetList()
	else
		MakeWidgetList()
	end
end
