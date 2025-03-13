local frame = script.Parent.Parent
local dl = frame.DL
local light = frame.Lightning
local fire = frame.Fire
local stars = frame.Stars
local vis = false

script.Parent.MouseButton1Click:Connect(function()
	if vis == false then
		vis = true
		dl.Visible = true
		light.Visible = true
		fire.Visible = true
		stars.Visible = true
	elseif vis == true then
		vis = false
		dl.Visible = false
		light.Visible = false
		fire.Visible = false
		stars.Visible = false
	end
end)