--ServerStorage
local ServerStorage = game.ServerStorage
--DataStore API
DataStore = game:GetService("DataStoreService")
--BackpackStore = DataStore:GetDataStore("PlayerStages")
BackpackStore = DataStore:GetDataStore("Test 1") --For Debugging
--Stage Folder
StageFolder = ServerStorage:FindFirstChild("Stages")

--[[ Loads player's data

	Parameter(s):
	player => client (player) in the server
]]
function loadPlayerStats(player)
	
	--Gets player's stages data
	local playerData = BackpackStore:GetAsync("User_"..player.UserId)
	
	if playerData then
		print(player.Name..' has been in this game.')
	else
		print(player.Name..' is new to the game.')
		--Clones and stores the stage folder in the player object
		StageFolder:Clone().Parent = player
	end
end



function savePlayerStats(player)
	
end


--Fires when the player joins the game
game.Players.PlayerAdded:Connect(function(player)
	
	--Player's leaderstats
	local leaderstats = Instance.new('Folder', player)
	leaderstats.Name = 'leaderstats'
	--Player's highest stage
	local stage = Instance.new('IntValue', leaderstats)
	stage.Name = 'Stage'
	stage.Value = 1
	--Player's current stage position
	local currentStage = Instance.new('IntValue', player)
	currentStage.Name = 'Current Stage'
	currentStage.Value = 1
	
	--Loads player's stats
	loadPlayerStats(player)
	
	--[[ Checks if the player is performing the obby
		
		true => the player is in the obby
		false => the player is still at the stage part
	]]
	local isPerformingObby = Instance.new('BoolValue', player);
	isPerformingObby.Name = 'Is Performing Obby'
end)


--Fires when the player leaves the game
game.Players.PlayerRemoving:Connect(savePlayerStats)