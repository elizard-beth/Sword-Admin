local Enabled = true	
local Player = game.Players.LocalPlayer

game.ReplicatedStorage:WaitForChild("Events_").Noclip.OnClientEvent:Connect(function()
	Enabled = not Enabled
	game.ReplicatedStorage.Events_.DisableFlight:Fire(Enabled)
	for _, v in pairs(game.Workspace:GetDescendants()) do wait()
		if v:IsA("BasePart") then
			print(v.Name)
			v.CanCollide = Enabled
		end
	end
end)
