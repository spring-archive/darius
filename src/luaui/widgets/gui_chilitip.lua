--------------------------------------------------------------------------------
function widget:GetInfo()
  return {
    name      = "Chili Tip",
    desc      = "v0.16 Chili Tooltips.",
    author    = "CarRepairer",
    date      = "2009-06-02",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    experimental = false,
    enabled   = true,
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local spGetCurrentTooltip		= Spring.GetCurrentTooltip
local spGetUnitDefID			= Spring.GetUnitDefID
local spGetFeatureDefID			= Spring.GetFeatureDefID
local spGetUnitAllyTeam			= Spring.GetUnitAllyTeam
local spGetUnitTeam				= Spring.GetUnitTeam
local spGetUnitHealth			= Spring.GetUnitHealth
local spGetUnitResources		= Spring.GetUnitResources
local spTraceScreenRay			= Spring.TraceScreenRay
local spGetTeamInfo				= Spring.GetTeamInfo
local spGetPlayerInfo			= Spring.GetPlayerInfo
local spGetTeamColor			= Spring.GetTeamColor
local spGetUnitTooltip			= Spring.GetUnitTooltip
local spGetModKeyState			= Spring.GetModKeyState
local spGetMouseState			= Spring.GetMouseState
local spSendCommands			= Spring.SendCommands
local spGetSelectedUnitsCount	= Spring.GetSelectedUnitsCount
local spGetUnitIsStunned		= Spring.GetUnitIsStunned

local abs						= math.abs
local strFormat 				= string.format

local echo = Spring.Echo

local VFSMODE      = VFS.RAW_FIRST
local _, iconFormat = VFS.Include(LUAUI_DIRNAME .. "Configs/chilitip_conf.lua" , nil, VFSMODE)
local confdata = VFS.Include(LUAUI_DIRNAME .. "Configs/gui_conf.lua", nil, VFSMODE)
local color = confdata.color

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local Chili
local Button
local Label
local Window
local StackPanel
local Grid
local TextBox
local Image
local Multiprogressbar
local Progressbar
local screen0

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- group info

local selectedUnits = {}
local numSelectedUnits = 0

local gi_count = 0
local gi_cost = 0
local gi_finishedcost = 0
local gi_hp = 0
local gi_maxhp = 0
local gi_metalincome = 0
local gi_metaldrain = 0
local gi_energyincome = 0
local gi_energydrain = 0
local gi_usedbp = 0
local gi_totalbp = 0

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local B_HEIGHT = 30
local icon_size = 20
local stillCursorTime = 0

local scrH, scrW = 0,0
local cycle = 0
local old_ttstr
local old_mx, old_my = -1,-1
local mx, my = -1,-1
local showExtendedTip = false
local multiUnitTooltip = false
local changeNow = false

local window_tooltip, tt_healthbar, tt_unitID, tt_ud
local stack_tooltip, iconstack

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function OptionsChanged() 
	if (window_tooltip) then
		window_tooltip:Dispose()
	end
	Initialize()
end 

options_section = 'Interface'
options = {

	order = { 'tooltip_delay',  'statictip', 'fontsize', 'staticfontsize', 'hplong'},

	tooltip_delay = {
		name = 'Tooltip display delay (0 - 4s)',
		desc = 'Determines how long you can leave the mouse idle until the tooltip is displayed.',
		type = 'number',
		min=0,max=4,step=0.1,
		value = 0,
	},
	
	fontsize = {
		name = 'Font Size (10-20)',
		desc = 'Resizes the font of the tip',
		type = 'number',
		min=12,max=20,step=1,
		value = 10,
	},
	
	staticfontsize = {
		name = 'Static Display Font Size (10-30)',
		desc = 'Resizes the font for the static display of group and terrain information',
		type = 'number',
		min=12,max=30,step=1,
		value = 10,
	},
	
	statictip = {
		name = "Static Tooltip",
		type = 'bool',
		value = false,
		desc = 'Makes the tooltip static and moveable',
		OnChange = OptionsChanged,
	},
	
	hplong = {
		name = "HP Long Notation",
		type = 'bool',
		value = false,
		desc = 'Shows full number for HP.',
	},
	
	
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function tobool(val)
  local t = type(val)
  if (t == 'nil') then return false
  elseif (t == 'boolean') then	return val
  elseif (t == 'number') then	return (val ~= 0)
  elseif (t == 'string') then	return ((val ~= '0') and (val ~= 'false'))
  end
  return false
end

function comma_value(amount)
	local formatted = amount .. ''
	local k
	while true do  
		formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
  	return formatted
end

--from rooms widget by quantum
local function ToSI(num)
  if type(num) ~= 'number' then
	return 'Tooltip wacky error #55'
  end
  if (num == 0) then
    return "0"
  else
    local absNum = abs(num)
    if (absNum < 0.001) then
      return strFormat("%.1fu", 1000000 * num)
    elseif (absNum < 1) then
      return strFormat("%.1f", num)
    elseif (absNum < 1000) then
      return strFormat("%.0f", num)
    elseif (absNum < 1000000) then
      return strFormat("%.1fk", 0.001 * num)
    else
      return strFormat("%.1fM", 0.000001 * num)
    end
  end
end

local function ToSIPrec(num) -- more presise
  if type(num) ~= 'number' then
	return 'Tooltip wacky error #55'
  end
  if (num == 0) then
    return "0"
  else
    local absNum = abs(num)
    if (absNum < 0.001) then
      return strFormat("%.2fu", 1000000 * num)
    elseif (absNum < 1) then
      return strFormat("%.2f", num)
    elseif (absNum < 1000) then
      return strFormat("%.1f", num)
    elseif (absNum < 1000000) then
      return strFormat("%.2fk", 0.001 * num)
    else
      return strFormat("%.2fM", 0.000001 * num)
    end
  end
end

local function numformat(num)
	return comma_value(ToSI(num))
end


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

	--//FIXME If we don't do this the stencil mask of stack_tooltip doesn't get updated, when we move the mouse (affects only if type(stack_tooltip) == StackPanel)
	stack_tooltip:Invalidate()
	iconstack:Invalidate()
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local UnitDefByHumanName_cache = {}
local function GetUnitDefByHumanName(humanName)
	local cached_udef = UnitDefByHumanName_cache[humanName]
	if (cached_udef ~= nil) then
		return cached_udef
	end

	for _,ud in pairs(UnitDefs) do
		if ud.humanName == humanName then
			UnitDefByHumanName_cache[humanName] = ud
			return ud
		end
	end
	UnitDefByHumanName_cache[humanName] = false
	return false
end

local function tooltipBreakdown()
	--//* return arguments:
	--//* tooltip, unitDef, buildType, morph_time, morph_cost

	local tooltip = spGetCurrentTooltip()
	local unitname = nil

--[[
	local startsWithBuild = tooltip:find('Build', 1, true) == 1
	if startsWithBuild then
		local cmddescs = Spring.GetActiveCmdDescs()

		for i=1,#cmddescs do
			local desc = cmddescs[i]
			if desc.tooltip == tooltip then
				unitname = desc.name
				break
			end
		end
	end
--]]
	if tooltip:find('Build', 1, true) == 1 then
		local start,fin = tooltip:find([[ - ]], 1, true)
		if start and fin then
			local tooltip_ = tooltip:sub(fin+1)
			
			local unitHumanName
			local buildType
			if (tooltip:find('Build Unit:', 1, true) == 1) then
				buildType = 'buildunit'
				unitHumanName = tooltip:sub(13,start-1)
			else
				buildType = 'build'
				unitHumanName = tooltip:sub(8,start-1)
			end
			local udef = GetUnitDefByHumanName(unitHumanName)
			
			if (udef) then
				return tooltip_, udef, buildType
			end
		end
		
	elseif tooltip:find('Morph', 1, true) == 1 then
		
		local unitHumanName = tooltip:gsub('Morph into a (.*)(time).*', '%1'):gsub('[^%a \-]', '')
		local udef = GetUnitDefByHumanName(unitHumanName)
		
		local needunit
		if tooltip:find('needs unit', 1, true) then
  			needunit = tooltip:gsub('.*needs unit: (.*)', '%1'):gsub('[^%a \-]', '')
		end
		
		return '',
			udef,
			'morph',
			tooltip:gsub('.*time:(.*)metal.*', '%1'):gsub('[^%d]', ''),
			tooltip:gsub('.*metal: (.*)energy.*', '%1'):gsub('[^%d]', ''),
			needunit
			
	end
	
	return tooltip
end

----------------------------------------------------------------

local function SetHealthbar()
	if not tt_ud or not tt_unitID then return 'err' end
		
	local health, maxhealth = spGetUnitHealth(tt_unitID)
	if health then
		tt_healthbar.color = {0,1,0, 1}
		
		tt_health_fraction = health/maxhealth
		tt_healthbar:SetValue(tt_health_fraction)
		if options.hplong.value then
			tt_healthbar:SetCaption(comma_value(health) .. ' / ' .. comma_value(maxhealth))
		else
			tt_healthbar:SetCaption(numformat(health) .. ' / ' .. numformat(maxhealth))
		end
		
	else
		tt_healthbar.color = {0,0,0.5, 1}
		local maxhealth = tt_ud.health
		tt_healthbar:SetValue(1)
		if options.hplong.value then
			tt_healthbar:SetCaption('??? / ' .. comma_value(maxhealth))
		else
			tt_healthbar:SetCaption('??? / ' .. numformat(maxhealth))
		end
	end
end


local function KillTooltip()
	if options.statictip.value then
		window_tooltip:ClearChildren()
	else
		screen0:RemoveChild(window_tooltip)
		old_ttstr = ''
		tt_unitID = nil
	end
	
end

local function GetResourceStack(unitID, ud, tooltip, fontSize)
	local metalMake, metalUse, energyMake,energyUse = Spring.GetUnitResources(unitID)
	
	local absMetal, absEnergy = 0,0
	if metalMake then
		absMetal = metalMake - metalUse
		absEnergy = energyMake - energyUse
	end
	
	-- special cases for mexes
	if ud.name == 'armmex' or ud.name=='cormex' then 
		local baseMetal = 0
		local s = tooltip:match("Makes: ([^ ]+)")
		if s ~= nil then baseMetal = tonumber(s) end 
						
		s = tooltip:match("Overdrive: %+([0-9]+)")
		local od = 0
		if s ~= nil then od = tonumber(s) end
		
		absMetal = absMetal + baseMetal + baseMetal * od / 100
		
		s = tooltip:match("Energy: ([^ ]+)")
		if s ~= nil then absEnergy = absEnergy +tonumber(s) end 
	end 
	
	local lbl_metal = Label:New{ text = '', autosize=true, fontSize=fontSize, valign='center' }
	if abs(absMetal) <= 0.1 then
		lbl_metal.font:SetColor(0.5,0.5,0.5,1)
		lbl_metal:SetCaption("0.0")
	else
		if (absMetal<0) then
			lbl_metal.font:SetColor(1,0,0,1)
		else
			lbl_metal.font:SetColor(0,1,0,1)
		end
		lbl_metal:SetCaption( ("%0.1f"):format(absMetal) )
	end
	
	local lbl_energy = Label:New{ text = '', autosize=true, fontSize=fontSize, valign='center'  }
	if abs(absEnergy) <= 0.1 then
		lbl_energy.font:SetColor(0.5,0.5,0.5,1)
		lbl_energy:SetCaption("0.0")
	else
		if (absEnergy<0) then
			lbl_energy.font:SetColor(1,0,0,1)
		else
			lbl_energy.font:SetColor(0,1,0,1)
		end
		lbl_energy:SetCaption( ("%0.1f"):format(absEnergy) )
	end
	
	return StackPanel:New{
		centerItems = false,
		autoArrangeV = true,
		orientation='horizontal',
		resizeItems=false,
		width = '100%',
		height = icon_size+1,
		padding = {0,0,0,0},
		itemPadding = {0,0,0,0},
		itemMargin = {5,0,0,0},
		children = {
		},
	}

		
end


local function MakeTooltipWindows(x,y)
	window_tooltip:ClearChildren()
	
	if iconstack then
		window_tooltip:AddChild(iconstack)
	end
	if stack_tooltip then
		window_tooltip:AddChild(stack_tooltip)
	end

	if not window_tooltip:IsDescendantOf(screen0) then
		screen0:AddChild(window_tooltip)
	end
	if not options.statictip.value then
		window_tooltip:SetPos(x,y)
		AdjustWindow(window_tooltip)
	end

	window_tooltip:BringToFront()
end

	
local function MakeToolTip(x,y, tooltip_type, unitID, ud, tooltip, morph_time, morph_cost, morph_prereq)
	local x = x
	local y = scrH-y
	local ttstr = ''
	local fd
	local difftarget = false
	
	local newFontSize = options.fontsize.value
	
	if tooltip_type == 'unit' then
		ttstr = old_ttstr
		
		if unitID ~= tt_unitID or changeNow then
			tt_unitID 	= unitID
			
			local udid = spGetUnitDefID(unitID)
			ud = UnitDefs[udid]
			if not ud then return end
			tt_ud = ud
			
			local alliance       = spGetUnitAllyTeam(unitID)
			local team           = spGetUnitTeam(unitID)
			local _, player      = spGetTeamInfo(team)
			local playerName     = spGetPlayerInfo(player) or 'noname'
			ttstr = ud.humanName
			difftarget = true
		end
	elseif tooltip_type == 'feature' then
		
		if unitID ~= tt_unitID or changeNow then
			tt_unitID 	= unitID
			local fdid = spGetFeatureDefID(unitID)
			ud = fdid and FeatureDefs[fdid]
			local feature_name = ud and ud.name
			if feature_name then
				-- generic feature
				local rem_metal = ud.metal
				if unitID then
					 rem_metal = numformat(Spring.GetFeatureResources(unitID) or rem_metal)
				end

				ttstr = (ud.tooltip or feature_name) .. ' - ' .. rem_metal .. ' Metal'
				
				local desc = ''
				if feature_name:find('dead2') then
					desc = ' (debris)'
				elseif feature_name:find('dead') then
					desc = ' (wreckage)'
				end
				local live_name = feature_name:gsub('([^_]*).*', '%1')
				fd = ud
				ud = UnitDefNames[live_name]
				tt_ud = ud
				if ud then
					-- dead unit feature
					ttstr = ud.humanName .. desc
				end
			else
				ud = nil
			end
			difftarget = true
		end
	else
		tt_unitID = nil
		if tooltip_type == 'morph' then
			ttstr = 'Morph to: ' .. ud.humanName
		elseif tooltip_type == 'build' or tooltip_type == 'buildunit' then
			ttstr = 'Build: ' .. ud.humanName
		elseif multiUnitTooltip then
			ttstr = 
				"Selected Units " .. gi_count .. "\n" ..
				"Health " .. gi_hp .. " / " ..  gi_maxhp  .. "\n" ..
				"Cost " .. gi_cost .. " / " ..  gi_finishedcost .. "\n" ..
				"Metal \255\0\255\0+" .. gi_metalincome .. "\255\255\255\255 / \255\255\0\0-" ..  gi_metaldrain  .. "\255\255\255\255\n" ..
				"Energy \255\0\255\0+" .. gi_energyincome .. "\255\255\255\255 / \255\255\0\0-" .. gi_energydrain .. "\255\255\255\255\n" ..
				"Build Power " .. gi_usedbp .. " / " ..  gi_totalbp 
			if options.statictip.value then
				newFontSize = options.staticfontsize.value
			end
		else
			ttstr = tooltip
			if options.statictip.value then
				newFontSize = options.staticfontsize.value
			end
		end
		if ttstr ~= old_ttstr then
			difftarget = true
		end
	end
	
	tt_ud = ud
	
	if not (difftarget or changeNow) then	
		if not options.statictip.value then
			window_tooltip:SetPos(x,y)
			AdjustWindow(window_tooltip)
		end
		return
	end
	old_ttstr = ttstr
	
	if not ud then
		iconstack=StackPanel:New{}
		stack_tooltip = Label:New{ 
			caption = ttstr, 
			width='100%', 
			valign="ascender", 
			font={ size=newFontSize+2, color=color.tooltip_fg, }, 
			fontShadow=true,
		}
		MakeTooltipWindows(x,y)
		return
	end

	local tt_children
	local tt_label = Label:New{ caption = ttstr, textColor=color.tooltip_fg, valign='center', 
		width = 250, --needed for long unit names like "commander with dgun"
		 fontSize=newFontSize+2,
		 fontShadow=true,
		}
	if ud.iconType ~= 'default' then
		tt_children = {
			StackPanel:New{
				centerItems = false,
				autoArrangeV = true,
				orientation='horizontal',
				resizeItems=false,
				width = tt_label.width + icon_size +5,
				height = icon_size+1,
				padding = {0,0,0,0},
				itemPadding = {0,0,0,0},
				itemMargin = {0,0,0,0},
				children = {
					Image:New{
						file='icons/'.. ud.iconType ..iconFormat,
						height= icon_size,
						width= icon_size,
					},
					tt_label,
				},
			}
		}
	else
		tt_children = {tt_label}
	end	
	
	local tooltip = unitID and spGetUnitTooltip(unitID) or ud.tooltip
	tt_children[#tt_children + 1] = TextBox:New{ text = tooltip or 'desc error', valign='center', textColor=color.tooltip_fg, 
		width='100%', 
		autosize=false,
		fontSize=newFontSize,
		}
	
	local mcost = numformat(ud.metalCost)
	if tooltip_type == 'feature' then
		local rem_metal = fd.metal
		if unitID then
			 rem_metal = Spring.GetFeatureResources(unitID) or rem_metal
		end
		mcost = numformat(rem_metal) ..' / '.. numformat(ud.metalCost)
	end
	
	--tt_children[#tt_children + 1] = Image:New{file='LuaUI/images/ibeam.png',height= icon_size,width= icon_size,}
	--tt_children[#tt_children + 1] = Label:New{ caption = mcost, valign='center', textColor=color.tooltip_info, width='80%', autoSize=false , fontSize=options.fontsize.value,}
	
	if tooltip_type == 'morph' then
		tt_children[#tt_children + 1] = Label:New{ caption = 'Morph: ', height= icon_size, valign='center', textColor=color.tooltip_info, autoSize=false, width=45, fontSize=newFontSize,}
		tt_children[#tt_children + 1] = Image:New{file='LuaUI/images/clock.png',height= icon_size,width= icon_size, fontSize=newFontSize,}
		tt_children[#tt_children + 1] = Label:New{ caption = morph_time, valign='center', textColor=color.tooltip_info, autoSize=false, width=25}
		tt_children[#tt_children + 1] = Image:New{file='LuaUI/images/ibeam.png',height= icon_size,width= icon_size, fontSize=newFontSize,}
		tt_children[#tt_children + 1] = Label:New{ caption = morph_cost, valign='center', textColor=color.tooltip_info, autoSize=false, width=25, fontSize=newFontSize,}
		
		if morph_prereq then
			tt_children[#tt_children + 1] = Label:New{ caption = 'Need Unit: '..morph_prereq, valign='center', textColor=color.tooltip_info, autoSize=false, width=180, fontSize=newFontSize,}
		end
		
	end
	
	if tooltip_type == 'unit' then
		tt_children[#tt_children + 1] = tt_healthbar
	end
	
	--resources
	if unitID then
		local resStack = GetResourceStack(unitID, ud, tooltip, newFontSize)
		if resStack then
			tt_children[#tt_children+1] = resStack
		end
	end
	
	--[[
	local showingExtendedTip = false
	local _,_,_,buildUnitName = Spring.GetActiveCommand()
	local sc_label 
	if not buildUnitName then
		local sc_caption = ''
		if tooltip_type == 'build' then
			sc_caption = 'Space+click: Show unit stats'
		elseif tooltip_type == 'buildunit' then
				if showExtendedTip then
					showingExtendedTip = true
					sc_caption = 
						'Shift+click: Add 5 to queue.\n'..
						'Ctrl+click: Add 20 to queue.\n'..
						'Alt+click: Add one unit to front of queue. \n'..
						'Rightclick: remove 1 unit from queue.\n'..
						'Space+click: Show unit stats'
				else
					sc_caption = '(Hold Spacebar for help)'
				end
		
		elseif tooltip_type == 'morph' then
			sc_caption = 'Space+click: Show unit stats'
		else
			sc_caption = 'Space+click: Show options'
		end
		sc_label = TextBox:New{ text = sc_caption, textColor=color.tooltip_help, width=250, fontSize=newFontSize,  }
		tt_children[#tt_children+1] = sc_label
	end
	]]--
	
	iconstack = StackPanel:New{
		orientation='horizontal',
		padding = {0,0,0,0},
		itemPadding = {1,0,0,0},
		itemMargin = {0,0,0,0},
		resizeItems=false,
		autosize=true,
		width   = 60,

		children = {
			Image:New{
				file2 = (WG.GetBuildIconFrame)and(WG.GetBuildIconFrame(ud)),
				file = "#" .. ud.id,
				keepAspect = false;
				height  = 55*(4/5);
				width   = 55;
			},
		},
	}
	if (ud.customParams.greenballs) then
		table.insert(iconstack.children, Image:New{file='bitmaps/greenball.png',height= icon_size,width= icon_size,})
		table.insert(iconstack.children, Label:New{ caption = ud.customParams.greenballs, valign='center', textColor=color.tooltip_info, width=35, autoSize=false , fontSize=newFontSize,})
	end

	stack_tooltip = StackPanel:New{
		autosize=true,
		x=60,y=0,
		orientation='horizontal',
		centerItems = false,
		width = 200,
		padding = {0,0,0,0},
		itemPadding = {1,0,0,0},
		itemMargin = {0,0,0,0},
		resizeItems=false,
		children = tt_children,
	}

	MakeTooltipWindows(x,y)
	
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- group selection
	
local function UpdateDynamicGroupInfo()

	gi_cost = 0
	gi_hp = 0
	gi_metalincome = 0
	gi_metaldrain = 0
	gi_energyincome = 0
	gi_energydrain = 0
	gi_usedbp = 0
	
	for i = 1, numSelectedUnits do
		local id = selectedUnits[i]
	
		local ud = UnitDefs[spGetUnitDefID(id) or 0]
		local name = ud.name 
		local hp, _, paradam, cap, build = spGetUnitHealth(id)
		local mm,mu,em,eu = spGetUnitResources(id)
	
		if name ~= "terraunit" then
			gi_cost = gi_cost + ud.metalCost*build
			gi_hp = gi_hp + hp
			
			local stunned_or_inbuld = spGetUnitIsStunned(id)
			if not stunned_or_inbuld then 
				if name == 'armmex' or name =='cormex' then -- mex case
					local tooltip = spGetUnitTooltip(id)
					
					local baseMetal = 0
					local s = tooltip:match("Makes: ([^ ]+)")
					if s ~= nil then 
						baseMetal = tonumber(s) 
					end 
									
					s = tooltip:match("Overdrive: %+([0-9]+)")
					local od = 0
					if s ~= nil then 
						od = tonumber(s) 
					end
					
					gi_metalincome = gi_metalincome + baseMetal + baseMetal * od / 100
						
					s = tooltip:match("Energy: ([^ ]+)")
					if s ~= nil then 
						gi_energydrain = gi_energydrain - tonumber(s) 
					end 
				else
					gi_metalincome = gi_metalincome + mm
					gi_metaldrain = gi_metaldrain + mu
					gi_energyincome = gi_energyincome + em
					gi_energydrain = gi_energydrain + eu
				end
				
				if ud.buildSpeed ~= 0 then
					gi_usedbp = gi_usedbp + mu
				end
			end
		end
		
	end
	
	gi_cost = ToSIPrec(gi_cost)
	gi_hp = ToSIPrec(gi_hp)
	gi_metalincome = ToSIPrec(gi_metalincome)
	gi_metaldrain = ToSIPrec(gi_metaldrain)
	gi_energyincome = ToSIPrec(gi_energyincome)
	gi_energydrain = ToSIPrec(gi_energydrain)
	gi_usedbp = ToSIPrec(gi_usedbp)
	
end

local function UpdateStaticGroupInfo()

	gi_count = numSelectedUnits
	gi_finishedcost = 0
	gi_totalbp = 0
	gi_maxhp = 0
	
	for i = 1, numSelectedUnits do
		local ud = UnitDefs[spGetUnitDefID(selectedUnits[i]) or 0]
		local name = ud.name 
		if name ~= "terraunit" then
			gi_totalbp = gi_totalbp + ud.buildSpeed
			gi_maxhp = gi_maxhp + ud.health
			gi_finishedcost = gi_finishedcost + ud.metalCost
		end
	end
	
	gi_finishedcost = ToSIPrec(gi_finishedcost)
	gi_totalbp = ToSIPrec(gi_totalbp)
	gi_maxhp = ToSIPrec(gi_maxhp)
end


function widget:SelectionChanged(newSelection)
	numSelectedUnits = spGetSelectedUnitsCount()
	selectedUnits = newSelection
	UpdateStaticGroupInfo()
	UpdateDynamicGroupInfo()
end

function widget:GameFrame(n)
	if n%32 == 1 then 
		UpdateDynamicGroupInfo()
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:Update(dt)
	cycle = cycle%100 + 1
	old_mx, old_my = mx,my
	alt,_,meta,_ = spGetModKeyState()
	mx,my = spGetMouseState()
	
	local show_cursortip = true
	if not options.statictip.value then
		if meta then
			if not showExtendedTip then changeNow = true end
			showExtendedTip = true
		
		elseif options.tooltip_delay.value > 0 then
			if mx == old_mx and my == old_my then
				stillCursorTime = stillCursorTime + dt
			else
				stillCursorTime = 0 
			end
			if showExtendedTip then changeNow = true end
			showExtendedTip = false
			show_cursortip = stillCursorTime > options.tooltip_delay.value
		
		else
			if showExtendedTip then changeNow = true end
			showExtendedTip = false
		end
	else
		showExtendedTip = true
	end
	
	multiUnitTooltip = false

	if mx ~= old_mx or my ~= old_my or changeNow then
		if not show_cursortip then
			KillTooltip()
			return
		end

		if screen0.currentTooltip ~= nil then
			local tt = screen0.currentTooltip
			if tt ~= '' and tt:gsub(' ',''):len() > 0 then
				MakeToolTip(mx+20,my-20, false,false,false,  tt)
			else
				KillTooltip() 
			end
			return
		end

		local tooltip, unitDef, buildType, morph_time, morph_cost, morph_prereq  = tooltipBreakdown()
		
		if (not tooltip) then
			KillTooltip()
		elseif unitDef then
			MakeToolTip(mx+20,my-20, buildType, false, unitDef, nil, morph_time, morph_cost, morph_prereq)
		else
			local type, data = spTraceScreenRay(mx, my)
			
			if type == 'unit' or type == 'feature' then
				local unitID = data
				MakeToolTip(mx+20,my-20, type, unitID, false)
				
			elseif (tooltip == '') or tooltip:gsub(' ',''):len() <= 0 then
				if numSelectedUnits ~= 0 and (options.statictip.value or showExtendedTip) then 
					multiUnitTooltip = true
					MakeToolTip(mx+20,my-20, false, false, false, tooltip) 
				else
					KillTooltip()
				end
				
			elseif tooltip:find('Experience %d+.%d+ Cost ') then
				if showExtendedTip or options.statictip.value then
					if numSelectedUnits ~= 0 then
						multiUnitTooltip = true
					end
					MakeToolTip(mx+20,my-20, false,false,false, tooltip)
				else
					KillTooltip()
				end
			 
			-- default tooltip
			elseif showExtendedTip
				or options.statictip.value
				or (
					tooltip:sub(1,4) ~= 'Pos ' 
					and not tooltip:find('Experience %d+.%d+ Cost ')
					)  
				then
				MakeToolTip(mx+20,my-20, false,false,false, tooltip)
			else
				KillTooltip() 
			end
		end
		changeNow = false
	end
	
	SetHealthbar()
	
	if cycle == 1 then
		changeNow = true
	end
	
	
end


function widget:ViewResize(vsx, vsy)
	scrW = vsx
	scrH = vsy
end

function widget:Initialize()

	if (not WG.Chili) then
		widgetHandler:RemoveWidget(widget)
		return
	end

	
	-- setup Chili
	 Chili = WG.Chili
	 Button = Chili.Button
	 Label = Chili.Label
	 Window = Chili.Window
	 StackPanel = Chili.StackPanel
	 Grid = Chili.Grid
	 TextBox = Chili.TextBox
	 Image = Chili.Image
	 Multiprogressbar = Chili.Multiprogressbar
	 Progressbar = Chili.Progressbar
	 screen0 = Chili.Screen0

	widget:ViewResize(Spring.GetViewGeometry())

	tt_healthbar = 
		Progressbar:New {
			width = '100%',
			height = icon_size+2,
			itemMargin    = {0,0,0,0},
			itemPadding   = {0,0,0,0},	
			padding = {0,0,0,0},
			color = {0,1,0,1},
			max=1,
			caption = 'a',

			children = {
			},
		}

	stack_tooltip = StackPanel:New{
		width=250, -- needed for initial tooltip
	} 
	if options.statictip.value then
	
		window_tooltip = Window:New{  
			--skinName = 'default',
			name   = 'tooltip';
			x      = 0;
			y = Chili.Screen.y - 130;
			clientHeight = 130;
			clientWidth  = 230;
			--useDList = false,
			dockable = true,
			resizable = false,
			draggable = true,
			dragUseGrip = true;
			backgroundColor = color.tooltip_bg, 
			children = { stack_tooltip, }
		}
	
	else
		window_tooltip = Window:New{  
			--skinName = 'default',
			useDList = false,
			resizable = false,
			draggable = false,
			autosize  = true,
			backgroundColor = color.tooltip_bg, 
			children = { stack_tooltip, }
		}
	end

	spSendCommands({"tooltip 0"})

end

function widget:Shutdown()
	spSendCommands({"tooltip 1"})
	if (window_tooltip) then
		window_tooltip:Dispose()
	end
end


