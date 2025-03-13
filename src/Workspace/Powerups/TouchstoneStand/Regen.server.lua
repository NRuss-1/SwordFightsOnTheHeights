local ServerStorage = game:GetService("ServerStorage")

local sword = script.Parent.Touchstone

local othersword = game.ServerStorage.PBackups.Touchstone

local stand = script.Parent

local function taken()
	if sword.Parent ~= stand then
		print("Stone Taken")
		task.wait(45)
		local backup = othersword:Clone()
		sword = backup:Clone()
		sword.Parent = stand
		print("Replaced")
	elseif sword.Parent == stand then
		return
	end
end

stand.ChildRemoved:Connect(taken)