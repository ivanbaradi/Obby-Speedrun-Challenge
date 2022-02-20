--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Prevents the event function from running unneccessary times
debounce = false
--Stage Number
StageNumber = script.Parent

--Fires when the player touches the time starter part
StageNumber.Touched:Connect(function(part)
	
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
	
	--Gets player
	local player = game.Players:GetPlayerFromCharacter(character)
	
	--Starts timer
	if not player['Is Performing Obby'].Value then -- Player enters obby and time starts
		player['Is Performing Obby'].Value = true
		--Tells the Stage UI to automatically close itself (See 'Open-StageUI_CLIENT' file)
		ReplicatedStorage:FindFirstChild('Auto Close Stage UI'):FireClient(player)
		--Tells the Timer UI to start the time (See 'Time-Handler_CLIENT' file)
		ReplicatedStorage:FindFirstChild('Start Time'):FireClient(player)
		print(player.Name..' has started the obby')
	end
	
	debounce = false
end)