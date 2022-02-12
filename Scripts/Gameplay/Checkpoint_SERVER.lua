--Stage Number
stageNumber = script.Parent
--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage

--[[Adds a stage number to the player's stages,
	because the player unlocked a new stage


	Param(s):
	player stages => stages that the player unlocked
]]
function addStageNumberToStages(playerStages)
	
	--Adds stage to the player's stage folder
	local newStage = Instance.new('StringValue', playerStages)
	newStage.Name = stageNumber.Name
	
	--Best Time
	local bestTime = Instance.new('IntValue', newStage)
	bestTime.Name = 'Best Time'
	bestTime.Value = 2147483647
end


--[[Unlocks new stage, and sets highest stage number

	Param(s):
	player => player object
	player stage number => player's highest stage number
	stage number => 'stage number' part as a integer
]]
function unlockNewStage(player, playerStageNumber, stageNumber_INT)
	playerStageNumber.Value = stageNumber_INT
	addStageNumberToStages(player:FindFirstChild('Stages'))
	ReplicatedStorage:FindFirstChild('Unlock Stage'):FireClient(player, stageNumber.Name)
	print(player.Name..' unlocked Stage '..stageNumber.Name)
end



stageNumber.Touched:Connect(function(part)
		
	--Gets the player's character
	local character = part:FindFirstAncestorOfClass('Model')
	--Player humanoid
	local humanoid = character:FindFirstChild('Humanoid')
	
	--Make sure the player's character is not dead
	if humanoid.Health == 0 then 
		print("Can't save checkpoint because "..character.Name..' has died')
		return
	end	
	
	--Gets player from the character
	local player = game.Players:GetPlayerFromCharacter(character)
	--Gets player's leaderstats
	local leaderstats = player.leaderstats
	--Gets player's highest stage number
	local playerStageNumber = leaderstats:WaitForChild('Stage')
	--Converts stage number's datatype from string to int
	local stageNumber_INT = tonumber(stageNumber.Name)
	
	--Unlocks new stage if the player hasn't been on it
	if playerStageNumber.Value < stageNumber_INT then
		unlockNewStage(player, playerStageNumber, stageNumber_INT)
	end
	
	--Saves checkpoint and sets player's current stage position
	player:WaitForChild('Current Stage').Value = stageNumber_INT
	print('Checkpoint saved!')
end)