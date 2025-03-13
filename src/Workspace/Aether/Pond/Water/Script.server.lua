local water = script.Parent

water.Touched:Connect(function(hit)
	local bod = hit.Parent:FindFirstChild("Humanoid")
	if bod ~= nil then
		task.wait(3)
		bod.Health = bod.Health + 5
	elseif bod.Health == bod.MaxHealth then
		return
	end
end)