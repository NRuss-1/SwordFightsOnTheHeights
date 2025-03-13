local tool = script.Parent
local player = tool.Parent
local paper = player:FindFirstChild("jumpdouble")

tool.Equipped:Connect(function()
	paper.Enabled = true
end)

tool.Unequipped:Connect(function()
	paper.Enabled = false
end)