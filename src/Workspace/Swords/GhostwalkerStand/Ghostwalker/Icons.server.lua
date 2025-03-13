local sword = script.Parent
local killval = sword.Kills

function iconchange()
	if killval.Value == 1 then
		sword.TextureId = "http://www.roblox.com/asset/?id=128752121120408"
	elseif killval.Value == 2 then
		sword.TextureId = "http://www.roblox.com/asset/?id=119522663777134"
	elseif killval.Value == 3 then
		sword.TextureId = "http://www.roblox.com/asset/?id=101905347662986"
	elseif killval.Value == 4 then
		sword.TextureId = "http://www.roblox.com/asset/?id=116061237687966"
	elseif killval.Value == 5 then
		sword.TextureId = "http://www.roblox.com/asset/?id=97618630791472"
	elseif killval.Value == 6 then
		sword.TextureId = "http://www.roblox.com/asset/?id=115740512026582"
	elseif killval.Value == 7 then
		sword.TextureId = "http://www.roblox.com/asset/?id=92539322665145"
	elseif killval.Value == 8 then
		sword.TextureId = "http://www.roblox.com/asset/?id=130385219879990"
	elseif killval.Value == 9 then
		sword.TextureId = "http://www.roblox.com/asset/?id=140015296300450"
	end
end

sword.Kills.Changed:Connect(iconchange)