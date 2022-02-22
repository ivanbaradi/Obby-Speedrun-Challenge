--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Player
player = game.Players.LocalPlayer
--UI
UI = script.Parent
--Current Stage (Text)
currentStageText = UI:FindFirstChild('Current Stage Number')
--Current Best Time (Text)
currentBestTimeText = UI:FindFirstChild('Current Best Time')

--Changes player's current stage & best time everytime player gets teleported to another stage
ReplicatedStorage:FindFirstChild('Set Player Current Stage on UI').OnClientEvent:Connect(function()
	
	--Gets current stage and sets it
	local currentStage = player:WaitForChild('Current Stage').Value
	currentStageText.Text = 'Stage '..currentStage
	--Gets player's unlocked stages
	local Stages = player:WaitForChild('Stages')
	--Gets player's current stage from 'Stages' Folder
	local stageNumberFromFolder = Stages:WaitForChild(tostring(currentStage))
	
	--Sets current best time
	if stageNumberFromFolder:WaitForChild('Has Finished This Stage').Value then
		local bestTime = stageNumberFromFolder:WaitForChild('Best Time').Value
		currentBestTimeText.Text = ReplicatedStorage:FindFirstChild('Change Time Format'):InvokeServer(bestTime)
	else
		currentBestTimeText.Text = '---'
		print('No best time is recorded on Stage '..currentStage)
	end
end)