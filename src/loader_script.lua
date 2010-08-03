-- This is used by the main menu to restart the game.
-- The menu first runs it (thus getting the return) and modifies the necessary properties.
-- Once the properties are correct it calls toString to generate the script it must send to the restart function.

return {
	PlayerName = "Darius", --Default player name for next game
	MapName = "dunes.smf", --Default map for next game
	GameMode = 1,          --Default game mode.  Found empirically (works ;) )

	toString = function(self)
		return [[
			[GAME]
			{
				GameType = Darius Tower Defense 0.1;
				Mapname = ]]..self.MapName..[[;

				[MODOPTIONS]
				{
					GameMode = ]]..self.GameMode..[[;
					ghostedbuildings = 1; //?
					fixedallies = 1;
					MaxUnits = 512;
					MinSpeed = 0.1;
					MaxSpeed = 10;

					// Irrelevant for Darius:
					StartMetal = 0;
					StartEnergy = 1000; //This was midly relevant after all (Issue 22)
					LauncherName = Darius Game Launcher;
					LauncherVersion = 0.1;
				}

				//Leave these alone
				HostIP=localhost;
				HostPort=0;
				IsHost=1;

				StartPosType = 0;// 0 for fixed, 1 for random, 2 for chosen
				MyPlayerNum = 0;
				MyPlayerName = ]]..self.PlayerName..[[;
				NumPlayers = 1;
				NumUsers = 2;
				NumTeams = 2;
				NumAllyTeams = 2;

				// List of human controlled players:
				[PLAYER0]
				{
					name = ]]..self.PlayerName..[[;
					Team = 1; //Which team is used
					Spectator = 0; //Obviously our player is playing. :P
				}

				// List of AI controlled players:
				[AI0]
				{
					name = Invaders; //This sets the name of the AI bot
					ShortName = NullAI; //This might set the AI used
					Team = 0; //Which team is used
					Host = 0; // Number of the PLAYER hosting the AI
				}

				// List of "teams" (or "players" depending on terminology):
				[TEAM0]
				{
					TeamLeader = 0; //Team Leader index from team's collection (so first in list)
					AllyTeam = 0; //The ally team (see below)
					Handicap = 0;
					Side=random; //We can fix the side here (side must exist)
					RGBColor = 1 0 0; //Color by float
					AIDLL = NullAI 0.1; //This is probably what actually sets the AI in use
					RemoveUnits = 1; //Not sure what this does
					RemoveFeatures = 1; //Not sure what this does
					//u1= castle Position 50 50; //We could give the team starting units (f# for features)
				}
				[TEAM1]
				{
					TeamLeader=0;
					AllyTeam=1;
					Handicap=0;
					Side=random;
					RGBColor=0 1 0;
					RemoveUnits=1;
					RemoveFeatures=1;
					//u1= castle Position 1000 1000;
				}

				// List of ally teams: This is for assymetrical alliances
				[ALLYTEAM0] //No idea how these work.  Doesn't matter to us.
				{
					NumAllies=0;
				}
				[ALLYTEAM1]
				{
					NumAllies=0;
				}

				// List of restrictions (I have no idea)
				NumRestrictions=0;
				[RESTRICT]
				{
				}
			}
		]]
	end,
}