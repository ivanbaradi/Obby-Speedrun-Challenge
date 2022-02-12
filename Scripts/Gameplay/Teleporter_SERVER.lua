--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage

--[[Teleports player to another stage 

	Case(s):
	I. Player presses 'Stage' button
	II. Player dies

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

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		wait(.1)
		--Sets to false because the player just respawned
		player:WaitForChild('Is Performing Obby').Value = false
		--Respawns player to the their current stage they want to do
		teleporter(nil, char, workspace:FindFirstChild(tostring(player:FindFirstChild('Current Stage').Value)))
	end)
end)