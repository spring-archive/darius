return {
	name = "The Labyrinth",
	waves = {
			easy = {
			{duration = 10,
			{ monster = "chicken", interval = 2, amount = 1, location = 1 },
			},
			},
--[[		easy = {
			{ -- wave 1
				duration = 30,
				{ monster = "chicken", interval = 2, amount = 5, location = 1 },
				{ monster = "armpw", interval = 2, amount = 5, location = 1 },
			},
			{ -- wave 2
				duration = 30,
				{ monster = "corthud", interval = 2, amount = 10, location = 1 },
			},
			{ -- wave 3
				duration = 30,
				{ monster = "armpw", interval = 2, amount = 10, location = 1 },
			},
			{ -- wave 4
				duration = 30,
				{ monster = "arm_venom", interval = 2, amount = 5, location = 1 },
				{ monster = "corthud", interval = 2, amount = 10, location = 1 },
			},
			{ -- wave 10
				duration = 30,
				{ monster = "chicken_sporeshooter", interval = 2, amount = 10, location = 1 },
			},
			{ -- wave 11
				duration = 30,
				{ monster = "cormortgold", interval = 2, amount = 2, location = 1 },
				{ monster = "arm_venom", interval = 2, amount = 2, location = 1 },
			},
		},--]]
		normal = {
		},
		hard = {
		},
	},
	castleposition = {90, 100},
	spawningpoints = {
		{950, 100},
  	},
}
