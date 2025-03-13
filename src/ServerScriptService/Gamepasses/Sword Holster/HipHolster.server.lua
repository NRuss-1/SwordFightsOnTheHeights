local Tool = script.Parent
local Handle = script.Parent:WaitForChild("Handle")
function Equipped(Mouse)
	Player = script.Parent.Parent
	if Player:FindFirstChild("Holster") then
		Player.Holster:remove()
	end
end

function Unequipped(Mouse)
	if Player:FindFirstChild("Holster")==nil then
	local Holster = Handle:Clone()
local BackAttachment = Instance.new("Attachment")
BackAttachment.Orientation = Vector3.new(-2, -25, 90)
BackAttachment.Name = "WaistAttachment"
BackAttachment.Parent = Holster
Holster.Parent = Player
Holster.Name = "Holster"
Holster.CanCollide = false
local Torso = Player:FindFirstChild("LowerTorso") or Player:FindFirstChild("Torso")
	if Torso then
	local w=Instance.new("Motor")
		w.Part0=Holster
		w.Part1=Torso
		w.C0=BackAttachment.CFrame+Vector3.new(-1,1,-0.5)
		w.Parent=Holster
	end
end
end
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)