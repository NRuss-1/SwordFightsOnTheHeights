-------- OMG HAX

local r = game:GetService("RunService")

local damage = 10
local damage_base = 15
local damage_max = 25
local slash_damage = 10
local lunge_damage = 20

local sword = script.Parent.Handle
local Tool = script.Parent

local ghostEffect = nil
local ghostChar = nil
local originalTransparencies = {}

local equalizingForce = 236 / 1.2 -- amount of force required to levitate a mass
local gravity = .75 -- things float at > 1

local SlashSound = sword.SwordSlash
SlashSound.Volume = .7

local LungeSound = sword.SwordLunge
LungeSound.Volume = .6

local UnsheathSound = sword.Unsheath
UnsheathSound.Volume = 1

local GhostSound = sword.GhostSound
GhostSound.Volume = 1

function SoulKill(character, humanoid, attacker)

	if (character:FindFirstChild("ForceField") ~= nil) then return end

	local childs = character:GetChildren()

	tagHumanoid(humanoid, attacker)
	humanoid.Health = 0

	task.wait(0.2)

	-- Create fires on each part
	for i = 1, #childs do
		local part = childs[i]
		if part:IsA("Part") and part.Name ~= "HumanoidRootPart" then
			-- Check if Fire already exists on the part
			if not part:FindFirstChild("Fire") then
				local fire = Instance.new("Fire")
				fire.Name = "Fire" -- Name it to make future checks easier
				fire.Color = Color3.new(0.0196078, 0.27451, 0.870588)
				fire.SecondaryColor = Color3.new(0.333333, 0.733333, 1)
				fire.Heat = 5
				fire.Size = 5
				fire.Parent = part
			end
			-- changing the body parts
			part.Transparency = .5
		end
	end

	-- Wait for 2 seconds before removing all fires
	task.wait(3)

	-- Remove all fires
	for i = 1, #childs do
		local part = childs[i]
		if part:IsA("BasePart") then
			local fire = part:FindFirstChild("Fire")
			if fire then
				fire:Destroy()
			end
		end
	end

end

function recursiveGetMass(node)
	local m = 0
	local c = node:GetChildren()
	for i = 1, #c do
		if c[i]:IsA("Part") then
			m = m + c[i]:GetMass()
		end
		m = m + recursiveGetMass(c[i])
	end
	return m
end

function makeMeGhostly(trans)
	if ghostChar == nil then return end

	local parts = {"Head", "Torso", "Left Leg", "Right Leg", "Left Arm", "Right Arm"}

	for i = 1, #parts do
		local p = ghostChar:FindFirstChild(parts[i])
		if p ~= nil then p.Transparency = trans end
	end

	-- Change transparency of accessories
	for _, accessory in ipairs(ghostChar:GetChildren()) do
		if accessory:IsA("Accessory") and accessory:FindFirstChild("Handle") then
			accessory.Handle.Transparency = trans
		end
	end
end

function saveOriginalTransparencies()
	if ghostChar == nil then return end
	for _, child in ipairs(ghostChar:GetChildren()) do
		if child:IsA("Accessory") and child:FindFirstChild("Handle") then
			originalTransparencies[child] = child.Handle.Transparency
		end
	end
end

function UpdateGhostState(isUnequipping)
	if isUnequipping == true then
		makeMeGhostly(0) -- Reset character transparency to visible
		for accessory, transparency in pairs(originalTransparencies) do
			if accessory:FindFirstChild("Handle") then
				accessory.Handle.Transparency = transparency -- Restore original transparency
			end
		end
		ghostEffect.Parent = nil
		ghostEffect = nil
		ghostChar = nil
	else
		if ghostEffect == nil then
			local char = Tool.Parent
			if char == nil or char.ClassName == "Backpack" then return end
			ghostEffect = Instance.new("BodyForce")
			ghostEffect.Name = "GhostEffect"
			ghostEffect.Force = Vector3.new(0, recursiveGetMass(char) * equalizingForce * gravity, 0)
			ghostEffect.Parent = char.Head
			ghostChar = char

			saveOriginalTransparencies() -- Save original transparencies when equipped
		end
		local power = script.Parent.Kills.Value
		if power > 9 then power = 9 end

		script.Parent.Name = "Ghostwalker (" .. power .. ")"

		slash_damage = damage_base + (damage_max - damage_base) * (power / 9)
		lunge_damage = 2 * (damage_base + (damage_max - damage_base) * (power / 9))

		makeMeGhostly(0.2 + ((power / 9) * 0.8)) -- Set ghostly transparency
	end
end

function blow(hit)
	local humanoid = hit.Parent:FindFirstChild("Humanoid")
	local vCharacter = Tool.Parent
	local vPlayer = game.Players:GetPlayerFromCharacter(vCharacter)
	local hum = vCharacter:FindFirstChild("Humanoid") -- non-nil if tool held by a character
	if humanoid ~= nil and humanoid ~= hum and hum ~= nil then
		local right_arm = vCharacter:FindFirstChild("Right Arm")
		if (right_arm ~= nil) then
			local joint = right_arm:FindFirstChild("RightGrip")
			if (joint ~= nil and (joint.Part0 == sword or joint.Part1 == sword) and humanoid.Health > 0) then
				tagHumanoid(humanoid, vPlayer)
				humanoid:TakeDamage(damage)
				if (humanoid.Health <= 0) then
					SoulKill(humanoid.Parent, humanoid, vPlayer)
					script.Parent.Kills.Value = script.Parent.Kills.Value + 1
					GhostSound:Play()
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
	SlashSound:Play()
	local anim = Instance.new("StringValue")
	anim.Name = "toolanim"
	anim.Value = "Slash"
	anim.Parent = Tool
end

function lunge()
	damage = lunge_damage
	LungeSound:Play()

	local anim = Instance.new("StringValue")
	anim.Name = "toolanim"
	anim.Value = "Lunge"
	anim.Parent = Tool

	local force = Instance.new("BodyVelocity")
	force.Velocity = Vector3.new(0, 3000, 0)
	force.MaxForce = Vector3.new(0, 300, 0)
	force.Parent = Tool.Parent.Torso
	wait(0.25)
	swordOut()
	wait(0.25)
	force.Parent = nil
	wait(0.5)
	swordUp()

	damage = slash_damage
end

function swordUp()
	Tool.GripForward = Vector3.new(-1, 0, 0)
	Tool.GripRight = Vector3.new(0, 1, 0)
	Tool.GripUp = Vector3.new(0, 0, 1)
end

function swordOut()
	Tool.GripForward = Vector3.new(0, 0, 1)
	Tool.GripRight = Vector3.new(0, -1, 0)
	Tool.GripUp = Vector3.new(-1, 0, 0)
end

Tool.Enabled = true
local last_attack = 0
function onActivated()
	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false

	local character = Tool.Parent
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid == nil then
		print("Humanoid not found")
		return 
	end

	local t = r.Stepped:Wait()

	if (t - last_attack < 0.2) then
		lunge()
	else
		attack()
	end

	last_attack = t

	Tool.Enabled = true
end

function onEquipped()
	UnsheathSound:Play()
	UpdateGhostState(false)
end

function onUnequipped()
	UpdateGhostState(true)
end

script.Parent.Activated:Connect(onActivated)
script.Parent.Equipped:Connect(onEquipped)
script.Parent.Unequipped:Connect(onUnequipped)

local connection = sword.Touched:Connect(blow)
