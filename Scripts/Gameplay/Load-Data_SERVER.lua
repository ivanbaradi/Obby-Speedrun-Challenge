--[[Loads player's unlocked stages

	Param(s):
	player stages folder => "Stages" Folder
	read data stages => readData[3] or Unlocked Stages
]]
function loadStages(player, playerStagesFolder, readDataStages)

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
		--Unlocks stage and writes best time on the client's stage UI
		game.ReplicatedStorage:FindFirstChild('Unlock Stage On Player Join'):FireClient(player, loadStage.Name, loadBestTime.Value, loadHasFinishedStage.Value)
	end
end

--[[Loads player's data

	Read Data contains the following:
	- readData[1] => Highest Stage
	- readData[2] => Current Stage
	- readData[3] => Stages (Unlocked)
]]
script.Parent:FindFirstChild('LOAD DATA').Event:Connect(function(player, readData)

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
	loadStages(player, Stages, readData[3])

	print(player.Name.."'s data loaded")
end)