--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--ServerStorage
ServerStorage = game.ServerStorage
--Prevents the event function from running unneccessary times
debounce = false
--Stage Number
StageNumber = script.Parent

--Fires when the player touches the time starter part
StageNumber.Touched:Connect(function(part: Part)
	
	if debounce then return end
	
	debounce = true
	
	--Gets the player's character
	local character = part:FindFirstAncestorOfClass('Model')
	if not character then debounce = false return end
	
	--Player humanoid
	local humanoid = character:FindFirstChild('Humanoid')
	if not humanoid then debounce = false return end
	
	--Make sure the player's character is not dead
	if humanoid.Health == 0 then 
		print(character.Name.." can't start obby because it died.")
		debounce = false
		return
	end
	
	--Tells another script to start player's timer
	ServerStorage:FindFirstChild('Start Time'):Invoke(game.Players:GetPlayerFromCharacter(character))
	
	debounce = false
end)