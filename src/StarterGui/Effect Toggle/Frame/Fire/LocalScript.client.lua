local player = game.Players.LocalPlayer
local body = player.Character:WaitForChild("Torso")

script.Parent.MouseButton1Click:Connect(function()
	local effect = body.Flames
	
	if effect == nil then
		return
	end
	
	if effect.Enabled == false then
		effect.Enabled = true
	elseif effect.Enabled == true then
		effect.Enabled = false
	end
end)