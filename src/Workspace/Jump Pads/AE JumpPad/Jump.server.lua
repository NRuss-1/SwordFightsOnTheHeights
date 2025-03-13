local jumper = script.Parent

local debounce = false

jumper.Touched:Connect(function(hit)

	if debounce then
		return
	end

	debounce = true
	
	task.delay(0.2, function() debounce = false end)

	local plr = hit.Parent
	local bod = plr:FindFirstChild("Humanoid")
	local tool = plr:FindFirstChildOfClass("Tool")
	
	if bod then
		if tool ~= nil and tool.ToolTip == "Ghostwalker" then
			bod.JumpPower = 80
			task.delay(0.5, function()
				bod.JumpPower = 50
			end)
		else
			bod.JumpPower = 155
			task.delay(0.5, function()
				bod.JumpPower = 50
			end)
		end
	end
	
	
end)