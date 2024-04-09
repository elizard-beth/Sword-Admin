--[[local UserInputService = game:GetService("UserInputService")
local ON = true
local db = true
script.Parent.MouseEnter:Connect(function()
	ON = true
	script.Parent.MouseButton1Down:Connect(function()
		if db == true then 
			db = false
			coroutine.wrap(function()
				while true do wait()
					if ON == false then break end
					local Vector = game:GetService("UserInputService"):GetMouseLocation()
					script.Parent.Position = UDim2.new(0, Vector.X - 50, 0, Vector.Y - 50)
					script.Parent.Parent.ScrollingFrame.Position = UDim2.new(
						0,
						script.Parent.Position.X.Offset,
						0,
						script.Parent.Position.Y.Offset + 30.5
					)
					db = true
				end
			end)()	
		end
	end)
	
	script.Parent.MouseLeave:Connect(function()
		ON = false
	end)
	
	script.Parent.MouseButton1Click:Connect(function() 
		if ON == true then
			ON = false
		end
	end)
end)--]]
local UserInputService = game:GetService("UserInputService")
local ON = true
local db = true
script.Parent.MouseEnter:Connect(function()
	ON = true
	script.Parent.MouseButton1Down:Connect(function()
		if db == true then 
			db = false
			coroutine.wrap(function()
				local screenres = workspace.CurrentCamera.ViewportSize
				while true do wait()
					if ON == false then db = true break end
					local Vector = game:GetService("UserInputService"):GetMouseLocation()						
					script.Parent.Position = UDim2.new( 
						(Vector.X / screenres.X) - 0.1,
						0,
						0,
						Vector.Y - (game:GetService("GuiService").TopbarInset.Height + 7)
					)
					script.Parent.Parent.ScrollingFrame.Position = UDim2.new(
						script.Parent.Position.X.Scale, 
						script.Parent.Position.X.Offset,
						script.Parent.Position.Y.Scale + 0.05,
						script.Parent.Position.Y.Offset
					)
					db = true
				end
			end)()	
		end
	end)
	script.Parent.MouseLeave:Connect(function()
		ON = false
	end)
	script.Parent.MouseButton1Click:Connect(function() 
		if ON == true then
			ON = false
		end
	end)
end)
