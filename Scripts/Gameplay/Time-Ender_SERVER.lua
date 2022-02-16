--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Prevents the event function from running unneccessary times
debounce = false
--Stage that is compatible with time ender
CompatibleStage = script.Parent:FindFirstChild('Compatible Stage')

--Fires when the player touches the time ender part
script.Parent.Touched:Connect(function(part)
	
	if debounce then return end
	
	debounce = true
	
	--Gets the player's character
	local character = part:FindFirstAncestorOfClass('Model')
	--Player humanoid
	local humanoid = character:FindFirstChild('Humanoid')
	
	--Make sure the player's character is not dead
	if humanoid.Health == 0 then 
		print(character.Name.." can't finish obby because it died.")
		debounce = false
		return
	end
	
	--Gets player
	local player = game.Players:GetPlayerFromCharacter(character)
	
	--Ends timer
	if player['Is Performing Obby'].Value and player['Current Stage'].Value == CompatibleStage.Value then -- Player exits obby and time ends
		player['Is Performing Obby'].Value = false
		player['Stages'][player['Current Stage'].Value]['Has Finished This Stage'].Value = true
		wait(.5)
	else	-- Player exits obby
		humanoid.Health = 0
	end
	
	debounce = false
end)