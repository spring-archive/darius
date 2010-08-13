local confdata = {}


local color = {
	transblack  = {0.0, 0.0, 0.0, 0.3},
	transgray   = {0.1, 0.1, 0.1, 0.8},
	white       = {1.0, 1.0, 1.0, 1.0},
	postit      = {1.0, 0.9, 0.5, 1.0},
	yellow      = {1.0, 1.0, 0.0, 1.0},
	orange      = {1.0, 0.5, 0.0, 1.0},
	lightgray   = {0.7, 0.7, 0.7, 1.0},
	gray        = {0.5, 0.5, 0.5, 1.0},
	darkgray    = {0.3, 0.3, 0.3, 1.0},
	grayred     = {0.5, 0.4, 0.4, 1.0},
	grayblue    = {0.4, 0.4, 0.4, 1.0},
	cyan        = {0.0, 1.0, 1.0, 1.0},
	blue        = {0.0, 0.0, 1.0, 1.0},
	red         = {1.0, 0.0, 0.0, 1.0},
	darkred     = {0.5, 0.0, 0.0, 1.0},
	green       = {0.0, 1.0, 0.0, 1.0},
	darkgreen   = {0.0, 0.5, 0.0, 1.0},
	black       = {0.0, 0.0, 0.0, 1.0},
}

color.tooltip_bg     = color.transgray
color.tooltip_fg     = color.white
color.tooltip_info   = color.cyan
color.tooltip_help   = color.green

color.main_bg        = color.transblack
color.main_fg        = color.white

color.menu_bg        = color.grayblue
color.menu_fg        = color.white

color.game_bg        = color.gray
color.game_fg        = color.white

color.sub_bg         = color.transblack
color.sub_fg         = color.white
color.sub_header     = color.yellow

color.sub_button_bg  = color.gray
color.sub_button_fg  = color.white

color.sub_back_bg    = color.grayblue
color.sub_back_fg    = color.white

color.sub_close_bg   = color.grayblue
color.sub_close_fg   = color.white

color.stats_bg       = color.sub_bg
color.stats_fg       = color.sub_fg
color.stats_header   = color.sub_header

color.context_bg     = color.transblack
color.context_fg     = color.white
color.context_header = color.white



confdata.title = 'Darius Tower Defense'
confdata.color       = color


return confdata