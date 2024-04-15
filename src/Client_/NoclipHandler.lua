local Enabled = false	
local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local CC = workspace.CurrentCamera

game.ReplicatedStorage:WaitForChild("Events_").Noclip.OnClientEvent:Connect(function()
	Enabled = not Enabled 
	game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Anchored = Enabled
	game.Players.LocalPlayer.Character:WaitForChild("Humanoid").PlatformStand = Enabled
	
	while true do 
		if Enabled == false then break end 
		task.wait()
		local Player = game.Players.LocalPlayer
		local Character = Player.Character or Player.CharacterAdded:Wait() 
		local Humanoid = Character:WaitForChild("Humanoid")
		local HRP = Character:WaitForChild("HumanoidRootPart")
		local LV = (CC.Focus.Position - CC.CFrame.Position).Unit
		local movement = function() 
			-- adapted from https://create.roblox.com/store/asset/6401259257/Noclip-Tool
			local nextMove = Vector3.new(0,0,0)
			if UIS:IsKeyDown(Enum.KeyCode.W) then
				nextMove = nextMove + Vector3.new(0,0,-1)
			end
			if UIS:IsKeyDown(Enum.KeyCode.S) then
				nextMove = nextMove + Vector3.new(0,0,1)
			end
			if UIS:IsKeyDown(Enum.KeyCode.A) then
				nextMove = nextMove + Vector3.new(-1,0,0)
			end
			if UIS:IsKeyDown(Enum.KeyCode.D) then
				nextMove = nextMove + Vector3.new(1,0,0)
			end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				nextMove = nextMove + Vector3.new(0,1,0)
			elseif UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
				nextMove = nextMove + Vector3.new(0,-1,0)
			end

			return CFrame.new(nextMove * 1.5)
		end

		HRP.CFrame = CFrame.new(HRP.Position, HRP.Position + LV) * movement()
	end
end)
