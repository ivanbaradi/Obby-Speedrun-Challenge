--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage

--[[Teleports player to another stage 

	Case(s):
	I. Player presses 'Stage 1' button
	II. Player's current stage is 2 or higher

	Param(s):
	player => player object (client)
	char => player's character
	stage number => 'stage number' part from the workspace
]]
function teleporter(player, char, stageNumber)
	
	--Sets player's primary part
	char.PrimaryPart = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
	----Sets the location of the player's spawn orrespawn
	char:SetPrimaryPartCFrame(CFrame.new(Vector3.new(stageNumber.Position.X, stageNumber.Position.Y+3,stageNumber.Position.Z)))
	----Spawns player at that stage number
	char.Parent = workspace
	
	print(char.Name..' has teleported to Stage '..stageNumber.Name)
end

--Fires when the player presses the 'Stage' button to teleport
ReplicatedStorage:FindFirstChild('Teleport Player to Stage').OnServerEvent:Connect(teleporter)


--[[Respawns character to the stage using the player's current stage number (Stage 2 or higher)
	Otherwise, teleport it to SpawnLocation by default

	Param(s):
	player stage number => player's stage number
	char => player's character
]]
function respawnCharacterOnStage(playerStageNumber, char)
	--Otherwise, respawn player on the SpawnPoint
	if playerStageNumber == 1 then return end
	
	teleporter(nil, char, workspace:FindFirstChild(tostring(playerStageNumber)))
end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		wait(.1)
		--Sets to false because the player just respawned
		player:WaitForChild('Is Performing Obby').Value = false
		--Respawns player to the checkpoint
		respawnCharacterOnStage(player:FindFirstChild('Current Stage').Value, char)
	end)
end)