local ServerStorage = game:GetService("ServerStorage")

local sword = script.Parent["Bloxy Cola"]

local othersword = game.ServerStorage.PBackups["Bloxy Cola"]

local stand = script.Parent

local function taken()
	if sword.Parent ~= stand then
		print("Cola Taken")
		task.wait(60)
		local backup = othersword:Clone()
		sword = backup:Clone()
		sword.Parent = stand
		print("Replaced")
	elseif sword.Parent == stand then
		return
	end
end

stand.ChildRemoved:Connect(taken)