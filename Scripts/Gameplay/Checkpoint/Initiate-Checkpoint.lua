--Roblox Services
ServerStorage = game.ServerStorage
ReplicatedStorage = game.ReplicatedStorage

--Stage Number
stageNumber = script.Parent


stageNumber.Touched:Connect(function(part: Part)
		
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
	
	--Tells server to set player's set checkpoint aka set current player's stage
	ServerStorage:FindFirstChild('Set Checkpoint'):Fire(game.Players:GetPlayerFromCharacter(character), tonumber(stageNumber.Name))
end)