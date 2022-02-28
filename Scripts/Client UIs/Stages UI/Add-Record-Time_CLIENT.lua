--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Player
player = game.Players.LocalPlayer
--Stages UI
Main = script.Parent
--Client to Client Communications Event
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')


--[[Sets a new record (elapsed time) on the UI

	Param(s):
	new record time => new elapsed time to update on the Stage UI after the player beats PR
]]
ReplicatedStorage:FindFirstChild('Update Record Time').OnClientEvent:Connect(function(newRecordTime)
	--Gets the previous stage number to locate the corresponding stage from Stages UI
	local prevStageNumUI = Main:FindFirstChild(tostring(player['Current Stage'].Value-1))
	--Sets best time on Stage UI
	prevStageNumUI['Best Time'].Text = newRecordTime
	
	--Tells server to communicate with other client to play sound effect (See 'Play Sound Effect' LocalScript for code)
	CLIENT_CLIENT:FireServer('Play Sound', {
		soundObj = 'Mini Song' ,
		soundName = 'New Record!'
	})	

	--Tells server to communicate with other client to display message (See 'Display Message' LocalScript for code)
	CLIENT_CLIENT:FireServer('Display Message', {
		message = 'New Record of '..newRecordTime..'!',
		color = Color3.fromRGB(34, 255, 31),
		duration = 4
	})
end)


--[[Unlocks every stage that the player visited

	Param(s):
	stage number => stage number (string)
	best time => player's best time of the stage
	has finished stage => returns true if the player has completed the stage
]]
ReplicatedStorage:FindFirstChild('Unlock Stage On Player Join').OnClientEvent:Connect(function(stageNumber, bestTime, hasFinishedStage)
	
	--Gets stage number from Stages UI
	local stageNumberUI = Main:FindFirstChild(stageNumber)
	--Turns the stage button to green
	stageNumberUI:FindFirstChild('Stage').BackgroundColor3 = Color3.fromRGB(36, 255, 6)
	--Writes best time 
	local bestTimeUI = stageNumberUI:FindFirstChild('Best Time')
	
	if hasFinishedStage then
		stageNumberUI:FindFirstChild('Best Time').Text = ReplicatedStorage:FindFirstChild('Change Time Format'):InvokeServer(bestTime)
		print('Loaded => Stage '..stageNumber..' with a time of '..bestTime..' secs')
	else
		print('Loaded => Stage '..stageNumber)
	end
end)