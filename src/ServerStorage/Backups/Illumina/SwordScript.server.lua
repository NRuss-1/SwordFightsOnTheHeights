-------- OMG HAX

r = game:service("RunService")


local damage = 10


local slash_damage = 20
local lunge_damage = 40

sword = script.Parent.Handle
Tool = script.Parent


local SlashSound = sword.SwordSlash
SlashSound.Volume = .7

local LungeSound = sword.SwordLunge
LungeSound.Volume = .6

local UnsheathSound = sword.Unsheath
UnsheathSound.Volume = 1






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
				tagHumanoid(humanoid, vPlayer)
				humanoid:TakeDamage(damage)

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
	force.velocity =  Vector3.new(0,3000,0) 
	force.maxForce = Vector3.new(0,2400,0)
	force.Parent = Tool.Parent.Torso
	wait(.25)
	swordOut()
	wait(.5)
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
	UnsheathSound:play()
end

function reveal()
	-- tag all nearby invisible players for reveal
	
	-- only check when the weapon is equipped
	if (script:IsDescendantOf(game.Workspace) == false) then return end

	local p = game.Players:GetPlayers()
	for i=1,#p do
		local c = p[i].Character
		if (c ~= nil) then

			if (script.Parent.Parent ~= nil and script.Parent.Parent ~= c) then -- don't check self

				local torso = c:FindFirstChild("Torso")
				if (torso ~= nil) then
					if (torso.Position - script.Parent.Handle.Position).magnitude < 32 then
						local parts = c:GetChildren()
						for j=1,#parts do
							if (parts[j].className == "Part") then
								if (parts[j]:FindFirstChild("IlluminaSparkles") == nil) then
									if (parts[j].Transparency > 0) then
										local s = script.Parent.Handle.IlluminaSparkles:Clone()
										game.Debris:AddItem(s, 2)
										s.Parent = parts[j]
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)


connection = sword.Touched:connect(blow)

while true do
	wait(.25)
	reveal()
end

