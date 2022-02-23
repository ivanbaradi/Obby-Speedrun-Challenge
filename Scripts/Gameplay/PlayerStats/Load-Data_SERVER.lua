--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage

--[[Loads player's unlocked stages

	Param(s):
	player stages folder => "Stages" Folder
	read data stages => readData[3] (Unlocked Stages from DataStore)
]]
function loadStages(player, playerStagesFolder, readDataStages)
	
	print('Loading '..player.Name.."'s unlocked stages")

	for _, unlockedStage in pairs(readDataStages) do

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
		print('Loaded => Stage '..loadStage.Name..' with a time of '..loadBestTime.Value..' secs, Stage completed: '..tostring(loadHasFinishedStage.Value))
		
		--Unlocks stage and writes best time on the client's stage UI
		ReplicatedStorage:FindFirstChild('Unlock Stage On Player Join'):FireClient(player, loadStage.Name, loadBestTime.Value, loadHasFinishedStage.Value)
	end
end

--[[Loads player's data

	Param(s):
	player => player object
	readData => {
		1 => Max Stage,
		2 => Current Stage,
		3 => List of UnlockedStages
	}
]]
script.Parent:FindFirstChild('LOAD DATA').Event:Connect(function(player, readData)

	--Gets player's stages data

	print("Loading "..player.Name.."'s data")

	--Loads player's highest stage
	player.leaderstats['Max Stage'].Value = readData[1]
	print("Loaded => Max Stage: "..player.leaderstats['Max Stage'].Value)

	--Loads player's current stage
	player['Current Stage'].Value = readData[2]
	print("Loaded => Current Stage: "..player['Current Stage'].Value)

	--Loads player's stages
	local Stages = Instance.new('Folder', player)
	Stages.Name = 'Stages'
	loadStages(player, Stages, readData[3])

	print(player.Name.."'s data loaded")
end)