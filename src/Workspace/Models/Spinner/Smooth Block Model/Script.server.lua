function onTouched(part)

	local h = part.Parent:findFirstChild("Humanoid")

	if h~=nil then
		h:TakeDamage(20)
	end

	wait(1)
end



script.Parent.Touched:connect(onTouched)