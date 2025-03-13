local darklightningpass = 946388617
local flamespass = 946286669
local lightningpass = 946534508
local starpass = 946572395
local market = game:GetService("MarketplaceService")
local darklightning = script.DarkLightning
local flames = script.Flames
local lightning = script.Lightning
local stars = script.Stars


game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if market:UserOwnsGamePassAsync(Player.UserId, darklightningpass) then
			local body = Character:WaitForChild("Torso")
			local darklightningc = darklightning:Clone()
			darklightningc.Parent = body
		end
		if market:UserOwnsGamePassAsync(Player.UserId, lightningpass) then
			local body = Character:WaitForChild("Torso")
			local lightningc = lightning:Clone()
			lightningc.Parent = body
		end
		if market:UserOwnsGamePassAsync(Player.UserId, flamespass) then
			local body = Character:WaitForChild("Torso")
			local flamesc = flames:Clone()
			flamesc.Parent = body
		end
		if market:UserOwnsGamePassAsync(Player.UserId, starpass) then
			local body = Character:WaitForChild("Torso")
			local starsc = stars:Clone()
			starsc.Parent = body
		end
		if market:UserOwnsGamePassAsync(Player.UserId, darklightningpass or lightningpass or flamespass or starpass) then
			Player.PlayerGui["Effect Toggle"].Enabled = true
		end
	end)
end)