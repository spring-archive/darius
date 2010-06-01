local confdata = {}
confdata.title = 'C.A.'
local color = {
	white = {1,1,1,1},
	yellow = {1,1,0,1},
	gray = {0.5,.5,.5,1},
	darkgray = {0.3,.3,.3,1},
	cyan = {0,1,1,1},
	red = {1,0,0,1},
	darkred = {0.5,0,0,1},
	blue = {0,0,1,1},
	black = {0,0,0,1},
	darkgreen = {0,0.5,0,1},
	green = {0,1,0,1},
	postit = {1,0.9,0.5,1},
	
	grayred = {0.5,0.4,0.4,1},
	grayblue = {0.4,0.4,0.45,1},
	transblack = {0,0,0,0.3},
	transblack2 = {0,0,0,0.7},
	transGray = {0.1,0.1,0.1,0.8},
}
color.tooltip_bg = color.transGray
color.tooltip_fg = color.white
color.tooltip_info = color.cyan
color.tooltip_help = color.green

color.main_bg = color.transblack
color.main_fg = color.white

color.menu_bg = color.grayblue
color.menu_fg = color.white

color.game_bg = color.gray
color.game_fg = color.white

color.sub_bg	= color.transblack
color.sub_fg 	= color.white
color.sub_header = color.yellow

color.sub_button_bg = color.gray
color.sub_button_fg = color.white

color.sub_back_bg = color.grayblue
color.sub_back_fg = color.white

color.sub_close_bg = color.grayblue
color.sub_close_fg = color.white

color.stats_bg = color.sub_bg
color.stats_fg = color.sub_fg
color.stats_header = color.sub_header

color.context_bg = color.transblack
color.context_fg = color.white
color.context_header = color.white

confdata.color = color

local spSendCommands = Spring.SendCommands

local MaximumParticlesSteps = {100,500,1000,2000,5000,10000,20000}
local function GetIndex(t,v) local idx = 1; while (t[idx]<v)and(t[idx+1]) do idx=idx+1; end return idx end

confdata.game_menu_tree = {
	{'Pause/Unpause', function(self) spSendCommands{"pause"} end },
	{},
	{'Share Dialog...', function(self) spSendCommands{"sharedialog"} end },	
	{'Autogroup', 
		{
			{'Clear Groups', function(self) spSendCommands{"luaui autogroup cleargroups"} end },
			{'Toggle Load Groups', function(self) spSendCommands{"luaui autogroup loadgroups"} end },
			{'Toggle Verbose', function(self) spSendCommands{"luaui autogroup verbose"} end },
			{'Toggle Add All', function(self) spSendCommands{"luaui autogroup addall"} end },
			{},
			{
				'AutoGroup Help',
				'Autogroup is a widget that places newly built units into groups you can quickly define with keyboard shortcuts. '..
				'Alt+0-9 sets an number for the unit type(s) you currently have selected. When a new unit is built, it gets added to the group based on this autogroup.'..
				'Alt+\~ deletes the autogrouping for the selected unit type(s).'..
				'Ctrl+~ removes the nearest selected unit from its group and selects it. '
				
			},
		}
	},
	{'Factory Guard', function() spSendCommands{"luaui togglewidget FactoryGuard"} end },
	
	{'Views'},
	{'Line of Sight'},
	{'Toggle Fog of War', function(self) spSendCommands{"togglelos"} end },
	{'Toggle Radar/Jammer', function(self) spSendCommands{"toggleradarandjammer"} end },	
	
	{'Map Views'},
	{'Normal', function(self) spSendCommands{"showstandard"} end },	
	{'Toggle Metal Map', function(self) spSendCommands{"ShowMetalMap"} end },
	{'Toggle Elevation', function(self) spSendCommands{"showelevation"} end },	
	{'Toggle Pathing', function(self) spSendCommands{"showpathmap"} end },
	{},
	{'Actions|Take screenshots.',
		{
			{'Save Screenshot (PNG)|Find your screenshots under Spring/screenshots', function() spSendCommands{"screenshot"} end },	
			{'Save Screenshot (JPG)|Find your screenshots under Spring/screenshots', function() spSendCommands{"screenshot jpg"} end },	
		}
	},
	

}

confdata.help_tree = {
	{
		'Tips',
		'Hold your meta-key (spacebar by default) while clicking on a unit or corpse for more info and options. '..
		'You can also space-click on menu elements to see context settings. '..
		'There is much more to come. Please enjoy using Crude Menu!'
	},			
	{'Tutorial', function() spSendCommands{"luaui togglewidget Nubtron"} end },
}

--[[

	--]]

