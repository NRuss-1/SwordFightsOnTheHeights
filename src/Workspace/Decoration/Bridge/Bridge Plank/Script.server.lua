local function FireDamage(hit)
	local human = hit.Parent:FindFirstChild("Humanoid")
	if human ~= nil then
		human:TakeDamage(5)
	end
end

script.Parent.Touched:Connect(FireDamage)