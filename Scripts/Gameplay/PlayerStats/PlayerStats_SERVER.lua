--ReplicatesStorage
ReplicatedStorage = game.ReplicatedStorage
--ServerStorage
ServerStorage = game.ServerStorage
--DataStore API
DataStore = game:GetService("DataStoreService")
--BackpackStore = DataStore:GetDataStore("NinjaData")
BackpackStore = DataStore:GetDataStore("Test 9") --For Debugging 
--Stage Folder (For new players)
StageFolder = ServerStorage:FindFirstChild("Stages")


--[[Fires when the player joins the game

	If the player has played this game, then it
	will communicate with the 'Load Data' script
	to load player stats.
]]
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
		script:FindFirstChild('LOAD DATA'):Fire(player, readData)
	else
		print(player.Name..' is new to the game.')
		--Adds Stages folder to player
		StageFolder:Clone().Parent = player
	end
end)


--[[Fires when the player leaves the game

	Communicates with the 'Save Data' Script to save
	player's stats. 
]]
game.Players.PlayerRemoving:Connect(function(player)
	script:FindFirstChild('SAVE DATA'):Fire(player, BackpackStore)
end)