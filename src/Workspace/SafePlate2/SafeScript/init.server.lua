function onTouched(part)

	local h = part.Parent:findFirstChild("Humanoid")

	if h~=nil then
		if (h.Parent:FindFirstChild("AreaShield") == nil) then
			local a = script.AreaShield:clone()
			a.Disabled = false
			a.Parent = h.Parent
		end
	end


end



script.Parent.Touched:connect(onTouched)