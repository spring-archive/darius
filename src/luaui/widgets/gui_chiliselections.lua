function widget:GetInfo()
  return {
    name      = "Chili Selections",
    desc      = "v0.13 Chili Selections.",
    author    = "jK & CarRepairer",
    date      = "@2009,2010",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    experimental = false,
    enabled   = true,
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local spSendLuaRulesMsg			= Spring.SendLuaRulesMsg
local spGetCurrentTooltip		= Spring.GetCurrentTooltip

local spGetSelectedUnits                = Spring.GetSelectedUnits
local spGetSelectedUnitsCounts          = Spring.GetSelectedUnitsCounts
local spGetSelectedUnitsCount           = Spring.GetSelectedUnitsCount
local spGetSelectedUnitsByDef           = Spring.GetSelectedUnitsSorted

local spGetUnitDefID			= Spring.GetUnitDefID
local spGetFeatureDefID			= Spring.GetFeatureDefID
local spGetUnitAllyTeam			= Spring.GetUnitAllyTeam
local spGetUnitTeam			= Spring.GetUnitTeam
local spGetUnitHealth			= Spring.GetUnitHealth
local spTraceScreenRay			= Spring.TraceScreenRay
local spGetTeamInfo			= Spring.GetTeamInfo
local spGetPlayerInfo			= Spring.GetPlayerInfo
local spGetTeamColor			= Spring.GetTeamColor
local spGetUnitTooltip			= Spring.GetUnitTooltip
local spGetUnitIsStunned		= Spring.GetUnitIsStunned

local spGetModKeyState			= Spring.GetModKeyState
local spGetMouseState			= Spring.GetMouseState

local spSendCommands			= Spring.SendCommands

local abs				= math.abs

local windMin = 0
local windMax = 2.5

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

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
local screen0

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local window_corner

local cur_tooltip
local old_mx, old_my

local numSelectedUnits = 0
local selectedUnitsByDefCounts = {}
local selectedUnitsByDef = {}
local selectedUnits = {}
local selectionSortOrder = {}


options_section = 'Interface'

local function option_groupAlwaysUpdate()
  -- unselect to prevent errors
  Spring.SelectUnitMap({}, false)
end

options = {
  groupalways = {name='always group units', type='bool', value=false, OnChange = option_groupAlwaysUpdate},
}


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function round(num, idp)
  if (not idp) then
    return math.floor(num+.5)
  else
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
  end
end

local function numformat(x,idp)
  if (x>0 and x<10) then
    return ("%."..(idp or 3).."f"):format(x)
  else
    return round(x)
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

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

local function Show(obj)
	if (not obj:IsDescendantOf(screen0)) then
		screen0:AddChild(obj)
	end
end

local function Hide(obj)
	obj:ClearChildren()
	screen0:RemoveChild(obj)
end

----------------------------------------------------------------
----------------------------------------------------------------


local function MakeUnitToolTip(unitid)
	local ud             = UnitDefs[spGetUnitDefID(unitid) or 0]
	local team           = spGetUnitTeam(unitid)
	local _, player      = spGetTeamInfo(team)
	local playerName     = spGetPlayerInfo(player) or 'noname'
	local teamColor      = Chili.color2incolor(spGetTeamColor(team))

	window_corner:ClearChildren();

	Image:New{
		parent  = window_corner;
		file2   = (WG.GetBuildIconFrame)and(WG.GetBuildIconFrame(ud));
		file    = "#" .. ud.id;
		keepAspect = false;
		x       = 240;
		height  = 55*(4/5);
		width   = 55;
	}

	Image:New{
		parent  = window_corner;
		file    = 'icons/'.. ud.iconType .. '.dds', --iconFormat,
		x       = 0;--57;
		y       = 0;
		height  = 20;
		width   = 20;
	}
	Label:New{
		parent  = window_corner;
		x       = 22;--79;
		height  = 20;
		caption = ud.humanName;-- .. teamColor .. ' (' .. playerName .. ')';
		valign  = 'center';
		fontSize = 14;
		fontShadow = true;
	}

	Label:New{
		parent  = window_corner;
		name 	= 'tooltip';
		x       = 10;--67;
		y       = 20;
		height  = 40;
		width = 235;
		--height = 30;
		autoSize = false;
		caption = (ud.chili_selections_useStaticTooltip)and(ud.tooltip) or spGetUnitTooltip(unitid);
		valign  = 'top';
	}

	Grid:New{
		name     = 'info';
		parent   = window_corner;
		x        = 222;
		y        = 56;
		height   = 55;
		width    = 71;
		columns  = 2;
		autosize = true;
		resizeItems = false;
		centerItems = true;
		padding     = {0,0,0,0};
		itemPadding = {0,1,0,2};
		itemMargin  = {0,0,0,0};
		--debug=true;
children = {
	Label:New{
		name    = 'metal';
		autosize= false;
		height  = 15;
		width   = 42;
		caption = '\255\000\254\000+0';
		align   = 'right';
		margin  = {0,0,5,0};
	},
	Image:New{
		file    = 'LuaUI/images/ibeam.png';
		height  = 15;
		width   = 15;
	},

	Label:New{
		name    = 'energy';
		autosize= false;
		height  = 15;
		width   = 42;
		caption = '\255\254\000\000+0';
		align   = 'right';
		margin  = {0,0,5,0};
	},
	Image:New{
		file    = 'LuaUI/images/energy.png';
		height  = 15;
		width   = 15;
	}

}
	}


	local barGrid = Grid:New{
		name     = 'Bars';
		autosize = true;
		resizeItems = false;
		centerItems = true;
		parent  = window_corner;
		columns = 2;
		x       = 0;--60;
		y       = 55;
		height  = 50;
		width   = 225;
		padding     = {5,5,5,5};
		itemPadding = {0,0,0,0};
		itemMargin  = {0,0,0,0};
--[[
		DrawBackground = function(self)
			gl.BeginEnd(GL.QUADS,function()
				gl.Color(0,0,0,0.1)
				gl.Vertex(self.x,self.y)
				gl.Vertex(self.x+self.width,self.y)
				gl.Color(0,0,0,0.5)
				gl.Vertex(self.x+self.width,self.y+self.height)
				gl.Vertex(self.x,self.y+self.height)
			end)
		end,
--]]
	}

	Image:New{
		parent  = barGrid;
		file    = 'LuaUI/images/health.png';
		height  = 15;
		width   = 15;
	}
	Progressbar:New{
		name    = 'health';
		parent  = barGrid;
		width   = 200;
		max     = 1;
		caption = "100%";
		color   = {0,0.8,0,1};
	}

	if (ud.name:find("win", 1, true)) then
		Image:New{
			parent  = barGrid;
			file    = 'LuaUI/Images/resbar/wind.png';
			height  = 15;
			width   = 15;
		}
		Progressbar:New{
			name    = 'wind';
			parent  = barGrid;
			width   = 200;
			max     = 1;
			caption = "100%";
			color   = {0.3,0.6,0.8,1};
		}
	end


	if (ud.builder) then
		Image:New{
			parent  = barGrid;
			file    = 'LuaUI/Images/resbar/work.png';
			height  = 15;
			width   = 15;
		}
		Progressbar:New{
			name    = 'nano';
			parent  = barGrid;
			width   = 200;
			max     = 1;
			caption = "100%";
			color   = {0.8,0.8,0.2,1};
		}
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function AddSelectionIcon(barGrid,unitid,defid,unitids,counts)
	local ud = UnitDefs[defid]
	local item = LayoutPanel:New{
		name    = unitid or defid;
		parent  = barGrid;
		width   = 50;
		height  = 62;
		columns = 1;
		padding     = {0,0,0,0};
		itemPadding = {0,0,0,0};
		itemMargin  = {0,0,0,1};
		resizeItems = false;
		centerItems = false;
		autosize    = true;
		tooltip = ud.humanName .. " - " .. ud.tooltip.. "\nClick: Select \nRightclick: Deselect \nAlt+Click: Select One \nCtrl+click: Select Type \nMiddle-click: Goto"; -- FIXME display properly in chilitip
	}
	local img = Image:New{
		parent  = item;
		file2   = (WG.GetBuildIconFrame)and(WG.GetBuildIconFrame(UnitDefs[defid]));
		file    = "#" .. defid;
		keepAspect = false;
		height  = 50; --*(4/5);
		width   = 50;
		padding = {0,0,0,0}; --FIXME something overrides the default in image.lua!!!!
		OnClick = {function(_,_,_,button)
			
			local alt, ctrl, meta, shift = spGetModKeyState()
			
			if (button==3) then
				if (unitid and not ctrl) then
					--// deselect a single unit
					for i=1,numSelectedUnits do
						if (selectedUnits[i]==unitid) then
							table.remove(selectedUnits,i)
							break
						end
					end
					Spring.SelectUnitArray(selectedUnits)
				else
					--// deselect a whole unitdef block
					for i=numSelectedUnits,1,-1 do
						if (Spring.GetUnitDefID(selectedUnits[i])==defid) then
							table.remove(selectedUnits,i)
							if (alt) then
								break
							end
						end
					end

					Spring.SelectUnitArray(selectedUnits)
			
				end
			elseif button == 1 then
				if not ctrl then 
					if (alt) then
						Spring.SelectUnitArray({ selectedUnitsByDef[defid][1] })  -- only 1	
					else
						Spring.SelectUnitArray(unitids) -- no modifier - select all
					end
				else
					-- select all units of the icon type
					Spring.SelectUnitArray(selectedUnitsByDef[defid])
					
					--local sorted = Spring.GetTeamUnitsSorted(Spring.GetMyTeamID())						
					--local units = sorted[defid]
					--if units then Spring.SelectUnitArray(units) end
				end
			else --button2 (middle)
				local x,y,z = Spring.GetUnitPosition( unitids[1] )
				Spring.SetCameraTarget(x,y,z, 1)
			end
		end}
	};
	if ((counts or 1)>1) then
		Label:New{
			parent = img;
			align  = "right";
			valign = "top";
			x =  8;
			y = 30;
			width = 40;
			fontsize   = 20;
			fontshadow = true;
			fontOutline = true;
			caption    = counts;
		};
	end
	Progressbar:New{
		parent  = item;
		name    = 'health';
		width   = 50;
		height  = 5;
		max     = 1;
		color   = {0.0,0.99,0.0,1};
	};
end


local function MakeUnitGroupSelectionToolTip()
	window_corner:ClearChildren();

	local barGrid = LayoutPanel:New{
		name     = 'Bars';
		resizeItems = false;
		centerItems = false;
		parent  = window_corner;
		height  = "100%";
		width   = "100%";
		itemPadding = {0,0,0,0};
		itemMargin  = {0,0,2,2};
		tooltip = "Left Click: Just select clicked unit(s)\nRight Click: Deselect unit(s)";
	}

	if ((numSelectedUnits<8) and (not options.groupalways.value)) then
		for i=1,numSelectedUnits do
			local unitid = selectedUnits[i]
			local defid  = spGetUnitDefID(unitid)
			local unitids = {unitid}

			AddSelectionIcon(barGrid,unitid,defid,unitids)
		end
	else
		for i=1,#selectionSortOrder do
			local defid   = selectionSortOrder[i]
			local unitids = selectedUnitsByDef[defid]
			local counts  = selectedUnitsByDefCounts[defid]

			AddSelectionIcon(barGrid,nil,defid,unitids,counts)
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function UpdateSelectedUnitsTooltip()
	if (numSelectedUnits>0) then
		if (numSelectedUnits == 1) then
			local infoContainer = window_corner.childrenByName['info']

			local barsContainer = window_corner.childrenByName['Bars']
			local healthbar = barsContainer.childrenByName['health']
			local health, maxhealth,para,_,buildProgress = spGetUnitHealth(selectedUnits[1])
			if health then
				healthbar:SetValue(health/maxhealth)
				healthbar:SetCaption(numformat(health) .. ' / ' .. numformat(maxhealth))
			else
				--healthbar:SetValue(1)
				--healthbar:SetCaption('??? / ' .. numformat(ud.health))
			end

			local ud = UnitDefs[spGetUnitDefID(selectedUnits[1]) or 0]
			
			local stunned_or_inbuld = spGetUnitIsStunned(selectedUnits[1])
			
			if not stunned_or_inbuld then
				local metalMake, metalUse, energyMake,energyUse = Spring.GetUnitResources(selectedUnits[1])
				local absMetal = metalMake - metalUse
				local absEnergy = energyMake - energyUse
				
				--// Nano/Builders
				local nanobar = barsContainer.childrenByName['nano']
				if (nanobar) then
					if metalUse then
						nanobar:SetValue(metalUse/ud.buildSpeed,true)
						nanobar:SetCaption(round(100*metalUse/ud.buildSpeed)..'%')
					else
						healthbar:SetValue(1)
						healthbar:SetCaption('??? / ' .. numformat(ud.buildSpeed))
					end
				end

				--// Windgens
				local windbar = barsContainer.childrenByName['wind']
				if (windbar) then
					local power = (absEnergy - windMin) / (windMax - windMin)
					windbar:SetValue(power, true)
					windbar:SetCaption( ("%0.f%%"):format(100*power) )
				end

				--// Overdrive Pylons
				if (ud.name == 'mexpylon' or ud.name=='pylon') and (maxhealth and (para or 0.1) and maxhealth > para) and (buildProgress >= 1) then 
					absMetal = Spring.GetUnitRulesParam(selectedUnits[1], "OverdriveMetalBonus") or 0
					absEnergy = -(Spring.GetUnitRulesParam(selectedUnits[1], "OverdriveEnergySpent") or 0)
				end
				
				--// Mexes
	--[[ FIXME
				local odbar = barsContainer.childrenByName['overdrive']
				if (odbar) then
					windbar:SetValue(absEnergy / windMax, true)
					windbar:SetCaption(round(100*absEnergy/ windMax)..'%')
				end
	--]]

	-- special cases for mexes
				if ud.name == 'armmex' or ud.name=='cormex' then 
					local tooltip = spGetUnitTooltip(selectedUnits[1])
					window_corner.childrenByName['tooltip']:SetCaption(tooltip)
					
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
			
				
				local lbl_metal = infoContainer.childrenByName['metal']
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

				local lbl_energy = infoContainer.childrenByName['energy']
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
			else -- unit is stunned
			
				--// Nano/Builders
				local nanobar = barsContainer.childrenByName['nano']
				if (nanobar) then
					nanobar:SetValue(0,true)
					nanobar:SetCaption('0%')
				end
				
				--// Windgens
				local windbar = barsContainer.childrenByName['wind']
				if (windbar) then
					windbar:SetValue(0, true)
					windbar:SetCaption('0%')
				end
				
				local lbl_metal = infoContainer.childrenByName['metal']
				lbl_metal:SetCaption("0.0")

				local lbl_energy = infoContainer.childrenByName['energy']
				lbl_energy:SetCaption("0.0")
				
			end
		
		else
			local barsContainer = window_corner.childrenByName['Bars']

			if ((numSelectedUnits<8) and (not options.groupalways.value)) then
				for i=1,numSelectedUnits do
					local unitid = selectedUnits[i]

					local unitIcon = barsContainer.childrenByName[unitid]
					local healthbar = unitIcon.childrenByName['health']

					local health, maxhealth = spGetUnitHealth(unitid)
					if (health) then
						healthbar:SetValue(health/maxhealth)
						healthbar.tooltip = numformat(health) .. ' / ' .. numformat(maxhealth)
					end
				end
			else
				for defid,unitids in pairs(selectedUnitsByDef) do
					local health = 0
					local maxhealth = 0
					for i=1,#unitids do
						local uhealth, umaxhealth = spGetUnitHealth(unitids[i])
						health = health + (uhealth or 0)
						maxhealth = maxhealth + (umaxhealth or 0)
					end

					local unitGroup = barsContainer.childrenByName[defid]
					local healthbar = unitGroup.childrenByName['health']
					healthbar:SetValue(health/maxhealth)
					healthbar.tooltip = numformat(health) .. ' / ' .. numformat(maxhealth)
				end
			end

			--[[
			local nanobar = barsContainer.childrenByName['nano']
			if (nanobar) then
				local ud = UnitDefs[spGetUnitDefID(selectedUnits[1]) or 0]
				local metalMake, metalUse, energyMake,energyUse = Spring.GetUnitResources(selectedUnits[1])
				if metalUse then
					nanobar:SetValue(metalUse/ud.buildSpeed,true)
					nanobar:SetCaption(round(100*metalUse/ud.buildSpeed)..'%')
				else
					healthbar:SetValue(1)
					healthbar:SetCaption('??? / ' .. numformat(ud.buildSpeed))
				end

				local absMetal = metalMake - metalUse
				infoContainer.childrenByName['metal']:SetCaption((((absMetal<0)and'\255\254\000\000')or('\255\000\254\000+')) .. numformat(absMetal,1))

				local absEnergy = energyMake - energyUse
				infoContainer.childrenByName['energy']:SetCaption((((absEnergy<0)and'\255\254\000\000')or('\255\000\254\000+')) .. numformat(absEnergy,1))
			end
			--]]
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:CommandsChanged()
	numSelectedUnits = spGetSelectedUnitsCount()
	if (numSelectedUnits>0) then
		selectedUnits = spGetSelectedUnits() or {}
		selectedUnitsByDef       = spGetSelectedUnitsByDef()
		selectedUnitsByDef.n     = nil
		selectedUnitsByDefCounts = {}
		for i,v in pairs(selectedUnitsByDef) do
			selectedUnitsByDefCounts[i] = #v
		end

		--// spGetSelectedUnitsByDef() doesn't save the order for the different defids, so we reconstruct it from spGetSelectedUnits()
		--// else the sort order would change each time we select a new unit or deselect one!
		selectionSortOrder = {}
		local alreadyInList = {}
		for i=1,#selectedUnits do
			local defid = spGetUnitDefID(selectedUnits[i])
			if (not alreadyInList[defid]) then
				alreadyInList[defid] = true
				selectionSortOrder[#selectionSortOrder+1] = defid
			end
		end

		if (numSelectedUnits == 1) then
			MakeUnitToolTip(selectedUnits[1])
		else
			MakeUnitGroupSelectionToolTip()
		end

		Show(window_corner)
	else
		Hide(window_corner)
	end
end


function widget:Update(dt)
	UpdateSelectedUnitsTooltip()
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:Initialize()
	if (not WG.Chili) then
		widgetHandler:RemoveWidget()
		return
	end

	Spring.SetDrawSelectionInfo(false) 
	
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
	 screen0 = Chili.Screen0


	window_corner = Window:New{
		name   = 'unitinfo';
		x      = 0;
		y = Chili.Screen.y - 130;
		clientHeight = 130;
		clientWidth  = 300;
		dockable = true,
		--autosize    = true;
		resizable   = false;
		draggable   = true;
		dragUseGrip = true;
		--color       = {Spring.GetTeamColor(Spring.GetLocalTeamID())};
	}


	windMin = Spring.GetGameRulesParam("WindMin")
	windMax = Spring.GetGameRulesParam("WindMax")

	for i=1,#UnitDefs do
		local ud = UnitDefs[i]
		if (ud.isCommander)           --// engine overrides commanders tooltips with playernames
		  or (ud.extractsMetal > 0)   --// the Overdrive gadgets adds additional information to the tooltip, but the visualize it a different way
		  or (ud.name == 'mexpylon')
		  or (ud.name=='pylon')
		then
			ud.chili_selections_useStaticTooltip = true
		end
	end
end

function widget:Shutdown()

	Spring.SetDrawSelectionInfo(true) 

end

