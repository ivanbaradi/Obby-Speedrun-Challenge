--Button
button = script.Parent
--Stage Number 
stageNumber = button.Parent.Name
--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Player
player = game.Players.LocalPlayer

--[[Changes the stage button color to unlock the stage to teleport to another stage

	Param(s):
	stage number from workspace => 'stage number' part
]]
ReplicatedStorage:FindFirstChild('Unlock Stage').OnClientEvent:Connect(function(stageNumberFromWorkspace)
	--Do not unlock any other stage but the stage that the player landed on
	if stageNumberFromWorkspace ~= stageNumber then return end
	
	button.BackgroundColor3 = Color3.fromRGB(36, 255, 6)
end)

--Teleports player to stage 
button.MouseButton1Click:Connect(function()
	
	--Players cannot teleport to another stage while performing an obby
	if player['Is Performing Obby'].Value then
		print(player.Name.." can't teleport to anther stage because it's performing an obby")
		return
	end
	
	if button.BackgroundColor3 == Color3.fromRGB(36, 255, 6) then
		ReplicatedStorage:FindFirstChild('Teleport Player to Stage'):FireServer(player.Character, workspace:FindFirstChild(stageNumber))
	else
		print('Stage '..stageNumber..' is locked!')
	end
end)