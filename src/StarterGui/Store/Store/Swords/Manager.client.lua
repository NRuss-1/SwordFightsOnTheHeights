local shop = script.Parent.Parent
local swordshop = shop.Parent["Sword Shop"]

script.Parent.MouseButton1Click:Connect(function()
	shop.Visible = false
	swordshop.Visible = true
end)