confdata.menu_tree = {	
	{'Languages...|Choose your preferred language', function() WG.crude.ShowFlags() end },	
	{'Reset Settings|Reset certain settings', 
		{
			{'Reset graphic settings to minimum.'},
			{
				'Reset graphic settings|Use this if your performance is poor', 
				function()
					spSendCommands{"water 0"}
					spSendCommands{"Shadows 0"} 
					spSendCommands{"maxparticles 1000"}
					spSendCommands{"advshading 0"}
					spSendCommands{"grounddecals 0"}
					spSendCommands{'luaui disablewidget LupsManager'}
					spSendCommands{"luaui disablewidget Display DPS"}
					spSendCommands{"luaui disablewidget SelectionHalo"}
					spSendCommands{"luaui enablewidget SelectionCircle2"}
				end 
			},
			{'Reset widget settings to default.'},
			{
				'Reset widget settings', 
				function()
					WG.crude.ResetWidgets()
				end 
			},
			
		}
	},
	{},
	{'Effects|Graphical effects.',
		{
			{'Night', 
				{	
					{'Toggles'},
					{'Night View', function() spSendCommands{'luaui togglewidget Night'} end },
					{},
					{'Night Colored Units', function() spSendCommands{'luaui night_preunit'} end },
					{'Beam', function() spSendCommands{'luaui night_beam'} end },
					{'Cycle', function() spSendCommands{'luaui night_cycle'} end },
					{'Searchlight Base Types'},
					{'None', function() spSendCommands{'luaui night_basetype 0'} end },
					{'Simple', function() spSendCommands{'luaui night_basetype 1'} end },
					{'Full', function() spSendCommands{'luaui night_basetype 2'} end },	
				}
			},
			{'Camera Shake', function() spSendCommands{'luaui togglewidget CameraShake'} end },
		}
	},
	{'Interface|Settings relating to the GUI', 
		{
			
			{'Spring Build Menu',
				{
					{'Unit Icon Colors'},
					{'Colorized', function() 
						WG.Layout.colorized = true
						Spring.ForceLayoutUpdate()
						end },
					{'Black & White', function() 
						WG.Layout.colorized = false
						Spring.ForceLayoutUpdate()
						end },
					{'Commands to Show'},
					{'All', function() 
						WG.Layout.minimal = false
						Spring.ForceLayoutUpdate()
						end },
					{'Minimal', function() 
						WG.Layout.minimal = true
						Spring.ForceLayoutUpdate()
						end },
					--{'ch_Hide Units', 'hideUnits' },
					{'Show Units', function() WG.Layout.hideUnits = false; Spring.ForceLayoutUpdate() end },
					{'Hide Units', function() WG.Layout.hideUnits = true;Spring.ForceLayoutUpdate() end },
				}
			},
			
			{'Set An Avatar...|Requires Avatar widget, used in widgets such as Chili Chat Bubbles', function() spSendCommands{"luaui enablewidget Avatars", "setavatar"} end },
			{'Toggle Chili Chat', function() spSendCommands{"luaui togglewidget Chili Chat"} end },
			{'Toggle BuildBar', function() spSendCommands{"luaui togglewidget BuildBar"} end },
			
		}
	},
	{'Misc|Less common advanced settings', 
		{
			
			{'Widget List...', function() WG.crude.ShowWidgetList2() end },
			{'Local Widget Config', function() spSendCommands{"luaui localwidgetsconfig"} end},
			{'LuaUI TweakMode (Esc to exit)|LuaUI TweakMode. This mode is used to configure some older widgets. (Hit Esc to exit)', function() spSendCommands{"luaui tweakgui"} end },
			--[[
			{'Reset all widget settings', function() 
				include("savetable.lua")
				local ORDER_FILENAME     = LUAUI_DIRNAME .. 'Config/CA_order.lua'        
				local CONFIG_FILENAME    = LUAUI_DIRNAME .. 'Config/CA_data.lua'  
				Spring.Echo ('test', ORDER_FILENAME)
				table.save({}, ORDER_FILENAME)    
				table.save({}, CONFIG_FILENAME)
				end,
			},
			--]]
		}
	},
	{'Mouse Settings|Change your cursor and other mouse settings',
		{
			{'Cursor Sets'},
			{'Complete Annihilation', function() WG.crude.RestoreCursor() end },
			{'CA Static', function() WG.crude.SetCursor("ca_static") end },
			{'Erom', function() WG.crude.SetCursor("erom") end },
			{'Masse', function() WG.crude.SetCursor("masse") end },
			{'Lathan', function() WG.crude.SetCursor("lathan") end },
			{'K_haos_girl', function() WG.crude.SetCursor("k_haos_girl") end },
			{},
			{'Toggle Grab Input|Mouse cursor won\'t be able to leave the window.', function() spSendCommands{"grabinput"} end },
		},
	},
	{'Video|These settings strongly affect the balance of quality of graphics vs. the speed of the gameplay', 
		{
			{'Lups (Lua Particle System)'},
			{'Toggle Lups', function() spSendCommands{'luaui togglewidget LupsManager'} end },	

			{'Various'},
			{'Toggle Shiny Units', function() spSendCommands{"advshading"} end },
			{'Toggle Ground Decals', function() spSendCommands{"grounddecals"} end },
			{"tr_Maximum Particles" , { min=1, max=#MaximumParticlesSteps, step=1, value=GetIndex(MaximumParticlesSteps,Spring.GetConfigInt("MaxParticles")), action=function(self) Spring.SendCommands{"maxparticles " .. MaximumParticlesSteps[self.value]} end, } },
			
			{'View Radius'},
			{'Increase Radius', function() spSendCommands{"increaseViewRadius"} end },	
			{'Decrease Radius', function() spSendCommands{"decreaseViewRadius"} end },
			
			{'Trees'},
			{'Toggle View', function() spSendCommands{'drawtrees'} end },	
			{'See More Trees', function() spSendCommands{'moretrees'} end },	
			{'See Less Trees', function() spSendCommands{'lesstrees'} end },	
			--{'Toggle Dynamic Sky', function(self) spSendCommands{'dynamicsky'} end },	
			
			{'Water Settings'},
			{'Basic', function() spSendCommands{"water 0"} end },
			{'Reflective', function() spSendCommands{"water 1"} end },
			{'Reflective and Refractive', function() spSendCommands{"water 2"} end },
			{'Dynamic', function() spSendCommands{"water 3"} end },
			{'Bumpmapped', function() spSendCommands{"water 4"} end },
			
			{'Shadow Settings'},
			{'Disable Shadows', function() spSendCommands{"Shadows 0"} end },
			{'Toggle Terrain Shadows', function() local curShadow=Spring.GetConfigInt("Shadows"); if (curShadow<2) then curShadow=2 else curShadow=1 end; spSendCommands{"Shadows "..curShadow} end },
			{'Low Detail Shadows', function() local curShadow=Spring.GetConfigInt("Shadows"); curShadow=math.max(1,curShadow); spSendCommands{"Shadows " .. curShadow .. " 1024"} end },
			{'Medium Detail Shadows', function() local curShadow=Spring.GetConfigInt("Shadows"); curShadow=math.max(1,curShadow); spSendCommands{"Shadows " .. curShadow .. " 2048"} end },
			{'High Detail Shadows', function() local curShadow=Spring.GetConfigInt("Shadows"); curShadow=math.max(1,curShadow); spSendCommands{"Shadows " .. curShadow .. " 4096"} end },
			--{'Extreme Detail Shadows', function() spSendCommands{"Shadows 1 8192"} end },
		}
	},
	{'View|Settings such as camera modes.',
		{
			{'Spectator View/Selection'},
			{'View Chosen Player', function() spSendCommands{"specfullview 0"} end },
			{'View All', function() spSendCommands{"specfullview 1"} end },
			{'Select Any Unit', function() spSendCommands{"specfullview 2"} end },
			{'View All & Select Any', function() spSendCommands{"specfullview 3"} end },
			
			{'Camera Type'},
			{'Total Annihilation', function() spSendCommands{"viewta"} end },
			{'FPS', function() spSendCommands{"viewfps"} end },
			{'Free', function() spSendCommands{"viewfree"} end },
			{'Rotatable Overhead', function() spSendCommands{"viewrot"} end },
			{'Total War', function() spSendCommands{"viewtw"} end },
			
			{'Flip the TA Camera', function() spSendCommands{"viewtaflip"} end },
			
			{'Minimap Icon Colors'},
			{'Team Colors|Show radar blips in the color of their team.', function(self) spSendCommands{"minimap simplecolors 0"} end },
			{'Simple Colors|Show radar blips as green for yours, blue for allies and red for enemies.', function(self) spSendCommands{"minimap simplecolors 1"} end },
			
			{'tr_Icon Distance', {min = 1, max = 1000, action = function(self)	Spring.SendCommands{"disticon " .. self.value} end } },
			
			{'tr_Brightness', { min=0, max=1, step=0.01, action = function(self) Spring.SendCommands{"luaui enablewidget Darkening", "luaui darkening " .. 1-self.value} end, preview=true } },

			{},
			{'Toggle Healthbars', function() spSendCommands{'showhealthbars'} end },	
			{'Toggle DPS Display|Shows RPG-style damage', function() spSendCommands{"luaui togglewidget Display DPS"} end },
			
			--{'Hide Interface', function(self) spSendCommands{'hideinterface'} end },	
			--{'showshadowmap', function(self) spSendCommands{'showshadowmap'} end },	
		}
	},

}

return confdata

