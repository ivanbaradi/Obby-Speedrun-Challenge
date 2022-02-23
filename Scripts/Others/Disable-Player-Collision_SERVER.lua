--ServerStorage
ServerStorage = game.ServerStorage
--Physics Service
PhysicsService = game:GetService('PhysicsService')
--Sets the name of the collision group
collisionGroupName = 'Players'
PhysicsService:CreateCollisionGroup(collisionGroupName)
--Disables players from colliding each other
PhysicsService:CollisionGroupSetCollidable(collisionGroupName, collisionGroupName, false)

--[[Disables player from colliding with another player

	Param(s):
	char => player's character
]]
ServerStorage:FindFirstChild('Disable Player Collision').Event:Connect(function(char)
	--Character's part is not collidable
	local function disableCollision(part)
		if part:IsA('BasePart') then
			PhysicsService:SetPartCollisionGroup(part, collisionGroupName)
		end
	end

	for _, part in pairs(char:GetChildren()) do
		disableCollision(part)
	end

	char.ChildAdded:Connect(disableCollision)
end)