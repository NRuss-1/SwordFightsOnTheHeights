local player = game.Players.LocalPlayer
local pack = player.Backpack
local char = player.Character
local swords = {"LinkedSword","Darkheart","Illumina","Ghostwalker","Venomshank","Firebrand","Ice Dagger","Sky Dagger","Hyacinth","Earthsplitter","Windforce"}
local swordcollector = 1205322244026987
local collectedswords = {}

pack.ChildAdded:Connect(function()
	
	for i, child in pairs(pack:GetChildren()) do
		if child:IsA("Tool") then
			for i, v in pairs(swords) do
				if child.Name == v then
					table.insert(collectedswords, child.Name)
				end
			end
		end
	end
	
	for i, child in pairs(char:GetChildren()) do
		if child:IsA("Tool") then
			for i, v in pairs(swords) do
				if child.Name == v then
					table.insert(collectedswords, child.Name)
				end
			end
		end
	end
	
	if collectedswords == swords then
		print("Swords Collected")
		game:GetService("BadgeService"):AwardBadge(player.UserId, swordcollector)
	end
	
end)