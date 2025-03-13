-------- OMG HAX

r = game:service("RunService")


local damage = 10

local damage_base = 15
local damage_max = 25

local slash_damage = 10
local lunge_damage = 20

sword = script.Parent.Handle
Tool = script.Parent

local ghostEffect = nil
local ghostChar = nil

local equalizingForce = 236 / 1.2 -- amount of force required to levitate a mass
local gravity = .75 -- things float at > 1

local SlashSound = Instance.new("Sound")
SlashSound.SoundId = "rbxasset://sounds\\swordslash.wav"
SlashSound.Parent = sword
SlashSound.Volume = .7

local LungeSound = Instance.new("Sound")
LungeSound.SoundId = "rbxasset://sounds\\swordlunge.wav"
LungeSound.Parent = sword
LungeSound.Volume = .6

local UnsheathSound = Instance.new("Sound")
UnsheathSound.SoundId = "rbxasset://sounds\\unsheath.wav"
UnsheathSound.Parent = sword
UnsheathSound.Volume = 1


function recursiveGetMass(node)
	local m = 0
	local c = node:GetChildren()
	for i=1,#c do
		if c[i].className == "Part" then
			m = m + c[i]:GetMass()
		end
		m = m + recursiveGetMass(c[i])
	end
	return m
end


function makeMeGhostly(trans)

	if ghostChar == nil then return end

	local parts = {"Head", "Torso", "Left Leg", "Right Leg", "Left Arm", "Right Arm"}

	for i=1,#parts do
		local p = ghostChar:FindFirstChild(parts[i])
		if p ~= nil then p.Transparency = trans end
	end

	
end


function UpdateGhostState(isUnequipping)

	if isUnequipping == true then
		makeMeGhostly(0)
		ghostEffect.Parent = nil
		ghostEffect = nil
		ghostChar = nil
	else
		if ghostEffect == nil then
			local char = Tool.Parent
			if char == nil then return end
			ghostEffect = Instance.new("BodyForce")
			ghostEffect.Name = "GhostEffect"
			ghostEffect.force = Vector3.new(0, recursiveGetMass(char) * equalizingForce * gravity,0)
			ghostEffect.Parent = char.Head
			ghostChar = char
		end
		local power = script.Parent.Kills.Value
		if power > 9 then power = 9 end

		script.Parent.Name = "Ghostwalker (" .. power .. ")"

		slash_damage = damage_base + (damage_max - damage_base) * (power / 9)
		lunge_damage = 2 * (damage_base + (damage_max - damage_base) * (power / 9))

		makeMeGhostly(.2 + ((power / 9) * .8))

	end
	

end




function blow(hit)
	local humanoid = hit.Parent:findFirstChild("Humanoid")
	local vCharacter = Tool.Parent
	local vPlayer = game.Players:playerFromCharacter(vCharacter)
	local hum = vCharacter:findFirstChild("Humanoid") -- non-nil if tool held by a character
	if humanoid~=nil and humanoid ~= hum and hum ~= nil then
		-- final check, make sure sword is in-hand

		local right_arm = vCharacter:FindFirstChild("Right Arm")
		if (right_arm ~= nil) then
			local joint = right_arm:FindFirstChild("RightGrip")
			if (joint ~= nil and (joint.Part0 == sword or joint.Part1 == sword) and humanoid.Health > 0) then
				tagHumanoid(humanoid, vPlayer)
				humanoid:TakeDamage(damage)
				if (humanoid.Health <= 0) then
					script.Parent.Kills.Value = script.Parent.Kills.Value + 1
					local sound = script.Parent.Handle:findFirstChild("GhostSound")
					if sound == nil then 
						sound = Instance.new("Sound")
						sound.Name = "GhostSound"
						sound.SoundId = "rbxasset://sounds\\HalloweenGhost.wav"
						sound.Parent = script.Parent.Handle
					end
					sound:play()
					UpdateGhostState(false)
				end
			end
		end


	end
end



function tagHumanoid(humanoid, player)
	local creator_tag = Instance.new("ObjectValue")
	creator_tag.Value = player
	creator_tag.Name = "creator"
	creator_tag.Parent = humanoid
	game.Debris:AddItem(creator_tag, 1)
end




function attack()
	damage = slash_damage
	SlashSound:play()
	local anim = Instance.new("StringValue")
	anim.Name = "toolanim"
	anim.Value = "Slash"
	anim.Parent = Tool
end

function lunge()
	damage = lunge_damage

	LungeSound:play()

	local anim = Instance.new("StringValue")
	anim.Name = "toolanim"
	anim.Value = "Lunge"
	anim.Parent = Tool
	
	
	local force = Instance.new("BodyVelocity")
	force.velocity = Vector3.new(0,3000,0) --Tool.Parent.Torso.CFrame.lookVector * 80
	force.maxForce = Vector3.new(0,300,0)
	force.Parent = Tool.Parent.Torso
	wait(.25)
	swordOut()
	wait(.25)
	force.Parent = nil
	wait(.5)
	swordUp()

	damage = slash_damage
end

function swordUp()
	Tool.GripForward = Vector3.new(-1,0,0)
	Tool.GripRight = Vector3.new(0,1,0)
	Tool.GripUp = Vector3.new(0,0,1)
end

function swordOut()
	Tool.GripForward = Vector3.new(0,0,1)
	Tool.GripRight = Vector3.new(0,-1,0)
	Tool.GripUp = Vector3.new(-1,0,0)
end

function swordAcross()
	-- parry
end


Tool.Enabled = true
local last_attack = 0
function onActivated()

	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false

	local character = Tool.Parent;
	local humanoid = character.Humanoid
	if humanoid == nil then
		print("Humanoid not found")
		return 
	end

	t = r.Stepped:wait()

	if (t - last_attack < .2) then
		lunge()
	else
		attack()
	end

	last_attack = t

	--wait(.5)

	Tool.Enabled = true
end


function onEquipped()
	UnsheathSound:play()
	UpdateGhostState(false)
end

function onUnequipped()
	UpdateGhostState(true)
end


script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)
script.Parent.Unequipped:connect(onUnequipped)

connection = sword.Touched:connect(blow)


