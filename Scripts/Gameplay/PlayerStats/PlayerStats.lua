--ReplicatesStorage
ReplicatedStorage = game.ReplicatedStorage
--ServerStorage
ServerStorage = game.ServerStorage
--DataStore API
DataStore = game:GetService("DataStoreService")
BackpackStore = DataStore:GetDataStore("NinjaData")
--BackpackStore = DataStore:GetDataStore("Test29") --For Debugging 
--Stage Folder (For new players)
StageFolder = ServerStorage:FindFirstChild("Stages")
--Players
Players = game.Players
--Save Data BindableEvent
saveDataEvent = script:FindFirstChild('SAVE DATA')
--Save Data Enabled?
canSave = ServerStorage:FindFirstChild('Enable Save Data').Value


--[[Fires when the player joins the game

	If the player has played this game, then it
	will communicate with the 'Load Data' script
	to load player stats.
]]
Players.PlayerAdded:Connect(function(player: Player)
	
	--Player's leaderstats
	local leaderstats = Instance.new('Folder', player)
	leaderstats.Name = 'leaderstats'
	
	--Player's current stage 
	local currentStage = Instance.new('IntValue', leaderstats)
	currentStage.Name = 'Stage'
	currentStage.Value = 1
	
	--Player's max stage
	local maxStage = Instance.new('IntValue', leaderstats)
	maxStage.Name = 'Max Stage'
	maxStage.Value = 1
	
	--Player's elapsed time (current time of completing the obby)
	local elapseTime = Instance.new('IntValue', player)
	elapseTime.Name = 'Elapsed Time'
	elapseTime.Value = 0
	
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
	
	if not canSave then 
		print("Unable to save data because 'Enable Save Data' is false")
		return 
	end
	
	--Auto saves player's data
	while wait(10) do
		saveDataEvent:Fire(player, BackpackStore)
		--print('Autosaved!')
	end
end)



--[[Fires when the player leaves the game

	Communicates with the 'Save Data' Script to save
	player's stats. 
]]
Players.PlayerRemoving:Connect(function(player: Player)
	if not canSave then 
		print("Unable to save data because 'Enable Save Data' is false")
		return 
	end
	saveDataEvent:Fire(player, BackpackStore)
end)