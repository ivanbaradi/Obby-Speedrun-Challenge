--Button
button = script.Parent
--Stage Number 
stageNumber = button.Parent.Name
--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Player
player = game.Players.LocalPlayer
--Client to Client Communications Event
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')

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
	
	--Cannot teleport because the player is dead or did not unlock stage (color is still red)
	if player.Character:FindFirstChild('Humanoid').Health == 0 or button.BackgroundColor3 ~= Color3.fromRGB(36, 255, 6) then
		
		--Tells server to communicate with other client to play error sound
		CLIENT_CLIENT:FireServer('Play Sound', {
			soundObj = 'Sound Effect' ,
			soundName = 'Error Sound'
		})	
		
		return
	end
	
	--Tells server to communicate with other client to play button click
	CLIENT_CLIENT:FireServer('Play Sound', {
		soundObj = 'Sound Effect' ,
		soundName = 'Button Clicked'
	})	
	
	--Tells server to teleport player to another stage
	ReplicatedStorage:FindFirstChild('Teleport Player to Stage'):FireServer(player.Character, workspace:FindFirstChild(stageNumber))
end)