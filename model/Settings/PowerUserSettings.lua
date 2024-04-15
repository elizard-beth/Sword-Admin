-- being a power user can require frequent updates to keep bugs away

return {
	sword = {
		sVersion = 7; 
			compatWarnings = true;
		sEnabled = true;
	},
	
	client = {
		--[[fly = {
			bg = {
				P = 9e4,
				maxTorque = Vector3.new(9e9, 9e9, 9e9) 
			},
			bv = {
				velocity = Vector3.new(0,0.1,0), 
				maxForce = Vector3.new(9e9, 9e9, 9e9)
			},
		},]] -- no longer does anything with new script
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
			disabled_commands = {}
		}
	}
}
