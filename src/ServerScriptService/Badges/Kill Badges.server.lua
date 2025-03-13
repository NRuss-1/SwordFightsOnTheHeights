local players = game:GetService("Players")
local badgeService = game:GetService("BadgeService")
local badge98Kills = 926079016120488
local badge5kills = 2060225850004420
local badge25kills = 793637326138221
local badgeapprentice = 1677429071114267
local badgemaster = 593998067358654

players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local kills = Instance.new("IntValue")
	kills.Name = "Kills"
	kills.Value = 0
	kills.Parent = leaderstats

	local deaths = Instance.new("IntValue")
	deaths.Name = "Deaths"
	deaths.Value = 0
	deaths.Parent = leaderstats

	kills.Changed:Connect(function(newVal)
		if newVal >= 5 then
			if badgeService:UserHasBadgeAsync(player.UserId, badge5kills) then
				print("User has badge already!")
			else
				badgeService:AwardBadge(player.UserId, badge5kills)
				print("Badge awarded!")
			end
		end
		
		if newVal >= 25 then
			if badgeService:UserHasBadgeAsync(player.UserId, badge25kills) then
				print("User has badge already!")
			else
				badgeService:AwardBadge(player.UserId, badge25kills)
				print("Badge awarded!")
			end
		end
		
		if newVal >= 98 then
			if badgeService:UserHasBadgeAsync(player.UserId, badge98Kills) then
				print("User has badge already!")
			else
				badgeService:AwardBadge(player.UserId, badge98Kills)
				print("Badge awarded!")
			end
		end
	end)
	
	local function checkBadge()
		if kills.Value == 20 and deaths.Value == 0 then
			if badgeService:UserHasBadgeAsync(player.UserId, badgeapprentice) then
				print("User has badge already!")
			else
				badgeService:AwardBadge(player.UserId, badgeapprentice)
				print("Badge awarded!")
			end
		end
		
		if kills.Value == 50 and deaths.Value == 0 then
			if badgeService:UserHasBadgeAsync(player.UserId, badgemaster) then
				print("User has badge already!")
			else
				badgeService:AwardBadge(player.UserId, badgemaster)
				print("Badge awarded!")
			end
		end
	end

	kills.Changed:Connect(checkBadge)
end)