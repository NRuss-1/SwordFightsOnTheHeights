local shop = script.Parent.Parent.Parent.Store
local swordshop = script.Parent.Parent

script.Parent.MouseButton1Click:Connect(function()
	shop.Visible = true
	swordshop.Visible = false
end)