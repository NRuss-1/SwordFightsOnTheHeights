Tool = script.Parent

local field = nil

local face, shirt = nil

local hats = nil

local isVisible = true

local invisibleChar = nil

local pants, fullshirt = nil

local sound = script.Poof
sound.Volume = .5


function setTrans(trans, character)
	local childs = character:GetChildren()


	for i=1,#childs do
		if (childs[i].className == "Part") then
			childs[i].Transparency = trans
		end
		if (childs[i]:IsA("Tool")) then
			if (childs[i].Name == "ShadowSphere" and trans == 0) then 
				childs[i].Handle.Transparency = .5 
			else
				childs[i].Handle.Transparency = trans
			end
		end
	end
end

function invisible()
	isVisible = false
	invisibleChar = Tool.Parent

	setTrans(1, Tool.Parent)
	face = Tool.Parent.Head.face:clone()
	shirt = Tool.Parent.Torso.roblox:clone()

	Tool.Parent.Head.face.Parent = nil
	Tool.Parent.Torso.roblox.Parent = nil

	pants = nil
	fullshirt = nil

	local childs = invisibleChar:GetChildren()
	for i=1,#childs do
		if (childs[i].className == "Pants") then
			pants = childs[i]
			pants.Parent = nil
		end
		if (childs[i].className == "Shirt") then
			fullshirt = childs[i]
			fullshirt.Parent = nil
		end
		if (childs[i].className == "Accessory") then
			hats = childs[i]
			hats.Handle.Transparency = 1
		end
	end
	

end

function visible()

	if (isVisible == true) then return end
	isVisible = true
	

	--local char = nil
	--if (Tool.Parent.className == "Backpack") then
	--	char = Tool.Parent.Parent.Character
	--else
	--	char = Tool.Parent
	--end
	if (invisibleChar ~= nil) then


		setTrans(0, invisibleChar)

		if (face ~= nil) then 
			face:clone().Parent = invisibleChar.Head
		end

		if (shirt ~= nil) then 
			shirt:clone().Parent = invisibleChar.Torso
		end

		if (pants ~= nil) then
			pants.Parent = invisibleChar
		end

		if (fullshirt ~= nil) then
			fullshirt.Parent = invisibleChar
		end
		
		if (hats ~= nil) then
			local childs = invisibleChar:GetChildren()
			for i=1,#childs do
				if (childs[i].className == "Accessory") then
					hats = childs[i]
					hats.Handle.Transparency = 0
				end
			end
		end

		Tool.Handle.Transparency = .5
	end
	if Tool.Parent:IsA("Model") then
		if Tool.Parent:FindFirstChild("HumanoidRootPart").Transparency == 0 then
			Tool.Parent:FindFirstChild("HumanoidRootPart").Transparency = 1
		end
	elseif not Tool.Parent:IsA("Model") then	
		local Char = Tool.Parent.Parent.Character
		if Char:FindFirstChild("HumanoidRootPart").Transparency == 0 then
			Char:FindFirstChild("HumanoidRootPart").Transparency = 1
		end
	end

	invisibleChar = nil

end




Tool.Enabled = true
function onActivated()

	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false
	
	sound:play()

	invisible()

	wait(8)
	
	sound:Play()

	visible()

	wait(2)

	Tool.Enabled = true

	
end

script.Parent.Activated:connect(onActivated)
Tool.Unequipped:connect(visible)