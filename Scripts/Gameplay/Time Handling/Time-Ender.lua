--ServerStorage
ServerStorage = game.ServerStorage
--Prevents the event function from running unneccessary times
debounce = false
--Current Stage
Stage = script.Parent
--Next Stage
NextStage = Stage:FindFirstChild('Next Stage')

--Fires when the player touches the time ender part
Stage.Touched:Connect(function(part: Part)
	
	if debounce then return end
	
	debounce = true
	
	--Gets the player's character
	local character = part:FindFirstAncestorOfClass('Model')
	if not character then debounce = false return end
	
	--Player humanoid
	local humanoid = character:FindFirstChild('Humanoid')
	if not humanoid then debounce = false return end
	
	if humanoid.Health == 0 then 
		print(character.Name.." can't finish obby because they died.")
		debounce = false
		return
	end
	
	--Tells another script to end player's timer
	ServerStorage:FindFirstChild('End Time'):Invoke(game.Players:GetPlayerFromCharacter(character), NextStage.Value)
	
	debounce = false
end)