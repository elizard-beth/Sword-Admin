game.ReplicatedStorage:WaitForChild("Events_").Commands.OnClientEvent:Connect(function()
	script.Parent.ScrollingFrame:TweenPosition(
		UDim2.new(0.026, 0, 0.188, 0)
	)
	--{-1.01, 0},{0, 0}
	script.Parent.ImageButton:TweenPosition(
		UDim2.new(0.026, 0, 0.138, 0)
		                    
	)
	--{-1.01, 0},{0, 0}
end)
