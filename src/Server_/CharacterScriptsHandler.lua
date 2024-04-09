game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		local Scripts = game.ReplicatedStorage:WaitForChild("CharacterScripts_")
		Scripts.FlyScript:Clone().Parent = Character
	end)
end)
