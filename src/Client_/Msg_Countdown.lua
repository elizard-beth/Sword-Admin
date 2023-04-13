local PowerUserSettings = require(game.Workspace.Sword_Admin.Settings.PowerUserSettings).client.msgcountdown

game.ReplicatedStorage:WaitForChild("Events_").Message.OnClientEvent:Connect(function(Player, Message)
	local MessageLocation = game.Players.LocalPlayer.PlayerGui.ServerMessage
	MessageLocation.Frame.BackgroundTransparency = 0.3	
	MessageLocation.Frame.Frame.BackgroundTransparency = 0.3
	MessageLocation.Frame.ad.TextTransparency = 0
	MessageLocation.Frame.sender.TextTransparency = 0
	MessageLocation.Frame.msg.TextTransparency = 0
	
	MessageLocation.Frame.sender.Text = Player
	MessageLocation.Frame.msg.Text = Message
	MessageLocation.Frame.Visible = true
end)

game.ReplicatedStorage:WaitForChild("Events_").Countdown.OnClientEvent:Connect(function(Player, Number)
	if Number < PowerUserSettings.maxNum then 
		local MessageLocation = game.Players.LocalPlayer.PlayerGui.ServerMessage
		MessageLocation.Frame.sender.Text = Player
		MessageLocation.Frame.msg.Text = Number
		MessageLocation.Frame.Visible = true
		for i = Number,0,-1 do
			wait(1)
			MessageLocation.Frame.msg.Text = i
		end
		MessageLocation.Frame.Visible = false
	end
end)
