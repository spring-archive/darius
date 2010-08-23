return {
	name = "Crystal Cave",
	easy = {
		{ -- wave 1
			duration = 20,
			{ monster = "chicken", interval = 1, amount = 10, location = 1 },
			{ monster = "chicken", interval = 5, amount = 10, location = 2 },
			{ monster = "chicken", interval = 5, amount = 10, location = 2 },
			{ monster = "chicken", interval = 5, amount = 10, location = 2 },
			{ monster = "chicken", interval = 5, amount = 10, location = 2 }
		},
		{ -- wave 2
			duration = 10,
			{ monster = "corthud", interval = 2, amount = 3, location = 1 },
		}
	},
	castleposition = {850, 200},
	spawningpoints = {
		{500,1000},
		{1000,500},
  	},
}
