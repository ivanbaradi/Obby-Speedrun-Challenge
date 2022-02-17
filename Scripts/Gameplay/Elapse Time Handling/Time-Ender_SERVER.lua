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
	--Gets player
	local player = game.Players:GetPlayerFromCharacter(character)
	
	--Make sure the player's character is not dead
	if humanoid.Health == 0 then 
		print(character.Name.." can't finish obby because it died.")
		debounce = false
		return
	end
	
	--Ends timer
	if player['Is Performing Obby'].Value and player['Current Stage'].Value == CompatibleStage.Value then -- Player exits obby and time ends
		player['Is Performing Obby'].Value = false
		player['Stages'][player['Current Stage'].Value]['Has Finished This Stage'].Value = true
		wait(.5)
	else
		
		--[[Cheating is not allowed! Player tries to cheat the obby by teleporting to 
			another stage and touching the previous finish line.
		]]
		if player['Is Performing Obby'].Value then
			local CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')
			CLIENT_CLIENT:FindFirstChild('Display Message'):FireClient(player, {
				message = 'Nice try for cheating :/',
				color = Color3.fromRGB(252, 61, 74),
				duration = 5
			})
		end
		
		humanoid.Health = 0
	end
	
	debounce = false
end)