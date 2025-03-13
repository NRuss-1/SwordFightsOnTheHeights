local pass = 946128551
local market = game:GetService("MarketplaceService")
local holster = script.HipHolster


game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if market:UserOwnsGamePassAsync(Player.UserId, pass) then
			local clone = holster:Clone()
			clone.Enabled = true
			clone.Parent = Player.Backpack.LinkedSword
		end
		if Player.UserId == 9626586 then
			local clone = holster:Clone()
			clone.Enabled = true
			clone.Parent = Player.Backpack.LinkedSword
		end
	end)
end)