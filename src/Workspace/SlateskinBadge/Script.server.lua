local badgeID = 1482853721456844 -- Change this ID YOUR badge ID
local badgeService = game:GetService("BadgeService")

script.Parent.Touched:Connect(function(hit)

	if hit.Parent:FindFirstChild("Humanoid") then

		local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
		badgeService:AwardBadge(plr.UserId, badgeID)
	end
end)