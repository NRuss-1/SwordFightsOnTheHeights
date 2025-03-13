Tool = script.Parent

local field = nil

function shieldsUp()

	if (field == nil) then
		Tool.Handle.Boing:play()

		local vCharacter = Tool.Parent

		Tool.Handle.BrickColor = BrickColor.new(24) -- yellow

		field = Instance.new("ForceField")
		field.Parent = vCharacter

	end

end

function shieldsDown()
	if (field ~= nil) then
		field.Parent = nil
		field = nil
		Tool.Handle.BrickColor = BrickColor.new(104) -- purple
	end
end


Tool.Enabled = true
function onActivated()

	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false

	shieldsUp()

	wait(8)

	shieldsDown()

	wait(2)

	Tool.Enabled = true
end


script.Parent.Activated:connect(onActivated)
Tool.Unequipped:connect(shieldsDown)


