local player = game.Players.LocalPlayer
local equipped = false
local walking = false
local reloadtime = 0
local thrust = Instance.new("BodyVelocity")
local velocity = 0
local max_velocity = 30
local flight_time = 6
local UIS = game:GetService("UserInputService")
local mouse = player:GetMouse()

bin = script.Parent


function onStart()
	if equipped then
		walking = true
		reloadtime = 8.0

		thrust.Parent = player.Character.Torso
		thrust.velocity = Vector3.new(0, velocity, 0)
		thrust.maxForce = Vector3.new(0, 8e+003, 0) 

		local sound = player.Character.Torso:findFirstChild("JetbootSound")
		if sound == nil then 
			sound = Instance.new("Sound")
			sound.Name = "JetbootSound"
			sound.SoundId = "rbxasset://sounds\\Rocket whoosh 01.wav"
			sound.Looped = true
			sound.Parent = player.Character.Torso
		end
		sound:play()
	end
end


function onEnd()
	walking = false
	thrust.Parent = nil

	local sound = player.Character.Torso:findFirstChild("JetbootSound")
	if sound ~= nil then sound:stop() end
	wait(reloadtime)
	reloadtime = 0
	
	if equipped then
		mouse.Icon = "rbxasset://textures\\GunCursor.png"
	end
end


function onInputBegin(input)
	if equipped then
		if reloadtime > 0 then return end
		if walking == true then return end

		onStart()

		mouse.Icon = "rbxasset://textures\\GunCursor.png"

		local time = 0
		while walking == true do
			-- onWalk()
			wait(.2)
			time = time + .2
			velocity = (max_velocity  * (time / flight_time)) + 3 
			thrust.velocity = Vector3.new(0, velocity, 0)

			if time > flight_time then 
				onInputEnd(input) 
			end
		end
	end
end


function onInputEnd()
	mouse.Icon = "rbxasset://textures\\GunWaitCursor.png"

	onEnd()
end


UIS.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		onInputBegin(input)
	end
end)


script.Parent.Equipped:Connect(function()
	equipped = true
	bin.Handle.Transparency = 1
	if reloadtime > 0 then
		mouse.Icon = "rbxasset://textures\\GunWaitCursor.png"
	else
		mouse.Icon = "rbxasset://textures\\GunCursor.png"
	end
end)

script.Parent.Unequipped:Connect(function()
	onEnd()
	bin.Handle.Transparency = 0
	equipped = false
end)


UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		onInputEnd(input)
	end
end)

UIS.TouchStarted:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	if input.UserInputType == Enum.UserInputType.Touch then
		onInputBegin(input)
	end
end)

UIS.TouchEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		onInputEnd(input)
	end
end)