--ReplicatesStorage
ReplicatedStorage = game.ReplicatedStorage
--ServerStorage
ServerStorage = game.ServerStorage
--DataStore API
DataStore = game:GetService("DataStoreService")
--BackpackStore = DataStore:GetDataStore("NinjaData")
BackpackStore = DataStore:GetDataStore("Test 5") --For Debugging 
--Stage Folder (For new players)
StageFolder = ServerStorage:FindFirstChild("Stages")

--[[Loads player's data

	readData[1] => Highest Stage
	readData[2] => Current Stage
	readData[3] => Player's Stages (Unlocked)
]]
function loadPlayerStats(readData, player)
	
	--[[Loads player's unlocked stages
	
		Param(s):
		player stages folder => "Stages" Folder
	]]
	local function loadStages(playerStagesFolder)
		
		for _, unlockedStage in pairs(readData[3]) do

			--Loads stage to the player's "Stages" folder
			local loadStage = Instance.new('StringValue', playerStagesFolder)
			loadStage.Name = unlockedStage[1]
			--Loads player's best time to the stage
			local loadBestTime = Instance.new('IntValue', loadStage)
			loadBestTime.Name = 'Best Time'
			loadBestTime.Value = unlockedStage[2]
			--Loads Finished Stage state to the stage
			local loadHasFinishedStage = Instance.new('BoolValue', loadStage)
			loadHasFinishedStage.Name = 'Has Finished This Stage'
			loadHasFinishedStage.Value = unlockedStage[3]
			--Unlocks stage and writes best time on the client's stage UI
			ReplicatedStorage:FindFirstChild('Unlock Stage On Player Join'):FireClient(player, loadStage.Name, loadBestTime.Value, loadHasFinishedStage.Value)
		end
	end
	
	--Gets player's stages data
	
	print("Loading "..player.Name.."'s data")
	
	--Loads player's highest stage
	player.leaderstats['Max Stage'].Value = readData[1]
	print("Highest Stage: "..player.leaderstats['Max Stage'].Value)
	
	--Loads player's current stage
	player['Current Stage'].Value = readData[2]
	print("Current Stage: "..player['Current Stage'].Value)
	
	--Loads player's stages
	local Stages = Instance.new('Folder', player)
	Stages.Name = 'Stages'
	loadStages(Stages)
	
	print(player.Name.."'s data loaded")
end


--[[Saves player's data

	Data:
	I. Highest Stage
	II. Current Stage
	III. Stage Folder
]]
function savePlayerStats(player)
	
	
	
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
end


--Fires when the player joins the game
game.Players.PlayerAdded:Connect(function(player)
	
	--Player's leaderstats
	local leaderstats = Instance.new('Folder', player)
	leaderstats.Name = 'leaderstats'
	--Player's highest stage
	local highestStage = Instance.new('IntValue', leaderstats)
	highestStage.Name = 'Max Stage'
	highestStage.Value = 1
	--Player's current stage 
	local currentStage = Instance.new('IntValue', player)
	currentStage.Name = 'Current Stage'
	currentStage.Value = 1
	
	--Checks if the player is performing the obby
	local isPerformingObby = Instance.new('BoolValue', player);
	isPerformingObby.Name = 'Is Performing Obby'
	
	--Loads player data
	local readData = BackpackStore:GetAsync("User_"..player.UserId)
	
	if readData then
		loadPlayerStats(readData, player)
	else
		print(player.Name..' is new to the game.')
		--Clones and stores the stage folder in the player object
		StageFolder:Clone().Parent = player
	end
end)


--Fires when the player leaves the game
game.Players.PlayerRemoving:Connect(savePlayerStats)