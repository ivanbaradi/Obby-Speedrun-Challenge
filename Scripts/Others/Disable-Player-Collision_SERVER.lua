--ServerStorage
ServerStorage = game.ServerStorage

--Physics Service
PhysicsService = game:GetService('PhysicsService')
--Sets the name of the collision group for players
collisionGroupPlayers = 'Players'
PhysicsService:RegisterCollisionGroup(collisionGroupPlayers)
--Disables players from colliding each other
PhysicsService:CollisionGroupSetCollidable(collisionGroupPlayers, collisionGroupPlayers, false)


ServerStorage:FindFirstChild('Disable Player Collision').Event:Connect(function(char: Model)
	
	--Makes part uncollidable
	local function disableCollision(part: BasePart)
		if part:IsA('BasePart') then
			part.CollisionGroup = collisionGroupPlayers
		end
	end
	
	--Goes through every instance in the player's character
	for _, part in pairs(char:GetChildren()) do
		disableCollision(part)
	end
	
	--Fires whenever an instance gets added to the character
	char.ChildAdded:Connect(disableCollision)
end)