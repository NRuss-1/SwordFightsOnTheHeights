local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local Tool = script.Parent


local function onTouchTap(actionName, inputState)
	if actionName == "TouchTapImageButton" and inputState == Enum.UserInputState.Begin then
		Tool:Activate()
	end
end


local function onEquipped()
	
	if UserInputService.TouchEnabled == false then
		return
	end
	
	ContextActionService:BindAction("TouchTapImageButton", onTouchTap, true, Enum.UserInputType.Touch)
	ContextActionService:SetImage("TouchTapImageButton", "http://www.roblox.com/asset/?id=534533607")
	ContextActionService:SetPosition("TouchTapImageButton", UDim2.new(0.3, 0, 0, 0))
	local button = ContextActionService:GetButton("TouchTapImageButton")
	button.Size = UDim2.new(0, 60, 0, 60)
	button.ActionIcon.Rotation = -90
end


local function onUnequipped()
	
	if UserInputService.TouchEnabled == false then
		return
	end

	ContextActionService:UnbindAction("TouchTapImageButton")
end

Tool.Equipped:Connect(onEquipped)
Tool.Unequipped:Connect(onUnequipped)
