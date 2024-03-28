local UserInputService = game:GetService("UserInputService")
local ON = true
local db = true

script.Parent.MouseEnter:Connect(function()
	ON = true
	script.Parent.MouseButton1Down:Connect(function()
		ON = true
		if db == true then 
			db = false
			coroutine.wrap(function()
				local screenres = workspace.CurrentCamera.ViewportSize
				while true do wait()
					if ON == false then db = true break end
					local Vector = game:GetService("UserInputService"):GetMouseLocation()
					script.Parent.Parent.Parent.Position = UDim2.new(
						(Vector.X / screenres.X),
						-100,
						0,
						Vector.Y - 10 
					)
					db = true
				end
			end)()	
		end
	end)

	script.Parent.MouseButton1Click:Connect(function() 
		if ON == true then
			ON = false
		end
	end)
end)


script.Parent.MouseButton1Up:Connect(function()
	ON = false
end)
