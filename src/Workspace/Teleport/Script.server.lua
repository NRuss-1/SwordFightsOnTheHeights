function teleportPlayer(pos, torso)


	local char = torso

local sound = Instance.new("Sound")
	sound.SoundId = "rbxasset://sounds\\HalloweenLightning.wav"
	sound.Parent = char
	sound.PlayOnRemove = true
	sound:remove()

	char.CFrame = CFrame.new(Vector3.new(pos.x, pos.y + 7, pos.z))


	sound = Instance.new("Sound")
	sound.SoundId = "rbxasset://sounds\\HalloweenThunder.wav"
	sound.Parent = char
	sound.PlayOnRemove = true
	sound:remove()

end

function onTouched(part)
	if part.Parent ~= nil then
		local h = part.Parent:findFirstChild("Humanoid")
			if h~=nil then
				
				teleportPlayer(Vector3.new(37,330,-12.5), part.Parent.Torso)

			end			
	end
end

script.Parent.Touched:connect(onTouched)
