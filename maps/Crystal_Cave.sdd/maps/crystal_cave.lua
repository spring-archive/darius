return {
	name = "Crystal Cave",
	waves = {
		easy = {
			{ -- wave 1
				duration = 30,
				{ monster = "chicken", interval = 1, amount = 15, location = 1 },		
			},
			{ -- wave 2
				duration = 25,
				{ monster = "corthud", interval = 2, amount = 10, location = 1 },
			},
			{ -- wave 3
				duration = 30,
				{ monster = "arm_venom", interval = 2, amount = 8, location = 1 },
			},
			{ -- wave 4
				duration = 40,
				{ monster = "corstorm", interval = 2, amount = 15, location = 1 },
			},
			{ -- wave 5
				duration = 30,
				{ monster = "chicken_sporeshooter", interval = 2, amount = 15, location = 1 },
			},
			{ -- wave 6
				duration = 40,
				{ monster = "armwar", interval = 3, amount = 8, location = 1 },
			},
			{ -- wave 7
				duration = 20,
				{ monster = "corpyro", interval = 1, amount = 10, location = 1 },
			    { monster = "corpyro", interval = 1, amount = 10, location = 2 },
			},
			{ -- wave 8
				duration = 60,
				{ monster = "chickena", interval = 3, amount = 10, location = 1 },
			},
			{ -- wave 9
				duration = 11,
				{ monster = "armwar", interval = 2, amount = 6, location = 1 },
			},
			{ -- wave 10
				duration = 30,
				{ monster = "chickenq", interval = 1, amount = 1, location = 1 },
			}
		},
	},
	awards = {
		--easy = {},
		--normal = {},
		--hard = {},
	},
	castleposition = {850, 200},
	spawningpoints = {
		{50, 900},
		{100, 900},
  	},
}
