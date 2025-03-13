local plates = {}
local states = {}
local colors = {}


-- plates and states!
function Init()
	local c = script.Parent:GetChildren()

	for i=1,#c do
		if (c[i].Name == "PhantomPlate") then
			plates[i] = c[i]
			states[i] = 0
			colors[i] = plates[i].BrickColor
		end
	end
end

function UpdatePlate(i)
	
	if (states[i] ~= 0) then states[i] = states[i] + 1 else
		if(math.random(1,75) == 5) then states[i] = 1 end
	end

	if (states[i] < 4) then
		plates[i].Transparency = 0
		plates[i].CanCollide = true
		plates[i].BrickColor = colors[i]
	end

	if (states[i] == 4) then
		plates[i].BrickColor = BrickColor.new(26)
	end
	if (states[i] == 5) then
		plates[i].Transparency = .2
	end
	if (states[i] == 10) then
		plates[i].Transparency = .4
	end
	if (states[i] == 15) then
		plates[i].Transparency = .6
	end
	if (states[i] == 20) then
		plates[i].Transparency = .8
	end
	if (states[i] == 25) then
		plates[i].Transparency = 1
		plates[i].CanCollide = false
	end

	if (states[i] == 50) then
		states[i] = 0
	end
end


function Update()
	for i=1,#plates do
		UpdatePlate(i)
	end
end


function onChildAdded(child)
	if (child.Name == "Trigger") then
		child.Parent = nil
		for i=1,#plates do
			states[i] = 3
		end
	end
end

Init()

script.Parent.ChildAdded:connect(onChildAdded)

while true do
	Update()
	wait(.2)
end