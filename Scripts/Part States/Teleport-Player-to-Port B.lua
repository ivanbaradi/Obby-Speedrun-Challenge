--Teleports players to Port B after finishing Stage 6
script.Parent.Touched:Connect(function(part)
	
	--Gets player's character
	local char = part:FindFirstAncestorOfClass('Model')
	if not char then return end
	
	--Checks if the object being touched is from a character
	local humanoid = char:FindFirstChild('Humanoid')
	if not humanoid then return end
	
	game.ServerStorage:FindFirstChild('Teleport Player to Port B'):Fire(nil, char, workspace:FindFirstChild('Port B'))
end)