function onTouch(hit)
	local human = hit.Parent:findFirstChild("Humanoid")
	if (human ~= nil) then
		
		local t = hit.Parent.Torso
		local dir = Vector3.new(-1,0,0)

		t.CFrame = CFrame.new(game.Workspace.Vortex2.Position + (5 * dir))

		local pos = Instance.new("BodyPosition")
		pos.position = Vector3.new(0,400,0)
		pos.maxForce = Vector3.new(2460,1e4,2460)
		pos.Parent = t
		wait(2)
		pos.Parent = nil

	end
end

connection = script.Parent.Touched:connect(onTouch)
