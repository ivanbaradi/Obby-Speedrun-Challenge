--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Player
player = game.Players.LocalPlayer
--Stages UI
Main = script.Parent

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