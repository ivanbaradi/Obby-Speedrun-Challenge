--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--ServerStorage
ServerStorage = game.ServerStorage


--[[Adds a stage number to the player's stages,
	because the player unlocked a new stage


	Param(s):
	player stages => stages that the player unlocked
	stage number part => stage number's (Part) name
]]
function addStageNumberToStages(playerStages, stageNumberPart)

	--Adds stage to the player's stage folder
	local newStage = Instance.new('StringValue', playerStages)
	newStage.Name = stageNumberPart

	--Best Time
	local bestTime = Instance.new('IntValue', newStage)
	bestTime.Name = 'Best Time'
	bestTime.Value = 2147483647

	--Has Played This Stage
	local hasPlayedThisStage = Instance.new('BoolValue', newStage)
	hasPlayedThisStage.Name = 'Has Finished This Stage'
	hasPlayedThisStage.Value = false
end


--[[Unlocks new stage, and sets highest stage number

	Param(s):
	player => player object
	player stage number => player's highest stage number
	stage number => 'stage number's part name (int)
]]
ServerStorage:FindFirstChild('Unlock Stage').Event:Connect(function (player, playerStageNumber, stageNumberPart_INT)
	--Sets the player's new max stage
	playerStageNumber.Value = stageNumberPart_INT
	--Converts it back to string
	local stageNumberPart = tostring(stageNumberPart_INT)
	--Adds another stage to the player's stages
	addStageNumberToStages(player:FindFirstChild('Stages'), stageNumberPart)
	--Tells client to unlock a stage in the Stages UI (See 'Teleport To Stage' LocalScript for code)
	ReplicatedStorage:FindFirstChild('Unlock Stage'):FireClient(player, stageNumberPart)
	print(player.Name..' unlocked Stage '..tostring(stageNumberPart_INT))
end)