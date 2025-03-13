local player = game.Players.LocalPlayer
local body = player.Character:WaitForChild("Torso")

script.Parent.MouseButton1Click:Connect(function()
	local DL = body.DarkLightning
	
	if DL == nil then
		return
	end
	
	if DL.Enabled == false then
		DL.Enabled = true
	elseif DL.Enabled == true then
		DL.Enabled = false
	end
end)