-------- OMG HAX

r = game:service("RunService")


local damage = 20


local slash_damage = 16
local lunge_damage = 32

sword = script.Parent.Handle
Tool = script.Parent


local SlashSound = sword.SwordSlash
SlashSound.Volume = .7

local LungeSound = sword.SwordLunge
LungeSound.Volume = .6

local UnsheathSound = sword.Unsheath
UnsheathSound.Volume = 1

function DarkKill(character, humanoid, attacker)

	if (character:FindFirstChild("ForceField") ~= nil) then return end

	local childs = character:GetChildren()

	local colors = {}

	tagHumanoid(humanoid, attacker)
	humanoid.Health = 0

	for i=1,#childs do
		if (childs[i].className == "Part") then
			colors[i] = childs[i].BrickColor
			childs[i].BrickColor = BrickColor.new(26)
			childs[i].CanCollide = true
			childs[i].Anchored = true
		end
	end

	wait(.25)
	
	for i=1,#childs do
		if (childs[i].className == "Part") then
			local b = Instance.new("BodyVelocity")
			b.velocity = Vector3.new(math.random() - .5, 0, math.random() - .5).unit * 80
			b.maxForce = Vector3.new(1e5,1e5,1e5)
			b.Parent = childs[i]
		end
	end

	for i=1,#childs do
		if (childs[i].className == "Part") then
			childs[i].Anchored = false
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
				hum.Health = hum.Health + (damage * .4)
				if humanoid.Health > damage then
					tagHumanoid(humanoid, vPlayer)
					humanoid:TakeDamage(damage)
				else
					DarkKill(humanoid.Parent, humanoid, vPlayer)
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
end


script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)


connection = sword.Touched:connect(blow)


