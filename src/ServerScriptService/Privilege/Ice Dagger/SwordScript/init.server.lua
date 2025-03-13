-------- OMG HAX

r = game:service("RunService")


local damage = 7


local slash_damage = 10
local lunge_damage = 17

sword = script.Parent.Handle
Tool = script.Parent


local SlashSound = sword.SwordSlash
SlashSound.Volume = .7

local LungeSound = sword.SwordLunge
LungeSound.Volume = .6

local UnsheathSound = sword.Unsheath
UnsheathSound.Volume = 1

local isDeadly = false

function toggleDeadly(on)
	isDeadly = on
	if (on == true) then 
		Tool.Handle.BrickColor = BrickColor.new(23)
	else
		Tool.Handle.BrickColor = BrickColor.new(1)
	end
end

function FreezeKill(character, humanoid, attacker)

	if (character:FindFirstChild("ForceField") ~= nil) then return end
	if (character:FindFirstChild("Firebrand") ~= nil) then return end


	
	-- make sure this dude dies (edge case when ice dagger wielder gets killed, we may not get back here)
	local dies = script.MakeSureDudeDies:clone()
	dies.Disabled = false
	dies.Parent = character

	local childs = character:GetChildren()

	local colors = {}

	for i=1,#childs do
		if (childs[i].className == "Part") then
			colors[i] = childs[i].BrickColor
			childs[i].BrickColor = BrickColor.new(11)
			childs[i].Transparency = .5
			childs[i].Anchored = true
		end
	end

	wait(2)
	
	for i=1,#childs do
		if (childs[i].className == "Part") then
			childs[i].Anchored = false
		end
	end

	
	tagHumanoid(humanoid, attacker)

	humanoid.Health = 0


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
				if (isDeadly == true) then
					FreezeKill(humanoid.Parent, humanoid, vPlayer)
				else
					tagHumanoid(humanoid, vPlayer)
					humanoid:TakeDamage(damage)				
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
	wait(.2)
	swordOut()
	wait(.25)
	force.Parent = nil
	wait(.7)
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
	UnsheathSound:Play()
	toggleDeadly(false)
	wait(3)
	toggleDeadly(true)
	UnsheathSound:play()
end


function onUnequipped()
	toggleDeadly(false)
end

script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)
script.Parent.Unequipped:connect(onUnequipped)


connection = sword.Touched:connect(blow)


