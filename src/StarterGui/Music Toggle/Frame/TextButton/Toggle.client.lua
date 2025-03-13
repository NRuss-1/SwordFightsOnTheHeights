local PlaylistActive = true
local soundservice = game:GetService("SoundService")
local MusicSoundGroup = soundservice:WaitForChild("SoundGroup")

script.Parent.MouseButton1Click:Connect(function()
	if PlaylistActive == true then
		MusicSoundGroup.Volume = 0
		PlaylistActive = false
	elseif PlaylistActive == false then
		MusicSoundGroup.Volume = 0.5
		PlaylistActive = true
	end
end)