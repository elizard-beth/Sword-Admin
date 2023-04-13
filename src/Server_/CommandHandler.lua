-- 'the script that brings it all together' - me
-- very large, not recommended to open with syntax
-- highlighting enabled

local Commands = {
	kill = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character:WaitForChild("Humanoid").Health = 0;
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character:WaitForChild("Humanoid").Health = 0;
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character:WaitForChild("Humanoid").Health = 0;
					break
				end
			end
		end
	end,
	
	tp = function(Player, Target, Target2)
		game.ReplicatedStorage.Events_.Notification:FireClient(Player, "Warning: Legacy command, executing in 3 seconds...")
		wait(3)
		workspace[Target].Character.HumanoidRootPart.CFrame = 
			workspace[Target2].Character.HumanoidRootPart.CFrame
	end,
	
	gear = function(Player, Target, Target2)
		local InsertService = game:GetService("InsertService")
		Target2 = tonumber(Target2)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			local Gear = InsertService:LoadAsset(Target2)
			Gear.Parent = Player.Character
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				local Gear = InsertService:LoadAsset(Target2)
				Gear.Parent = Play.Character
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					local Gear = InsertService:LoadAsset(Target2)
					Gear.Parent = player.Character
					break
				end
			end
		end
	end,
	
	leaderstat = function(Player, Target, Target2, Target3)
		Target3 = tonumber(Target3) or Target3
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player["leaderstats"][Target2].Value = Target3
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play["leaderstats"][Target2].Value = Target3
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player["leaderstats"][Target2].Value = Target3
					break
				end
			end
		end
	end,
	
	sword = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			game.ReplicatedStorage.Assets.ClassicSword:Clone().Parent = Player.Character
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				game.ReplicatedStorage.Assets.ClassicSword:Clone().Parent = Play.Character
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					game.ReplicatedStorage.Assets.ClassicSword:Clone().Parent = player.Character
					break
				end
			end
		end
	end,

	faceless = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.Head.face:Destroy()
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.Head.face:Destroy()
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.Head.face:Destroy()
					break
				end
			end
		end
	end,

	headless = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.Head.Transparency = 1
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.Head.Transparency = 1
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.Head.Transparency = 1
					break
				end
			end
		end
	end,

	privateserver = function()
		game.ServerScriptService.Server_.PrivateServer.Value = true
		
		local Settings = require(game:FindFirstChild("Sword_Admin" , true).Settings)
		local HeadAdmins = Settings.Head_Admins
		local AdmindsDataStore = game:GetService("DataStoreService"):GetDataStore("Admins_s")
		local TempAdmindsDataStore = game:GetService("DataStoreService"):GetDataStore("TAdmins_s")
		local BansDataStore = game:GetService("DataStoreService"):GetDataStore("Bans_s")
		local MarketPlaceService = game:GetService("MarketplaceService")
		
		for _, Player in pairs(game.Players:GetPlayers()) do
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
	end,

	invisible = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			for _, b in ipairs(Player.Character.Humanoid:GetAccessories()) do
				b:Destroy()
			end		
			Player.Character.Head.face.Transparency = 1
			for _, v in ipairs(Player.Character:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency = 1
				end
			end
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				for _, b in ipairs(Play.Character.Humanoid:GetAccessories()) do
					b:Destroy()
				end		
				Play.Character.Head.face.Transparency = 1
				for _, v in ipairs(Play.Character:GetChildren()) do
					if v:IsA("BasePart") then
						v.Transparency = 1
					end
				end
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					for _, b in ipairs(player.Character.Humanoid:GetAccessories()) do
						b:Destroy()
					end		
					player.Character.Head.face.Transparency = 1
					for _, v in ipairs(player.Character:GetChildren()) do
						if v:IsA("BasePart") then
							v.Transparency = 1
						end
					end
					break
				end
			end
		end
	end,

	visible = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.Head.face.Transparency = 0
			for _, v in ipairs(Player.Character:GetChildren()) do
				if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
					v.Transparency = 0
				end
			end
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.Head.face.Transparency = 0
				for _, v in ipairs(Play.Character:GetChildren()) do
					if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart"  then
						v.Transparency = 0
					end
				end
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.Head.face.Transparency = 0
					for _, v in ipairs(player.Character:GetChildren()) do
						if v:IsA("BasePart")  and v.Name ~= "HumanoidRootPart" then
							v.Transparency = 0
						end
					end
					break
				end
			end
		end
	end,

	admin = function(Player, Target)
		for _, player in pairs(game.Players:GetPlayers()) do
			if Target == player.Name:sub(1,#Target):lower() then
				local AdmindsDataStore = game:GetService("DataStoreService"):GetDataStore("Admins_s")
				local Current = AdmindsDataStore:GetAsync(1)
				if not table.find(Current, player.UserId) then
					table.insert(Current, player.UserId)
					AdmindsDataStore:SetAsync(1, Current)
				end
				break
			end
		end
	end,

	unadmin = function(Player, Target)
		for _, player in pairs(game.Players:GetPlayers()) do
			if Target == player.Name:sub(1,#Target):lower() then
				local AdmindsDataStore = game:GetService("DataStoreService"):GetDataStore("Admins_s")
				local Current = AdmindsDataStore:GetAsync(1)
				if table.find(Current, player.UserId) then
					table.remove(Current, table.find(Current, player.UserId))
					AdmindsDataStore:SetAsync(1, Current)
				end
				if table.find(Current, player.Name) then
					table.remove(Current, table.find(Current, player.Name))
					AdmindsDataStore:SetAsync(1, Current)
				end
				break
			end
		end
	end,
	
	tempadmin = function(Player, Target)
		for _, player in pairs(game.Players:GetPlayers()) do
			if Target == player.Name:sub(1,#Target):lower() then
				local TempAdmindsDataStore = game:GetService("DataStoreService"):GetDataStore("TAdmins_s")
				local Current = TempAdmindsDataStore:GetAsync(1)
				if not table.find(Current, player.UserId) then
					table.insert(Current, player.UserId)
					TempAdmindsDataStore:SetAsync(1, Current)
				end
				break
			end
		end
	end,

	untempadmin = function(Player, Target)
		for _, player in pairs(game.Players:GetPlayers()) do
			if Target == player.Name:sub(1,#Target):lower() then
				local TempAdmindsDataStore = game:GetService("DataStoreService"):GetDataStore("TAdmins_s")
				local Current = TempAdmindsDataStore:GetAsync(1)
				if table.find(Current, player.UserId) then
					table.remove(Current, table.find(Current, player.UserId))
					TempAdmindsDataStore:SetAsync(1, Current)
				end
				if table.find(Current, player.Name) then
					table.remove(Current, table.find(Current, player.Name))
					TempAdmindsDataStore:SetAsync(1, Current)
				end
				break
			end
		end
	end,
	
	ban = function(Player, Target)
		for _, player in pairs(game.Players:GetPlayers()) do
			if Target == player.Name:sub(1,#Target):lower() then
				local BansDataStore = game:GetService("DataStoreService"):GetDataStore("Bans_s")
				local Current = BansDataStore:GetAsync(1)
				if not table.find(Current, player.UserId) then
					table.insert(Current, player.UserId)
					BansDataStore:SetAsync(1, Current)
				end
				player:Kick()
				break
			end
		end
	end,
	
	unban = function(Player, Target)
		for _, player in pairs(game.Players:GetPlayers()) do
			if Target == player.Name:sub(1,#Target):lower() then
				local BansDataStore = game:GetService("DataStoreService"):GetDataStore("Bans_s")
				local Current = BansDataStore:GetAsync(1)
				if table.find(Current, player.UserId) then
					table.remove(Current, table.find(Current, player.UserId))
					BansDataStore:SetAsync(1, Current)
				end
				if table.find(Current, player.Name) then
					table.remove(Current, table.find(Current, player.Name))
					BansDataStore:SetAsync(1, Current)
				end
				break
			end
		end
	end,

	fire = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			local Fire = Instance.new("Fire")
			Fire.Parent = Player.Character.Head
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				local Fire = Instance.new("Fire")
				Fire.Parent = Play.Character.Head
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					local Fire = Instance.new("Fire")
					Fire.Parent = player.Character.Head
					break
				end
			end
		end
	end,

	smoke = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			local Smoke = Instance.new("Smoke")
			Smoke.Parent = Player.Character.Head
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				local Smoke = Instance.new("Smoke")
				Smoke.Parent = Play.Character.Head
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					local Smoke = Instance.new("Smoke")
					Smoke.Parent = player.Character.Head
					break
				end
			end
		end
	end,

	sparkles = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			local Sparkles = Instance.new("Sparkles")
			Sparkles.Parent = Player.Character.Head
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				local Sparkles = Instance.new("Sparkles")
				Sparkles.Parent = Play.Character.Head
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					local Sparkles = Instance.new("Sparkles")
					Sparkles.Parent = player.Character.Head
					break
				end
			end
		end
	end,

	hipheight = function(Player, Target, Target2)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.Humanoid.HipHeight = tonumber(Target2)
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.Humanoid.HipHeight = tonumber(Target2)
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.Humanoid.HipHeight = tonumber(Target2)
					break
				end
			end
		end
	end,
	
	btools = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			local Clone = game.ReplicatedStorage.Assets_["Building Tools"]:Clone()
			Clone.Parent = Player.Backpack
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				local Clone = game.ReplicatedStorage.Assets_["Building Tools"]:Clone()
				Clone.Parent = Play.Backpack
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					local Clone = game.ReplicatedStorage.Assets_["Building Tools"]:Clone()
					Clone.Parent = player.Backpack
					break
				end
			end
		end
	end,
	
	jail = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			local Jail = game.Workspace:FindFirstChild(Player.Name .. " Jail")
			if Jail then
				Jail:Destroy()
			end

			local Jail = game.ReplicatedStorage.Assets_.Jail:Clone()
			Player.RespawnLocation = Jail.tp
			Jail:SetPrimaryPartCFrame(Player.Character.HumanoidRootPart.CFrame)
			Jail.Name = Player.Name .. " Jail"
			Jail.Parent = workspace
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				local Jail = game.Workspace:FindFirstChild(Play.Name .. " Jail")
				if Jail then
					Jail:Destroy()
				end

				local Jail = game.ReplicatedStorage.Assets_.Jail:Clone()
				Play.RespawnLocation = Jail.tp
				Jail:SetPrimaryPartCFrame(Play.Character.HumanoidRootPart.CFrame)
				Jail.Name = Play.Name .. " Jail"
				Jail.Parent = workspace
				break
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					local Jail = game.Workspace:FindFirstChild(player.Name .. " Jail")
					if Jail then
						Jail:Destroy()
					end

					local Jail = game.ReplicatedStorage.Assets_.Jail:Clone()
					player.RespawnLocation = Jail.tp
					Jail:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame)
					Jail.Name = player.Name .. " Jail"
				end
			end

		end
	end,

	unjail = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			local Jail = game.Workspace:FindFirstChild(Player.Name .. " Jail")
			if Jail then
				Jail:Destroy()
			end
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				local Jail = game.Workspace:FindFirstChild(Play.Name .. " Jail")
				if Jail then
					Jail:Destroy()
				end
				break
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					local Jail = game.Workspace:FindFirstChild(player.Name .. " Jail")
					if Jail then
						Jail:Destroy()
					end
				end
			end

		end
	end,

	blind = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			if not Player.PlayerGui:FindFirstChild("Blind") then
				local Blind = game.ReplicatedStorage.Assets_.Blind:Clone()
				Blind.Parent = Player.PlayerGui
			end
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				if not Play.PlayerGui:FindFirstChild("Blind") then
					local Blind = game.ReplicatedStorage.Assets_.Blind:Clone()
					Blind.Parent = Play.PlayerGui
				end
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					local Blind = game.ReplicatedStorage.Assets_.Blind:Clone()
					Blind.Parent = player.PlayerGui
					break
				end
			end
		end
	end,
	
	unblind = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			if Player.PlayerGui:FindFirstChild("Blind") then
				Player.PlayerGui.Blind:Destroy()
			end
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				if Play.PlayerGui:FindFirstChild("Blind") then
					Play.PlayerGui.Blind:Destroy()
				end
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.PlayerGui.Blind:Destroy()
					break
				end
			end
		end
	end,

	brightness = function(Player, Target)
		game.Lighting.Brightness = tonumber(Target) or 2
	end,

	noclip = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			game.ReplicatedStorage.Events_.Noclip:FireClient(Player)
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				game.ReplicatedStorage.Events_.Noclip:FireClient(Play)
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					game.ReplicatedStorage.Events_.Noclip:FireClient(player)
				end
			end
		end
	end,
	
	countdown = function(Player, Target)
		if tonumber(Target) < 200 then 
			game.ReplicatedStorage.Events_.Countdown:FireAllClients(Player.Name, tonumber(Target))
		else
			game.ReplicatedStorage.Events_.Notification:FireClient(Player, "Error: Value cannot be higher than 200.")
		end
	end,

	msg = function(Player, Target)
		local TextService = game:GetService("TextService")
		Target = TextService:FilterStringAsync(Target, Player.UserId)
		Target = Target:GetNonChatStringForBroadcastAsync()
		game.ReplicatedStorage.Events_.Message:FireAllClients(Player.Name, Target)
	end,
	
	music = function(Player, Target)
		game.ReplicatedStorage.Events_.Music:FireAllClients(tonumber(Target))
	end,

	fly = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			game.ReplicatedStorage.Events_.Flight:FireClient(Player)
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				game.ReplicatedStorage.Events_.Flight:FireClient(Play)
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					game.ReplicatedStorage.Events_.Flight:FireClient(player)
				end
			end
		end
	end,

	explode = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			local Explosion = Instance.new("Explosion")
			Explosion.Position = Player.Character.Head.Position
			Explosion.Parent = Player.Character.Head
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				local Explosion = Instance.new("Explosion")
				Explosion.Position = Play.Character.Head.Position
				Explosion.Parent = Play.Character.Head
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					local Explosion = Instance.new("Explosion")
					Explosion.Position = player.Character.Head.Position
					Explosion.Parent = player.Character.Head
					break
				end
			end
		end
	end,

	rejoin = function(Player, Target)
		local TeleportService = game:GetService("TeleportService")
		local ServerCode = TeleportService:ReserveServer(game.PlaceId)
		local PlayertoTP = game.Players:FindFirstChild(Target or Player.Name) 
		if PlayertoTP then 
			TeleportService:TeleportToPrivateServer(
				game.PlaceId, 
				ServerCode, 
				{PlayertoTP}, 
				nil, 
				"SENT_FROM_ADMIN" .. game.JobId
			)
		end
	end,

	cmds = function(Player)
		game.ReplicatedStorage.Events_.Commands:FireClient(Player)
	end,

	commands = function(Player)
		game.ReplicatedStorage.Events_.Commands:FireClient(Player)
	end,
	
	shutdownserver = function(Player)
		for _, v in pairs(game.Players:GetPlayers()) do
			game.ReplicatedStorage.Events_.Notification:FireClient(v, "Server shutting down soon...")
		end
		wait(4)
		for _, v in pairs(game.Players:GetPlayers()) do
			v:Kick("Server shutdown by: " .. Player.Name)
		end
	end,
	
	setgrav = function(Player, Target)
		game.Workspace.Gravity = tonumber(Target)
	end,
	
	require = function(Player, Target)
		require(tonumber(Target) or Target)
		print(Player.Name .. ' has required module: ' .. Target)
	end,
	
	kick = function (Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player:Kick()
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player:Kick()
					break
				end
			end
		end
	end,

	health = function(Player, Target, Target2)
		Target2 = tonumber(Target2)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			if Target2 > Player.Character:WaitForChild("Humanoid").Health then
				Player.Character:WaitForChild("Humanoid").MaxHealth = Target2;
			end
			Player.Character:WaitForChild("Humanoid").Health = Target2;
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				if Target2 > Play.Character:WaitForChild("Humanoid").Health then
					Play.Character:WaitForChild("Humanoid").MaxHealth = Target2;
				end
				Play.Character:WaitForChild("Humanoid").Health = Target2;
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					if Target2 > player.Character:WaitForChild("Humanoid").Health then
						player.Character:WaitForChild("Humanoid").MaxHealth = Target2;
					end
					player.Character:WaitForChild("Humanoid").Health = Target2;
					break
				end
			end
		end
	end,

	god = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character:WaitForChild("Humanoid").MaxHealth = math.huge;
			Player.Character:WaitForChild("Humanoid").Health = math.huge;
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character:WaitForChild("Humanoid").Max = math.huge;
				Play.Character:WaitForChild("Humanoid").Health = math.huge;
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character:WaitForChild("Humanoid").MaxHealth = math.huge;
					player.Character:WaitForChild("Humanoid").Health = math.huge;
					break
				end
			end
		end
	end,

	freeze = function(Player, Target, Target2)
		Target2 = tonumber(Target2)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.Humanoid.Anchored = true
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.Humanoid.Anchored = true
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.Humanoid.Anchored = true
					break
				end
			end
		end
	end,
	
	unfreeze = function(Player, Target, Target2)
		Target2 = tonumber(Target2)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.HumanoidRootPart.Anchored = false
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.HumanoidRootPart.Anchored = false
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.HumanoidRootPart.Anchored = false
					break
				end
			end
		end
	end,

	speed = function(Player, Target, Target2)
		Target2 = tonumber(Target2)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.Humanoid.Walkspeed = tonumber(Target2)
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.Humanoid.Walkspeed = tonumber(Target2)
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.Humanoid.Walkspeed = tonumber(Target2)
					break
				end
			end
		end
	end,
	
	jumppower = function(Player, Target, Target2)
		Target2 = tonumber(Target2)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.Humanoid.JumpPower = tonumber(Target2)
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.Humanoid.JumpPower = tonumber(Target2)
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.Humanoid.JumpPower = tonumber(Target2)
					break
				end
			end
		end
	end,
	
	ff = function (Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			local ff = Instance.new("ForceField")
			ff.Parent = Player.Character
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				local ff = Instance.new("ForceField")
				ff.Parent = Play.Character
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					local ff = Instance.new("ForceField")
					ff.Parent = player.Character					
					break
				end
			end
		end
	end,

	unff = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			pcall(function() Player.Character.ForceField:Destroy() end)
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				pcall(function() Play.Character.ForceField:Destroy() end)
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					pcall(function() player.Character.ForceField:Destroy() end)					
					break
				end
			end
		end
	end,

	sit = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.Humanoid.Sit = true
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.Humanoid.Sit = true
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.Humanoid.Sit = true
					break
				end
			end
		end
	end,

	unsit = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.Humanoid.Sit = false
		elseif Target == "all" then
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.Humanoid.Sit = false
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.Humanoid.Sit = false
					break
				end
			end
		end
	end,

	char = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.CharacterAppearanceId = tonumber(Target)
			Player:LoadCharacter()
		elseif Target == "all" then 
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.CharacterAppearanceId = tonumber(Target)
				Play:LoadCharacter()
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.CharacterAppearanceId = tonumber(Target)
					player:LoadCharacter()
					break
				end
			end
		end
	end,
	
	clone = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			Player.Character.Archivable = true
			local NewCharacter = Player.Character:Clone()
			NewCharacter.Name = Player.Name .. "_"
			NewCharacter.Parent = workspace
		elseif Target == "all" then 
			for _, Play in pairs(game.Players:GetPlayers()) do
				Play.Character.Archivable = true
				local NewCharacter = Play.Character:Clone()
				NewCharacter.Name = Play.Name .. "_"
				NewCharacter.Parent = workspace
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					player.Character.Archivable = true
					local NewCharacter = player.Character:Clone()
					NewCharacter.Name = player.Name .. "_"
					NewCharacter.Parent = workspace
					break
				end
			end
		end
	end,
	
	print = function(Player, Target)
		print("From " .. Player.Name .. ": " .. Target)
	end,
	
	fling = function(Player, Target)
		if (Player.Name == Target) or (Target == "me") or (Target == nil) then
			coroutine.wrap(function()
				local Velocity = Instance.new("BodyVelocity")
				Velocity.Velocity = Vector3.new(9999999,99999999,99999999)					
				Velocity.Parent = Player.Character.HumanoidRootPart
				Player.Character.Humanoid.Jump = true
				wait(5)
				Velocity:Destroy()
			end)()
		elseif Target == "all" then 
			for _, Play in pairs(game.Players:GetPlayers()) do
				coroutine.wrap(function()
					local Velocity = Instance.new("BodyVelocity")
					Velocity.Velocity = Vector3.new(9999999,99999999,99999999)
					Velocity.Parent = Play.Character.HumanoidRootPart
					Play.Character.Humanoid.Jump = true
					wait(5)
					Velocity:Destroy()
				end)()
			end
		else
			for _, player in pairs(game.Players:GetPlayers()) do
				if Target == player.Name:sub(1,#Target):lower() then
					coroutine.wrap(function()
						local Velocity = Instance.new("BodyVelocity")
						Velocity.Velocity = Vector3.new(9999999,99999999,99999999)					
						Velocity.Parent = player.Character.HumanoidRootPart
						player.Character.Humanoid.Jump = true
						wait(5)
						Velocity:Destroy()
					end)()
					break
				end
			end
		end
	end,
	
}

return Commands
