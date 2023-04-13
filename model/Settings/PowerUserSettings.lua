-- being a power user can require frequent updates to keep bugs away

return {
	sword = {
		sVersion = 6; 
			compatWarnings = true;
		sEnabled = true;
	},
	
	client = {
		fly = {
			bg = {
				P = 9e4,
				maxTorque = Vector3.new(9e9, 9e9, 9e9) 
			},
			bv = {
				velocity = Vector3.new(0,0.1,0), 
				maxForce = Vector3.new(9e9, 9e9, 9e9)
			},
		},
		msgcountdown = {
			maxNum = 200,
		},
		noclip = {
			-- no valid settings	
		},
		reservedServer = {
			-- no valid settings	
		}
	},
	
	server = {
		CommandHandler = {
			enabled_commands = { "kill", "tp", "gear", "leaderstat", "sword", "faceless", "headless", "privateserver", "invisible", "visible", "admin", "unadmin", "tempadmin", "untempadmin", "ban", "unban", "fire", "smoke", "sparkles", "hipheight",  "btools", "jail", "unjail", "blind", "unblind", "brightness", "noclip", "countdown", "msg", 'music', "fly", "explode", "rejoin", "cmds", "commands", "shutdownserver", "setgrav", "require", "kick", "health", "god", "freeze", "unfreeze", "speed", "jumppower", "ff", "unff", "sit", "unsit", "char", "clone", "print", "fling" }
		}
	}
}
