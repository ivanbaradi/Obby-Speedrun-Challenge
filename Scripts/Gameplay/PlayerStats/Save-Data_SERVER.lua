--[[Saves player's stages

	Param(s):
	player stages => player's unlocked stages
	write data => data to be saved
]]
local function saveStages(playerStages, writeData)
	
	--Saves player's unlocked stages
	local unlockedStages = {}

	for i, unlockedStage in pairs(playerStages:GetChildren()) do

		--[[Table includes the following:
		
			stageData = {
				1 => stage number (string),
				2 => player's record of beating the obby,
				3 => true if the player has finishd the stage
			}
		]]
		local stageData = {} 

		--Adds stage number, best time to stageData
		table.insert(stageData, 1, unlockedStage.Name)
		table.insert(stageData, 2, unlockedStage['Best Time'].Value)
		table.insert(stageData, 3, unlockedStage['Has Finished This Stage'].Value)
		print('Saved => Stage '..unlockedStage.Name..' with a time of '..unlockedStage['Best Time'].Value..' secs, Stage completed: '..tostring(unlockedStage['Has Finished This Stage'].Value))

		--Adds stage data to unlokcedStages
		table.insert(unlockedStages, i, stageData)
	end
	
	--Writes unlockedStages in writeData
	table.insert(writeData, 3, unlockedStages)
end

--[[Saves the following data:
	- Max Stage
	- Current Stage
	- Stages (Unlocked Ones)
]]
script.Parent:FindFirstChild('SAVE DATA').Event:Connect(function(player, BackpackStore)

	print("Saving "..player.Name.."'s data")
	
	--[[Table that saves overall player's data. 
	
		writeData = {
			1 => Max Stage
			2 => Current Stage
			3 => List of Unlocked Stages
		}
	]]
	local writeData = {}
	--Gets player's leaderstats
	local leaderstats = player:WaitForChild('leaderstats')

	--Saves player's highest stage
	local maxStage = leaderstats:WaitForChild('Max Stage').Value
	table.insert(writeData, 1, maxStage)
	print('Saved => Max Stage: '..writeData[1])
	
	--Saves player's current Stage
	local currentStage = player:WaitForChild('Current Stage').Value
	table.insert(writeData, 2, currentStage)
	print('Saved => Current Stage: '..writeData[2])
	
	--Saves player's unlocked stages
	saveStages(player:WaitForChild('Stages'), writeData)
	
	--Saves overall data
	BackpackStore:SetAsync('User_'..player.UserId, writeData)
	print(player.Name.."'s data saved")
end)