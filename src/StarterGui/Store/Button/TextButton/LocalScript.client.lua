local shop = script.Parent.Parent.Parent.Store
local showing = false

script.Parent.MouseButton1Click:Connect(function()
	if showing == false then
		shop.Visible = true
		showing = true
	elseif showing == true then
		shop.Visible = false
		showing = false
	end
end)