local ServerStorage = game:GetService("ServerStorage")

local sword = script.Parent.Ghostwalker

local othersword = game.ServerStorage.Backups.Ghostwalker

local stand = script.Parent

local function taken()
	if sword.Parent ~= stand then
		print("Sword Taken")
		task.wait(30)
		local backup = othersword:Clone()
		sword = backup:Clone()
		sword.Parent = stand
		print("Replaced")
	elseif sword.Parent == stand then
		return
	end
end

stand.ChildRemoved:Connect(taken)