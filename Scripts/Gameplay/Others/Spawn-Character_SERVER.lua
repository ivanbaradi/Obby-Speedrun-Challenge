--ServerStorage
ServerStorage = game.ServerStorage

--Fires everytime the player spawns or respawns
game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		wait(.05)
		--Sets to false because the player just respawned
		player:WaitForChild('Is Performing Obby').Value = false
		--Disables player to player collision
		ServerStorage:FindFirstChild('Disable Player Collision'):Fire(char)
		
		--Respawns player to the their current stage
		if ServerStorage:FindFirstChild('Enable Teleport on Respawn').Value then
			local currentStageNumber = tostring(player:FindFirstChild('Current Stage').Value)
			ServerStorage:FindFirstChild('Teleport Player to Stage'):Fire(nil, char, workspace:FindFirstChild(currentStageNumber))
		end
	end)
end)