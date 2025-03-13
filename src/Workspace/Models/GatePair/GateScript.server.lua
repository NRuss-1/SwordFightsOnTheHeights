function Teleport(char, enter, exit)
	if char == nil then return end

	
	local sound = enter:FindFirstChild("Lightning")
	if (sound == nil) then
		sound = Instance.new("Sound")
		sound.SoundId = "rbxasset://sounds\\HalloweenLightning.wav"
		sound.Parent = enter
	end
	sound:play()



	local torso = char.Torso

	
	torso.CFrame = exit.CFrame + (exit.CFrame.lookVector * 5)
		

	--torso.CFrame = CFrame.new(Vector3.new(pos.x, pos.y + 7, pos.z))

	sound = exit:FindFirstChild("Thunder")
	if (sound == nil) then
		sound = Instance.new("Sound")
		sound.SoundId = "rbxasset://sounds\\HalloweenThunder.wav"
		sound.Parent = exit
	end
	sound:play()


end


function getChar(part)
	local human = part.Parent:findFirstChild("Humanoid")
	if (human ~= nil and human.Parent ~= nil) then
		return human.Parent
	end
	return nil
end

function onTouchedGateA(part)
	Teleport(getChar(part), script.Parent.A.Gate, script.Parent.B.Gate)
end

function onTouchedGateB(part)
	Teleport(getChar(part), script.Parent.B.Gate, script.Parent.A.Gate)
end


script.Parent.A.Gate.Touched:connect(onTouchedGateA)
script.Parent.B.Gate.Touched:connect(onTouchedGateB)