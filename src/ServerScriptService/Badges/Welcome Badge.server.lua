--BonBonBakery--
BadgetId = 4422739832223556 --put the code here

game.Players.PlayerAdded:connect(function(p)-- Do not change 
wait(.5) --How long the person stays to earn the badge
local b = game:GetService("BadgeService")-- Do not change 
b:AwardBadge(p.userId,BadgetId)-- Do not change
end)-- Do not change 
-- Time badge by rickymarckstadt