game.ReplicatedStorage:WaitForChild("Events_").Teleport.OnServerEvent:Connect(function(Player, ID)
	local TPOptions = Instance.new("TeleportOptions")
	TPOptions.ServerInstanceId = ID
	game:GetService("TeleportService"):TeleportAsync(game.PlaceId,{Player}, TPOptions)
	wait(5)
	game:GetService("TeleportService"):Teleport(game.PlaceId,Player)
end)
