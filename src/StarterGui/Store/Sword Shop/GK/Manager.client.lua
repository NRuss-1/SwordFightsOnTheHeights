

local ProductType = "Gamepass" -- Change between "Gamepass", "DeveloperProduct" & "CatalogProduct".
local ProductID = 947089383 -- ID of your product.

local MarketplaceService = game:GetService("MarketplaceService")

script.Parent.MouseButton1Click:Connect(function()
	if ProductType == "Gamepass" then
		MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, ProductID)
	elseif ProductID == "DeveloperProduct" then
		MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer, ProductID)
	elseif ProductID == "CatalogProduct" then
		MarketplaceService:PromptPurchase(game.Players.LocalPlayer, ProductID)
	end
end)