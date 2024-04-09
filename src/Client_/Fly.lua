-- See: https://github.com/glorpglob/Sword-Admin/issues/1

local PowerUserSettings = require(game.Workspace.Sword_Admin.Settings.PowerUserSettings).client.fly
repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("HumanoidRootPart")
local UIS  = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer 
local HRP = plr.Character.HumanoidRootPart
local flying = false
local deb = true 
local ctrl = {f = 0, b = 0, l = 0, r = 0} 
local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
local maxspeed = 50 
local speed = 0 
function Fly() 
	local bg = Instance.new("BodyGyro", HRP) 
	bg.P = PowerUserSettings.bg.P 
	bg.maxTorque = PowerUserSettings.bg.maxTorque
	bg.cframe = HRP.CFrame 
	local bv = Instance.new("BodyVelocity", HRP)
	bv.velocity = PowerUserSettings.bv.velocity
	bv.maxForce = PowerUserSettings.bv.maxForce 
	repeat wait() 
		plr.Character.Humanoid.PlatformStand = true 
		if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
			speed = speed+.5+(speed/maxspeed) 
			if speed > maxspeed then 
				speed = maxspeed 
			end 
		elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 
			speed -= -1 
			if speed < 0 then 
				speed = 0 
			end 
		end 
		if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 
			bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).Position) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed 
			lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
		elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
			bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).Position) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed 
		else 
			bv.velocity = Vector3.new(0,0.1,0) 
		end 
		bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
	until not flying 
	ctrl = {f = 0, b = 0, l = 0, r = 0} 
	lastctrl = {f = 0, b = 0, l = 0, r = 0} 
	speed = 0 
	bg:Destroy() 
	bv:Destroy() 
	plr.Character.Humanoid.PlatformStand = false
end 
UIS.InputBegan:Connect(function(key)
	if UIS:IsKeyDown(Enum.KeyCode.W) then 
		while true do wait()
			if UIS:IsKeyDown(Enum.KeyCode.W) then
				ctrl.b = 0
				ctrl.f = 0.75
				--[[
				if ctrl.f == -1 then
					ctrl.f -= 0.05
				else
					ctrl.f += 0.05
				end
				
				if ctrl.f > 1.5 then 
					ctrl.f = 1.5
				end]]
			else
				--break
			end
		end
	elseif UIS:IsKeyDown(Enum.KeyCode.S)then 
		while true do wait()
			if UIS:IsKeyDown(Enum.KeyCode.S) then
				ctrl.f = 0
				ctrl.b = -0.7
				--[[if ctrl.b == 1 then
					ctrl.b += 0.05
				else
					ctrl.b -= 0.05
				end
				
				if ctrl.b < -1.5 then 
					ctrl.b = -1.5
				end]]
			else 
				--break
			end
		end
	elseif UIS:IsKeyDown(Enum.KeyCode.A) then 
		while true do wait()
			if UIS:IsKeyDown(Enum.KeyCode.A) then
				if ctrl.b == 1 then
					ctrl.l += 0.05
				else
					ctrl.l -= 0.05
				end
			else 
				break
			end
		end
	elseif UIS:IsKeyDown(Enum.KeyCode.D)then 
		while true do wait()
			if UIS:IsKeyDown(Enum.KeyCode.D) then
				if ctrl.r == -1 then
					ctrl.r -= 0.05
				else
					ctrl.r += 0.05
				end
			else 
				break
			end
		end
	elseif UIS:IsKeyDown(Enum.KeyCode.E) then
		speed = 0
		ctrl.l = 0
		ctrl.r = 0
		ctrl.f = 0
		ctrl.b = 0
	end 
end) 

plr.Character:WaitForChild("Humanoid").Died:Connect(function()
	flying = false
	Fly()
end)

game.ReplicatedStorage:WaitForChild("Events_").DisableFlight.Event:Connect(function(a)
	flying = not a
	Fly()
end)

game.ReplicatedStorage:WaitForChild("Events_").Flight.OnClientEvent:Connect(function()
	flying = not flying
	Fly()
end)

Fly()
