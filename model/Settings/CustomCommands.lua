local function get_conditions(Player, subject)return {(Player.Name == subject) or (subject == "me") or (subject == nil),subject == "all",subject == "others"}end local function exec(Player, subject, code)	local conditions = get_conditions(Player, subject)if conditions[1] then  code(Player)elseif conditions[2] then for _, plr in pairs(game.Players:GetPlayers()) do code(plr)end elseif conditions[3] then for _, plr in pairs(game.Players:GetPlayers()) do if plr ~= Player then code(plr) end end else for _, plr in pairs(game.Players:GetPlayers()) do if subject == plr.Name:sub(1,#subject):lower() then code(subject) break end end end end

return {
	["COMMAND_NAME"] = {
		function(Player, args)
			exec(Player, args[1], function(plr)
				
			end)
		end,
		args = {
			function(str) return string.split(str, " ")[2] end,
			function(str) return str end, 
			function(str) return str end 
		}
	}
}



