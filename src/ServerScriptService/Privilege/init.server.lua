-- free swords for the evil owners
local hammer = script.ThorsHammer
local split = script.Earthsplitter
local ice = script["Ice Dagger"]
local gold = script["Gold Katana"]

game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		
		if Player.UserId == 9626586 then -- jack
			local hamclone = hammer:Clone()
			hamclone.Parent = Player.Backpack
		end
		
		if Player.UserId == 9626586 then -- jack 2
			local splitclone = split:Clone()
			splitclone.Parent = Player.Backpack
		end
			
		if 	Player.UserId == 132008297 then -- dom 2
			local goldclone = gold:Clone()
			goldclone.Parent = Player.Backpack
		end

		if Player.UserId == 5225489475 then -- alt account
			local iceclone = ice:Clone()
			iceclone.Parent = Player.Backpack
		end
		
		if Player.UserId == 19885294 then -- alt account
			local iceclone = ice:Clone()
			iceclone.Parent = Player.Backpack
		end
		
	end)
end)