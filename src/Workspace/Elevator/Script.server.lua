local TweenService = game:GetService("TweenService")

local RunService = game:GetService("RunService")

local part = script.Parent

local tweenInfo = TweenInfo.new(9, Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut, -1, true)


local tween = TweenService:Create(part, tweenInfo, {

	CFrame = part.CFrame * CFrame.new(0, 40, 0)

})

tween:Play()

local lastposition = part.Position


RunService.Stepped:Connect(function(_, deltaTime)

	local currentPosition = part.Position

	local deltaposition = currentPosition - lastposition

	local velocity = deltaposition / deltaTime

	part.AssemblyLinearVelocity = velocity

	lastposition = currentPosition
end)