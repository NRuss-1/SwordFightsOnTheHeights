local soundservice = game:GetService("SoundService")
local playlist = soundservice:WaitForChild("SoundGroup")
local music1 = playlist.DarknessDueling
local music2 = playlist.Masamune
local music3 = playlist.DenendroClimb
local music4 = playlist.WindsOfFjords
local music5 = playlist.DarkestOmen
local music6 = playlist.Gothic
local music7 = playlist.CursedAbbey

while true do
	music1:Play()
	music1.Ended:Wait()
	task.wait(.1)
	music2:Play()
	music2.Ended:Wait()
	task.wait(.1)
	music3:Play()
	music3.Ended:Wait()
	task.wait(.1)
	music4:Play()
	music4.Ended:Wait()
	task.wait(.1)
	music5:Play()
	music5.Ended:Wait()
	task.wait(.1)
	music6:Play()
	music6.Ended:Wait()
	task.wait(.1)
	music7:Play()
	music7.Ended:Wait()
	task.wait(.1)
end