Tool = script.Parent



function teleport()

	local char = Tool.Parent

	if (char == nil) then return end

	local t = char:FindFirstChild("Torso")
	if t == nil then return end

	local dx = math.random(-10,10)
	local dz = math.random(-10,10)

	local pos = game.Workspace.TouchstoneLocus.Position

	local dest = Vector3.new(pos.x + dx, pos.y - 15, pos.z + dz)
	local g = Instance.new("BodyAngularVelocity")
	g.maxTorque = Vector3.new(1e5,1e5,1e5)
	g.angularvelocity = Vector3.new(0,0,0)
	g.Parent = t

	t.CFrame = CFrame.new(dest)

	t.Velocity = Vector3.new(0,0,0)
	t.RotVelocity = Vector3.new(0,0,0)

	wait(1)
	g.Parent = nil


end



Tool.Enabled = true
function onActivated()

	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false

	teleport()

	wait(.1)

	Tool.Enabled = true
end


script.Parent.Activated:connect(onActivated)



