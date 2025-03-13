local ready = true
local part = script.Parent

function onTouched(part)

	local h = part.Parent:findFirstChild("Humanoid")

	if h~=nil and ready == true then
		ready = false
		script.Parent.BrickColor = BrickColor.new(26)
		local t = Instance.new("IntValue")
		t.Name = "Trigger"
		t.Parent = game.Workspace.DeathPlates
		wait(15)
		ready = true
		script.Parent.BrickColor = BrickColor.new(21)
	end


end



script.Parent.Touched:connect(onTouched)