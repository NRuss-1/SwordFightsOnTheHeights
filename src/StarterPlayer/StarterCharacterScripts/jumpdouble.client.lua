local uis = game:GetService("UserInputService")
local character = script.Parent

local humanoid = character:FindFirstChild("Humanoid")

local doublejumpenabled = false
local extrajumps = 0

humanoid.StateChanged:Connect(function(_oldState, newState)
	if newState == Enum.HumanoidStateType.Jumping then
		if not doublejumpenabled then
			task.wait(0.2)
			if humanoid:GetState() == Enum.HumanoidStateType.Freefall then
				doublejumpenabled = true
			end
		end
	elseif newState == Enum.HumanoidStateType.Landed then
		doublejumpenabled = false
		extrajumps = 0
	end
end)

uis.InputBegan:Connect(function(inputObject)
	if inputObject.KeyCode == Enum.KeyCode.Space then
		if doublejumpenabled and extrajumps < 1 then
			if humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				task.spawn(function()
					doublejumpenabled = false
					extrajumps += 1
				end)
			end
		end
	end
end)

uis.InputBegan:Connect(function(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.Touch then
		if doublejumpenabled and extrajumps < 1 then
			if humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				task.spawn(function()
					doublejumpenabled = false
					extrajumps += 1
				end)
			end
		end
	end
end)