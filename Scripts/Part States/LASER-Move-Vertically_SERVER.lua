--Laser Part
laser = script.Parent
--XYZ pos
X = laser.Position.X
Y = laser.Position.Y
Z = laser.Position.Z
--Moving length
moving_length = 22

moveState = script.Parent:FindFirstChild('Move State')



--Moves the part left or right
function move(a)	
	Y += a
	laser.Position = Vector3.new(X, Y, Z)
	wait(.01)
end



--Moves laser left and right forever
while true do	
	
	--Initial Z position
	local initial_Y = Y
	
	if moveState.Value == 'Up' then
		while Y ~= initial_Y + moving_length do
			move(.5)
		end
		moveState.Value = 'Down'
	else
		while Y ~= initial_Y - moving_length do
			move(-.5)
		end
		moveState.Value = 'Up'
	end
end