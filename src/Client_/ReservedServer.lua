local TeleportService = game:GetService("TeleportService")
local TeleportData = TeleportService:GetLocalPlayerTeleportData()

pcall(function()
	if TeleportData:find("SENT_FROM_ADMIN") then
		wait(2)
		game.ReplicatedStorage.Events_.Teleport:FireServer(TeleportData:sub(16))
	end
end)
