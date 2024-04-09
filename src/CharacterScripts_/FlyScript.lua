-- adapted from https://create.roblox.com/store/asset/11228653710/

local BodyVelocity = script:WaitForChild("BodyVelocity"):Clone()
local BGyro = script.BodyGyro:Clone()
local Character = script.Parent
local Humanoid = Character:FindFirstChild("Humanoid") or Character:WaitForChild("Humanoid")
BodyVelocity.Parent = Character

local Camera = game.Workspace.Camera
local function u2()
	if Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
		return Humanoid.MoveDirection
	end
	local v12 = (Camera.CFrame * CFrame.new((CFrame.new(Camera.CFrame.p, Camera.CFrame.p + Vector3.new(Camera.CFrame.lookVector.x, 0, Camera.CFrame.lookVector.z)):VectorToObjectSpace(Humanoid.MoveDirection)))).p - Camera.CFrame.p;
	if v12 == Vector3.new() then
		return v12
	end
	return v12.unit
end

local Flymoving = script.Flymoving
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Flying = false

game:GetService("RunService").RenderStepped:Connect(function()
	if script.Parent == Character then
		if Flying == true then
			Humanoid:ChangeState(6)
			BGyro.CFrame = game.Workspace.Camera.CFrame
			if u2() == Vector3.new(0, 0, 0) then
				Flymoving.Value = false
			else
				Flymoving.Value = true
			end
			TweenService:Create(BodyVelocity, TweenInfo.new(0.3), {Velocity = u2() * 85}):Play()
		end

	end
end)

Flymoving.Changed:Connect(function(p1)
	if p1 == true then
		TweenService:Create(Camera, TweenInfo.new(0.5), {FieldOfView = 100}):Play()
		return
	end
	if p1 == false then
		TweenService:Create(Camera, TweenInfo.new(0.5), {FieldOfView = 70}):Play()
	end
end)

game.ReplicatedStorage:WaitForChild("Events_").Flight.OnClientEvent:Connect(function()
	if Flying == false then
		Flying = true
		if Character:FindFirstChild("HumanoidRootPart") then
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
			Character.HumanoidRootPart.Running.Volume = 0
			Humanoid:ChangeState(6)
			BodyVelocity.Parent = Character.HumanoidRootPart
			BGyro.Parent = Character.HumanoidRootPart
		end
	else
		Flying = false
		Flymoving.Value = false
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
		Character.HumanoidRootPart.Running.Volume = 0.65
		Humanoid:ChangeState(8)
		BodyVelocity.Parent = Character
		BGyro.Parent = Character
	end
end)
