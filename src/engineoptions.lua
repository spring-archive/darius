local options  = 
{
	{
	key    = 'modifiers',
	name   = 'In-Game Conditions',
	desc   = 'Set up ingame conditions.',
	type   = 'section',
	},
	{
    key    = 'GameMode',
    name   = 'Game end condition',
    desc   = 'Determines what condition triggers the defeat of a player',
    type   = 'list',
    section= 'modifiers',
    def    = '1',
    items  = {
		{
		key  = '1',
		name = 'Commander ends',
		desc = 'The player will lose when his castle is destroyed',
		},
	},
	},

}
return options