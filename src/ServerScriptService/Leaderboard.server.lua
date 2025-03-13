print("Leaderboard is succesfully started up!")


function onHumanoidDied(humanoid, player)
	local stats = player:findFirstChild("leaderstats")
	if stats ~= nil then
		local deaths = stats:findFirstChild("Deaths")
		deaths.Value = deaths.Value + 1


		local killer = getKillerOfHumanoidIfStillInGame(humanoid)

		handleKillCount(humanoid, player)
	end
end

function onPlayerRespawn(property, player)

	
	if property == "Character" and player.Character ~= nil then
		local humanoid = player.Character.Humanoid
			local p = player
			local h = humanoid
			humanoid.Died:connect(function() onHumanoidDied(h, p) end )
	end
end

function getKillerOfHumanoidIfStillInGame(humanoid)

	local tag = humanoid:findFirstChild("creator")


	if tag ~= nil then
		
		local killer = tag.Value
		if killer.Parent ~= nil then
			return killer
		end
	end

	return nil
end

function handleKillCount(humanoid, player)
	local killer = getKillerOfHumanoidIfStillInGame(humanoid)
	if killer ~= nil then
		local stats = killer:findFirstChild("leaderstats")
		if stats ~= nil then
			local kills = stats:findFirstChild("Kills")
			if killer ~= player then
				kills.Value = kills.Value + 1
				
			else
				kills.Value = kills.Value - 1
				
			end
		end
	end
end


-----------------------------------------------


function onPlayerEntered(newPlayer)

		local stats = Instance.new("IntValue")
		stats.Name = "leaderstats"

		local kills = Instance.new("IntValue")
		kills.Name = "Kills"
		kills.Value = 0

		local deaths = Instance.new("IntValue")
		deaths.Name = "Deaths"
		deaths.Value = 0

		kills.Parent = stats
		deaths.Parent = stats

		while true do
			if newPlayer.Character ~= nil then break end
			wait(5)
		end

		local humanoid = newPlayer.Character.Humanoid

		humanoid.Died:connect(function() onHumanoidDied(humanoid, newPlayer) end )


		newPlayer.Changed:connect(function(property) onPlayerRespawn(property, newPlayer) end )


		stats.Parent = newPlayer

end


game.Players.ChildAdded:connect(onPlayerEntered)


