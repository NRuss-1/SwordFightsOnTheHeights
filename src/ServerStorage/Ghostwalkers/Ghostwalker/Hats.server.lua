local tool = script.Parent
local originalTransparencies = {}

local function saveOriginalTransparencies()
	local character = tool.Parent
	for _, child in ipairs(character:GetChildren()) do
		if child:IsA("Accessory") and child:FindFirstChild("Handle") then
			originalTransparencies[child] = child.Handle.Transparency
		end
	end
end

local function changeHatTransparency(transparency)
	local character = tool.Parent
	for _, child in ipairs(character:GetChildren()) do
		if child:IsA("Accessory") and child:FindFirstChild("Handle") then
			child.Handle.Transparency = transparency
		end
	end
end

local function OnEquip()
	saveOriginalTransparencies() -- Save original transparencies
	changeHatTransparency(0.6) -- Set transparency to 60%
end

local function OnUnequip()
	local character = tool.Parent
	for accessory, originalTransparency in pairs(originalTransparencies) do
		if accessory:FindFirstChild("Handle") then
			accessory.Handle.Transparency = originalTransparency -- Restore original transparency
		end
	end
end

tool.Equipped:Connect(OnEquip)
tool.Unequipped:Connect(OnUnequip)
