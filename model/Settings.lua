                                                                                                        --[[
Welcome to Sword Admin. 

RANK TITLE  | PERMISSIONS                            | RANK NUMBER
------------|----------------------------------------|-------------
Head Admins | Full command permission                | 3
Admins      | A set command permssion of your choice | 2
Temp Admins | A set command permssion of your choice | 1                                                ]]

return{
	------[ADMINS]-------
	
	Head_Admins = {
		"widesteal321"; 
		"player2"; -- Username
		1;         -- User id
	};
	-- Head Admins have access to all commands
	
	Admins = {
		"player1"; 
		"player2";
		1;
	}; 
	Admin_Commands = {"kill"; "kick"; "ff"; "unff"; "explode"; "leaderstat"; "speed"; "clone"; "tempadmin"; "freeze"; "cmds";};

	Temp_Admins = {
		"player1"; 
		"player2";
		1;
	}; 
	Temp_AdminCommands = {"kill"; "ff"; "unff"; "speed"; "freeze"; "cmds";};
	
	------[BANNING]-------
	
	BanLand = {
		"player1";
		"player2";
		1;
	};
	
	------[PERKS_GIVEN]-------
	--! Gamepasses take higher priority over premium.
	GamePassId = 0;
	GamePassRank = 1;
	
	PremiumAdmin = false; 
	PremiumRank = 1;

	------[MISC]-------

	prefix = ";";
	adminJoinMessage = true;
	advertising = true;
	freeAdmin = false;
}
