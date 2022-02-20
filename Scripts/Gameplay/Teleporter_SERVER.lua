--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--ServerStorage
ServerStorage = game.ServerStorage

--[[Teleports player to another area 

	Case(s):
	I. Player presses 'Stage' button
	II. Player dies

	Param(s):
	player => player object (client)
	char => player's character
	part => destination of the character to teleport at (stage number or Port B)
]]
function teleporter(player, char, part)
	
	--Sets player's primary part
	char.PrimaryPart = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
	----Sets the location of the player's spawn orrespawn
	char:SetPrimaryPartCFrame(CFrame.new(Vector3.new(part.Position.X-20, part.Position.Y+3,part.Position.Z)))
	----Spawns player at that stage number
	char.Parent = workspace
	
	if part.Name ~= 'Port B' then
		print(char.Name..' has teleported to Stage '..part.Name)
	end
end

--Event occurs when the player presses the 'Stage' button to teleport
ReplicatedStorage:FindFirstChild('Teleport Player to Stage').OnServerEvent:Connect(teleporter)
--Event occurs after the player finished Stage 6 and got teleported to the finish area
ServerStorage:FindFirstChild('Teleport Player to Port B').Event:Connect(teleporter)
--Event occurs when the player finishes the stage and moves to the next one
ServerStorage:FindFirstChild('Teleport Player to Next Stage').Event:Connect(teleporter)

--Teleports player to the current stage after respawn
game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		wait(.05)
		--Sets to false because the player just respawned
		player:WaitForChild('Is Performing Obby').Value = false
		--Respawns player to the their current stage they want to do
		teleporter(nil, char, workspace:FindFirstChild(tostring(player:FindFirstChild('Current Stage').Value)))
	end)
end)