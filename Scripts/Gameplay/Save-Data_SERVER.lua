--[[Saves player's stages

	Param(s):
	player stages => player's unlocked stages
	write data => data to be saved
]]
local function saveStages(playerStages, writeData)
	--Saves player's unlocked stages
	local saveStages = {}

	for i, unlockedStage in pairs(playerStages:GetChildren()) do

			--[[Includes the stage number, best time, and 'Has Finished This Stage' state; 
				ex) stageData = {2, 60, true} ]]
		local stageData = {} 

		--Adds stage number, best time to stageData
		table.insert(stageData, 1, unlockedStage.Name)
		table.insert(stageData, 2, unlockedStage['Best Time'].Value)
		table.insert(stageData, 3, unlockedStage['Has Finished This Stage'].Value)
		print('Saved => Stage '..unlockedStage.Name..' with a time of '..unlockedStage['Best Time'].Value..' secs, Stage completed: '..tostring(unlockedStage['Has Finished This Stage'].Value))

		--Adds stage data to saveStages
		table.insert(saveStages, i, stageData)
	end

	table.insert(writeData, 3, saveStages)
end

--[[Saves the following data:
	- Max Stage
	- Current Stage
	- Stages (Unlocked Ones)
]]
script.Parent:FindFirstChild('SAVE DATA').Event:Connect(function(player, BackpackStore)

	--wait(.1)
	print("Saving "..player.Name.."'s data")
	local writeData = {}
	local leaderstats = player:WaitForChild('leaderstats')

	--Saves player's highest stage
	local highestStage = leaderstats:WaitForChild('Max Stage').Value
	table.insert(writeData, 1, highestStage)
	print('Highest Stage: '..highestStage..' saved!')
	--Saves player's current Stage
	local currentStage = player:WaitForChild('Current Stage').Value
	table.insert(writeData, 2, currentStage)
	print('Current Stage: '..currentStage..' saved!')
	--Saves player's unlocked stages
	saveStages(player:WaitForChild('Stages'), writeData)

	BackpackStore:SetAsync('User_'..player.UserId, writeData)
	print(player.Name.."'s data saved")
end)