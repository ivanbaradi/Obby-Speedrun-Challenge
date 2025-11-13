ServerStorage = game.ServerStorage
ReplicatedStorage = game.ReplicatedStorage

--[[Sets a checkpoint whenever a player teleports to another stage

	Parameter(s):
		player: player to configure checkpoint
		stageNumber: player's current stage number to set
]]
function setCheckpoint(player: Player, stageNumber: number)

	--Gets player's leaderstats
	local leaderstats = player.leaderstats
	local maxStage = leaderstats:WaitForChild('Max Stage')

	--Unlocks new stage if the player hasn't been on it
	if maxStage.Value < stageNumber then
		ServerStorage:FindFirstChild('Unlock Stage'):Fire(player, maxStage, stageNumber)
	end

	--Saves checkpoint and sets player's current stage position
	leaderstats:WaitForChild('Stage').Value = stageNumber
	--Tells client to set current stage number and best time on 'Current Stage' UI
	ReplicatedStorage:FindFirstChild('Set Player Current Stage on UI'):FireClient(player)
	--print(player.Name..' is now at Stage '..stageNumber)
end


ServerStorage:FindFirstChild('Set Checkpoint').Event:Connect(setCheckpoint)