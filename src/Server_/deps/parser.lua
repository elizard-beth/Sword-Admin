--[[function test(str: string) 
	if str.find("'") then
		local _str = str:sub(str.find("'"))
		local _str = _str:sub(2, str.find("'"))
		str = str:gsub(" ","_")
	end
end --]]

local Settings = require(game:FindFirstChild("Sword_Admin" , true).Settings)
local prefix = Settings.prefix

return {
	find_in_bounds = function(str, match)
		if string.find(str, match) == nil then return str end
		local _str = str:sub(string.find(str, match) + match:len(), str:len())
		local _str = _str:sub(1, string.find(_str, match) - match:len())
		return _str
	end,
	
	get_command = function(str)
		return string.split(str, " ")[1]:sub(prefix:len() + 1, str:len()) or str:sub(prefix:len() + 1, str:len())
		--Message:sub(#Settings.prefix + 1, #(Message:split(" ")[1] or #Message))	
	end,
	
	get_time_period = {
		periods = {
			["m"] = {"month" , 2628288},
			["d"] = {"day", 86400},
			["h"] = {"hour", 3600},
			["s"] = {"second", 2}
		},
		parse = function(str)
			
		end,
	}
}
