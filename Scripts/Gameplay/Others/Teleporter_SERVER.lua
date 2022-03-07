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
	part => destination of the character to teleport at (stage number)
]]
function teleporter(player, char, part)
	
	--Sets player's primary part
	char.PrimaryPart = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
	----Sets the location of the player's spawn orrespawn
	char:SetPrimaryPartCFrame(CFrame.new(part.Position.X, part.Position.Y+3,part.Position.Z) * CFrame.Angles(0, math.rad(270), 0))
	----Spawns player at that stage number
	char.Parent = workspace
end

--Event occurs when the player presses the 'Stage' button to teleport
ReplicatedStorage:FindFirstChild('Teleport Player to Stage').OnServerEvent:Connect(teleporter)
--Event occurs when the player finishes the stage and moves to the next one
ServerStorage:FindFirstChild('Teleport Player to Stage').Event:Connect(teleporter)