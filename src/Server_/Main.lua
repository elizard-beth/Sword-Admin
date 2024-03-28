print("Initializing Sword Admin v7...")
local PowerUserSettings = require(game.Workspace.Sword_Admin.Settings.PowerUserSettings)
local SettingsL = workspace.Sword_Admin.Settings
local Settings = require(workspace.Sword_Admin.Settings)
local CustomCommands =  require(SettingsL.CustomCommands)
local HeadAdmins = Settings.Head_Admins
local AdmindsDataStore = game:GetService("DataStoreService"):GetDataStore("Admins_s")
local TempAdmindsDataStore = game:GetService("DataStoreService"):GetDataStore("TAdmins_s")
local BansDataStore = game:GetService("DataStoreService"):GetDataStore("Bans_s")
local MarketPlaceService = game:GetService("MarketplaceService")
local Parser = require(script.Parent.deps.parser)
local CommandHandler = require(script.Parent.CommandHandler)
for _, v in pairs(CustomCommands) do 
	table.insert(CommandHandler, v)
end

local TempAdmins = TempAdmindsDataStore:GetAsync(1)
if not TempAdmins then
	TempAdmindsDataStore:SetAsync(1, Settings.Temp_Admins)
end
for _, v in pairs(TempAdmins) do 
	table.insert(Settings.Temp_Admins, v) 
end

if not AdmindsDataStore:GetAsync(1) then
	AdmindsDataStore:SetAsync(1, Settings.Admins)
end
local Admins = AdmindsDataStore:GetAsync(1)
for _, v in pairs(Admins) do 
	table.insert(Settings.Admins, v)
end

print("Initialized Sword Admin v7.")


CheckAdmin = {
	PurchasedRank = function(Player)
		local PlayerPurchasedRank = 0
		if Player.MembershipType == Enum.MembershipType.Premium
			and Settings.PremiumAdmin == true then
			PlayerPurchasedRank = Settings.PremiumRank
		end
		local Success, Error = pcall(function() 
			if MarketPlaceService:UserOwnsGamePassAsync(Player.UserId, Settings.GamePassId) then
				PlayerPurchasedRank = Settings.GamePassRank
			end
		end)
		if Settings.GamePassId > 0 then
			warn("Sword Admin: Error checking if user owns gamepass. Is your ID correct?")
		end
		
		return PlayerPurchasedRank
	end,
	IsAdmin = function(Player) 
		--[[local PlayerName = Player.Name:lower()
		local currentAdminDataStore = AdmindsDataStore:GetAsync(1)
		local currentTempAdminDataStore = TempAdmindsDataStore:GetAsync(1)
		local PlayerPurchasedRank = CheckAdmin.PurchasedRank(Player)
		]]
		return CheckAdmin.AdminRank(Player) > 0
	end,
	AdminRank = function(plr)
		if typeof(plr) ~= "Instance" then return end
		local PlayerName = tostring(plr.Name)
		local PlayerName = string.lower(PlayerName)
		local currentAdminDataStore = AdmindsDataStore:GetAsync(1)
		local currentTempAdminDataStore = TempAdmindsDataStore:GetAsync(1)
		local PlayerPurchasedRank = CheckAdmin.PurchasedRank(plr)
		
		if table.find(HeadAdmins, plr.UserId) 
			or table.find(HeadAdmins, PlayerName)
			or PlayerPurchasedRank == 3 
			or plr.UserId == game.CreatorId then
			return 3
		elseif table.find(Settings.Admins, plr.UserId) 
			or table.find(Settings.Admins, PlayerName)
			or PlayerPurchasedRank == 2 then
			return 2
		elseif Settings.freeAdmin == true 
			or table.find(Settings.Temp_Admins, plr.UserId) 
			or table.find(Settings.Temp_Admins, PlayerName) 
			or PlayerPurchasedRank == 1 then 
			return 1
		else
			return 0
		end
	end
}

function ParseMessage(Player, Message)
	print(Settings.Admins)
	local Rank = CheckAdmin.AdminRank(Player)
	if Message:sub(1,#Settings.prefix) == Settings.prefix then
		local CommandString = Parser.get_command(Message)
		
		local function Command()
			--print(CommandString, CommandHandler[CommandString])
			CommandHandler[CommandString][1](Player,
				{
					CommandHandler[CommandString].args[1](Message),
					CommandHandler[CommandString].args[2](Message),
					CommandHandler[CommandString].args[3](Message)
				}
			)
		end
		
		if table.find(PowerUserSettings.server.CommandHandler.enabled_commands, CommandString) == nil then
			game.ReplicatedStorage.Events_.Notification:FireClient(Player, "Error attempting to run command that is disabled or does not exist.")
			return "fail" 
		end
		if Rank == 3 then
			Command()
		elseif Rank == 2 then
			if table.find(Settings.Admin_Commands, Parser.get_command(CommandString)) then
				Command()
			end
		elseif Rank == 1 then
			if table.find(Settings.Temp_AdminCommands, Parser.get_command(CommandString)) then
				Command()
			end
		end
	end
end

local function DoPlayer(Player)
	local PlayerPurchasedRank = CheckAdmin.PurchasedRank(Player)
	
	if script.Parent.PrivateServer.Value == true then
		if not CheckAdmin.IsAdmin(Player) then
			Player:Kick("This server is locked to Admins only.")
		end
	end
	
	local Success, Error = pcall(function()
		if BansDataStore:GetAsync(Player.UserId) then
			if BansDataStore:GetAsync(Player.UserId)[2] == true then
				Player:Kick("You are banned from this game for: " ..
				 (BansDataStore:GetAsync(Player.UserId)[1] or "unspecified"))
			end
		end
		if table.find(Settings.BanLand, Player.Name)
			or table.find(Settings.BanLand, Player.UserId) then 
			Player:Kick("You are banned.")
		end
	end)
	if not Success then warn("Sword Admin (please report to developers): " .. Error) end
	
	if Settings.adminJoinMessage == true then
		if CheckAdmin.IsAdmin(Player) then
			game.ReplicatedStorage:WaitForChild("Events_").IsAdmin:FireClient(Player, tostring(CheckAdmin.AdminRank(Player)))
		end
	end

	Player.Chatted:Connect(function(Message)
		ParseMessage(Player, Message)
	end)
	
	game.ReplicatedStorage:WaitForChild("Events_").CommandBar.OnServerEvent:Connect(function(Player, Message)
		ParseMessage(Player, Message)
	end)
end

for _, v in pairs (game.Players:GetPlayers()) do 
	print("Player already exists: ", v.Name)
	DoPlayer(v)
end

game.Players.PlayerAdded:Connect(function(Player)
	DoPlayer(Player)
end)

game:BindToClose(function()
	print("Saving admins...")
	AdmindsDataStore:SetAsync(1, Settings.Admins)
	TempAdmindsDataStore:SetAsync(1, Settings.Temp_Admins)
	print("Saved admins.")
end)

game.Players.PlayerRemoving:Connect(function()
	print("Saving admins...")
	AdmindsDataStore:SetAsync(1, Settings.Admins)
	TempAdmindsDataStore:SetAsync(1, Settings.Temp_Admins)
	print("Saved admins.")
end)
