local minage = 7

game.Players.PlayerAdded:Connect(function(player)
	if player.AccountAge < minage then
		player:Kick("Account too new.")
	end
end)