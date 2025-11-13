--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--ServerStorage
ServerStorage = game.ServerStorage

--[[Teleports player to another part 

	Parameter(s):
		player: player object
		char: player's character
		part: destination of the character to teleport at (stage number)
]]
function teleporter(player: Player, char: Model, part: Part)
	
	--Sets the location of the player's spawn or respawn
	char.PrimaryPart = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
	char:PivotTo(CFrame.new(part.Position.X, part.Position.Y+3,part.Position.Z) * CFrame.Angles(0, math.rad(270), 0))	
	--Spawns player at that stage number
	char.Parent = workspace
	
	--WARNING: Will produce error when server starts due to indexing nil objects
	--print(player.Name..' has teleported to this part: '..part.Name)
end

--Occurs when the player presses the 'Stage' button to teleport
ReplicatedStorage:FindFirstChild('Teleport Player to Stage').OnServerEvent:Connect(teleporter)
--Occurs when the player finishes the stage or joins the game
ServerStorage:FindFirstChild('Teleport Player to Stage').Event:Connect(teleporter)