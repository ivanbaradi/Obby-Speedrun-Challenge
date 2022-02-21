--Stage Number
stageNumber = script.Parent
--ReplicatedStorage
ServerStorage = game.ServerStorage

stageNumber.Touched:Connect(function(part)
		
	--Gets the player's character
	local character = part:FindFirstAncestorOfClass('Model')
	if not character then return end
	
	--Player humanoid
	local humanoid = character:FindFirstChild('Humanoid')
	if not humanoid then return end
	
	--Make sure the player's character is not dead
	if humanoid.Health == 0 then 
		print("Can't save checkpoint because "..character.Name..' has died')
		return
	end	
	
	--Gets player from the character
	local player = game.Players:GetPlayerFromCharacter(character)
	--Gets player's leaderstats
	local leaderstats = player.leaderstats
	--Gets player's highest stage number
	local playerStageNumber = leaderstats:WaitForChild('Max Stage')
	--Converts stage number's datatype from string to int
	local stageNumber_INT = tonumber(stageNumber.Name)
	
	--Unlocks new stage if the player hasn't been on it
	if playerStageNumber.Value < stageNumber_INT then
		--unlockNewStage(player, playerStageNumber, stageNumber_INT)
		ServerStorage:FindFirstChild('Unlock Stage'):Fire(player, playerStageNumber, stageNumber_INT)
	end
	
	--Saves checkpoint and sets player's current stage position
	player:WaitForChild('Current Stage').Value = stageNumber_INT
	print('Checkpoint saved!')
end)