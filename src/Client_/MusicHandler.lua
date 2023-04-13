game.ReplicatedStorage:WaitForChild("Events_").Music.OnClientEvent:Connect(function(id)
	local ClientLocation = game.Players.LocalPlayer.PlayerGui.Client_
	ClientLocation.Music.SoundId = id
	ClientLocation.Music:Play()
end)
