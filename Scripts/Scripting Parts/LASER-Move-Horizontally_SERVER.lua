--Laser Part
laser = script.Parent
--XYZ pos
X = laser.Position.X
Y = laser.Position.Y
Z = laser.Position.Z
--Moving length
moving_length = 27

moveState = script.Parent:FindFirstChild('Move State')



--Moves the part left or right
function move(a)	
	Z += a
	laser.Position = Vector3.new(X, Y, Z)
	wait(.01)
end



--Moves laser left and right forever
while true do	
	
	--Initial Z position
	local initial_Z = Z
	
	if moveState.Value == 'Right' then
		while Z ~= initial_Z + moving_length do
			move(.5)
		end
		moveState.Value = 'Left'
	else
		while Z ~= initial_Z - moving_length do
			move(-.5)
		end
		moveState.Value = 'Right'
	end
end