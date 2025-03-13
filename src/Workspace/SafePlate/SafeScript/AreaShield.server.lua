f = Instance.new("ForceField")
f.Parent = script.Parent

while true do
	wait(.5)
	if (script.Parent:FindFirstChild("Torso") ~= nil) then
		if ((script.Parent.Torso.Position - game.Workspace.SafePlate.Position).magnitude > 64) then break end
	else
		break
	end

end

f.Parent = nil
script.Parent = nil


