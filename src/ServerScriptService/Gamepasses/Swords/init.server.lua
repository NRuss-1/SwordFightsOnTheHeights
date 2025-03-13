local gwpass = 948556693
local dhpass = 948628553
local illuminapass = 948868362
local crimpass = 946733587
local goldpass = 947089383
local katpass = 947243173
local hammerpass = 946949444
local foilpass = 947305252
local market = game:GetService("MarketplaceService")
local ghostwalker = script.Ghostwalker
local darkheart = script.Darkheart
local illumina = script.Illumina
local hammer = script.ThorsHammer
local foil = script["Fencing Foil"]
local crimson = script["Crimson Katana"]
local golden = script["Gold Katana"]
local katana = script.Katana


game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if market:UserOwnsGamePassAsync(Player.UserId, gwpass) then
			local gclone = ghostwalker:Clone()
			gclone.Parent = Player.Backpack
		end
		if market:UserOwnsGamePassAsync(Player.UserId, dhpass) then
			local dclone = darkheart:Clone()
			dclone.Parent = Player.Backpack
		end
		if market:UserOwnsGamePassAsync(Player.UserId, illuminapass) then
			local iclone = illumina:Clone()
			iclone.Parent = Player.Backpack
		end
		if market:UserOwnsGamePassAsync(Player.UserId, crimpass) then
			local cclone = crimson:Clone()
			cclone.Parent = Player.Backpack
		end
		if market:UserOwnsGamePassAsync(Player.UserId, goldpass) then
			local goclone = golden:Clone()
			goclone.Parent = Player.Backpack
		end
		if market:UserOwnsGamePassAsync(Player.UserId, katpass) then
			local kclone = katana:Clone()
			kclone.Parent = Player.Backpack
		end
		if market:UserOwnsGamePassAsync(Player.UserId, hammerpass) then
			local hclone = hammer:Clone()
			hclone.Parent = Player.Backpack
		end
		if market:UserOwnsGamePassAsync(Player.UserId, foilpass) then
			local fclone = foil:Clone()
			fclone.Parent = Player.Backpack
		end
	end)
end)