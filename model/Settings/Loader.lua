local PowerUserSettings = require(script.Parent.PowerUserSettings)
local Modules = {
	[6] = {
		id = --[[game.ServerStorage.MainModule or]] 12279504947,
		compatiblity = {
			inStudio = true,
			overAll = true
		}
	}, 
	[5] = { 
		id = 7461392395,
		compatiblity = {
			inStudio = true,
			overAll = false
		}
	},
	[4] = {
		id = 6244431802,
		compatiblity = {
			inStudio = false,
			overAll = false
		}
	},
	[3] = {
		id = "invalid",
		compatiblity = {
			inStudio = false,
			overAll = false
		} 
	},
	[2] = {
		id = "invalid",
		compatiblity = {
			inStudio = false,
			overAll = false
		} 
	},
	[1] = {
		id = "invalid",
		compatiblity = {
			inStudio = false,
			overAll = false
		} 
	}
}

if PowerUserSettings.sword.sEnabled == false then 
	script.Parent.Parent:Destroy()
end
local SelectedVersion = Modules[PowerUserSettings.sword.sVersion]
pcall(function() require(SelectedVersion.id).Parent = workspace end)

if PowerUserSettings.sword.compatWarnings == true then
	if SelectedVersion == nil then 
		warn("URGENT: Invalid version detected. If you wish to disable Sword Admin, set the 'Loader' script to disabled. Otherwise set to a valid version.")
	end
	if SelectedVersion.id == "invalid" then 
		warn("URGENT: Selected version [v" .. PowerUserSettings.sword.sVersion .. "] is comletely unsupported with this module and refuses to load.")
	end
	if SelectedVersion.compatiblity.overAll == false then
		warn("WARNING: This version of Sword Admin [v" .. PowerUserSettings.sword.sVersion .. "] is not supported with this model") 
	end
	if SelectedVersion.compatiblity.inStudio == false then
		warn("WARNING: This version of Sword Admin [v" .. PowerUserSettings.sword.sVersion .. "] is not supported in Studio mode") 
	end
end
