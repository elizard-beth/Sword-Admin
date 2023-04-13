-- utilizes outdated methods for checking if a 
-- user is an admin or not, please be aware

local PowerUserSettings = require(game.Workspace.Sword_Admin.Settings.PowerUserSettings)
local Settings = require(game:FindFirstChild("Sword_Admin" , true).Settings)
local HeadAdmins = Settings.Head_Admins
local AdmindsDataStore = game:GetService("DataStoreService"):GetDataStore("Admins_s")
local TempAdmindsDataStore = game:GetService("DataStoreService"):GetDataStore("TAdmins_s")
local BansDataStore = game:GetService("DataStoreService"):GetDataStore("Bans_s")
local MarketPlaceService = game:GetService("MarketplaceService")

coroutine.wrap(function()
	pcall(function()
		if not AdmindsDataStore:GetAsync(1) then
			AdmindsDataStore:SetAsync(1, Settings.Admins)
		end
		
		if not TempAdmindsDataStore:GetAsync(1) then
			TempAdmindsDataStore:SetAsync(1, Settings.Temp_Admins)
		end

		local temp_tempa = TempAdmindsDataStore:GetAsync(1)
		for _, v in pairs (Settings.Temp_Admins) do
			if not table.find(TempAdmindsDataStore:GetAsync(1), v) then
				table.insert(temp_tempa, v)
			end
		end
		TempAdmindsDataStore:SetAsync(1, temp_tempa)
		
		local temp_a = AdmindsDataStore:GetAsync(1)
		for _, v in pairs (Settings.Admins) do
			if not table.find(AdmindsDataStore:GetAsync(1), v) then
				table.insert(temp_a, v)
			end
		end
		AdmindsDataStore:SetAsync(1, temp_a)
	end)
end)()

function ParseMessage(Player, Message)
	if Message:sub(1,#Settings.prefix) == Settings.prefix then
		local Command = Message:sub(#Settings.prefix + 1, #(Message:split(" ")[1] or #Message))	
		if table.find(PowerUserSettings.server.CommandHandler.enabled_commands, Command) == nil then return "fail" end
		local CommandHandler = require(script.Parent.CommandHandler)
		local func = CommandHandler[Command]

		--check headadmin
		if table.find(HeadAdmins, Player.UserId) or Player.UserId == game.CreatorId 
			or table.find(HeadAdmins, Player.Name) then
			local succ, err = pcall(function() 
				func(Player, Message:split(" ")[2], Message:split(" ")[3])
			end)
			if not succ then
				print(err)
				game.ReplicatedStorage.Events_.Notification:FireClient(Player, err)
			end
		--check admin
		elseif table.find(AdmindsDataStore:GetAsync(1), Player.UserId) 
			or table.find(AdmindsDataStore:GetAsync(1), Player.Name) then
			if table.find(Settings.Admin_Commands, Message:sub(#Settings.prefix + 1, Message:find(" ") or Message:len())) then
				local succ, err = pcall(function() 
					func(Player, Message:split(" ")[2], Message:split(" ")[3])
				end)
				if not succ then
					print(err)
					game.ReplicatedStorage.Events_.Notification:FireClient(Player, err)
				end
			end
		--check tempadmin
		elseif Settings.freeAdmin == true 
			or table.find(TempAdmindsDataStore:GetAsync(1), Player.UserId) 
			or table.find(TempAdmindsDataStore:GetAsync(1), Player.Name) 
		then
			if table.find(Settings.Temp_AdminCommands, Message:sub(#Settings.prefix + 1, Message:find(" ") or Message:len())) then
				local succ, err = pcall(function() 
					func(Player, Message:split(" ")[2], Message:split(" ")[3])
				end)
				if not succ then
					print(err)
					game.ReplicatedStorage.Events_.Notification:FireClient(Player, err)
				end
			end
		end
	end
end

game.Players.PlayerAdded:Connect(function(Player)
	local PlayerPurchasedRank = 0
	if Player.MembershipType == Enum.MembershipType.Premium
		and Settings.PremiumAdmin == true then
		PlayerPurchasedRank = Settings.PremiumRank
	end
	pcall(function() 
		if MarketPlaceService:UserOwnsGamePassAsync(Player.UserId, Settings.GamePassId) then
			PlayerPurchasedRank = Settings.GamePassRank
		end
	end)
	
	--private server handler
	if script.Parent.PrivateServer.Value == true then
		if table.find(HeadAdmins, Player.UserId) or table.find(HeadAdmins, Player.Name)
			or Player.UserId == game.CreatorId or PlayerPurchasedRank == 3 
		    or table.find(AdmindsDataStore:GetAsync(1), Player.UserId) 
			or table.find(AdmindsDataStore:GetAsync(1), Player.Name)
			or PlayerPurchasedRank == 2 	
			or Settings.freeAdmin == true 
			or table.find(TempAdmindsDataStore:GetAsync(1), Player.UserId) 
			or table.find(TempAdmindsDataStore:GetAsync(1), Player.Name) 
			or PlayerPurchasedRank == 1
		then else
			Player:Kick("This server is locked to Admins only.")
		end
	end
	
	
	--ban handler
	pcall(function()
		if BansDataStore:GetAsync(Player.UserId) then
			if BansDataStore:GetAsync(Player.UserId)[2] == true then
				Player:Kick("You are banned from this game for: " ..
				 (BansDataStore:GetAsync(Player.UserId)[1] or "unspecified"))
			end
		end
		if table.find(Settings.BanLand, Player.Name) then 
			Player:Kick("You are banned.")
		end
		if table.find(Settings.BandLand, Player.UserId) then
			Player:Kick("You are banned.")
		end
	end)
	
	if Settings.adminJoinMessage == true then
		if table.find(HeadAdmins, Player.UserId) or table.find(HeadAdmins, Player.Name)
			or Player.UserId == game.CreatorId or PlayerPurchasedRank == 3 then
			game.ReplicatedStorage:WaitForChild("Events_").IsAdmin:FireClient(Player, "Head Admin")
		elseif table.find(AdmindsDataStore:GetAsync(1), Player.UserId) 
			or table.find(AdmindsDataStore:GetAsync(1), Player.Name)
			or PlayerPurchasedRank == 2 then	
			game.ReplicatedStorage:WaitForChild("Events_").IsAdmin:FireClient(Player, "Admin")
		elseif Settings.freeAdmin == true 
				or table.find(TempAdmindsDataStore:GetAsync(1), Player.UserId) 
			or table.find(TempAdmindsDataStore:GetAsync(1), Player.Name) 
			or PlayerPurchasedRank == 1
		then
			game.ReplicatedStorage:WaitForChild("Events_").IsAdmin:FireClient(Player, "Temporary Admin")
		end
	end

	--message sent
	Player.Chatted:Connect(function(Message)
		ParseMessage(Player, Message)
	end)
	
	--command bar used
	game.ReplicatedStorage:WaitForChild("Events_").CommandBar.OnServerEvent:Connect(function(Player, Message)
		ParseMessage(Player, Message)
	end)
end)
