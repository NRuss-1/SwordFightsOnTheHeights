-------- OMG HAX

r = game:service("RunService")


local damage = 10

local slash_damage = 12
local lunge_damage = 25

sword = script.Parent.Handle
Tool = script.Parent

local debris = game:GetService("Debris")

local SlashSound = sword.SwordSlash
SlashSound.Volume = .7

local LungeSound = sword.SwordLunge
LungeSound.Volume = .6

local UnsheathSound = sword.Unsheath
UnsheathSound.Volume = 1

function FireKill(character, humanoid, attacker)

	if (character:FindFirstChild("ForceField") ~= nil) then return end

	local childs = character:GetChildren()

	tagHumanoid(humanoid, attacker)
	humanoid.Health = 0

	task.wait(0.2)

	-- Create fires on each part
	for i = 1, #childs do
		local part = childs[i]
		if part:IsA("BasePart") then
			-- Check if Fire already exists on the part
			if not part:FindFirstChild("Fire") then
				local fire = Instance.new("Fire")
				fire.Name = "Fire" -- Name it to make future checks easier
				fire.Heat = 5
				fire.Size = 5
				fire.Parent = part
			end
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
			if (joint ~= nil and (joint.Part0 == sword or joint.Part1 == sword)) then
				if humanoid.Health > damage then
					tagHumanoid(humanoid, vPlayer)
					humanoid:TakeDamage(damage)
				else
					FireKill(humanoid.Parent, humanoid, vPlayer)
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
	wait(.4)
	swordOut()
	wait(.25)
	force.Parent = nil
	wait(.45)
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

	local t = r.Stepped:wait()

	if (t - last_attack < .3) then
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
end


script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)


connection = sword.Touched:connect(blow)


