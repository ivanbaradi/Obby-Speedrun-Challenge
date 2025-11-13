--ServerStorage
ServerStorage = game.ServerStorage
--Prevents the event function from running unneccessary times
debounce = false
--Next Stage Number
NextStage = script.Parent:FindFirstChild('Next Stage').Value

--Fires when the player touches the time ender part
script.Parent.Touched:Connect(function(part: Part)
	
	if debounce then return end
	
	debounce = true
	
	--Gets the player's character
	local character = part:FindFirstAncestorOfClass('Model')
	if not character then debounce = false return end
	
	--Player humanoid
	local humanoid = character:FindFirstChild('Humanoid')
	if not humanoid then debounce = false return end
	
	--Gets player
	local player = game.Players:GetPlayerFromCharacter(character)
	
	--Make sure the player's character is not dead
	if humanoid.Health == 0 then 
		print(character.Name.." can't finish obby because it died.")
		debounce = false
		return
	end
	
	--Players should only move to the next stage if they are doing the obby (timer is running)
	if player['Is Performing Obby'].Value then
		--Ends timer
		player['Is Performing Obby'].Value = false
		--Sets true if the player beats this stage the first time
		player['Stages'][player.leaderstats:WaitForChild('Stage').Value]['Has Finished This Stage'].Value = true
		--Teleports player to the next stage
		ServerStorage:FindFirstChild('Teleport Player to Stage'):Fire(nil, character, workspace:FindFirstChild(tostring(NextStage)))
		print(player.Name..' has finished the stage and will be teleported to Stage '..NextStage)
	end
	
	debounce = false
end)