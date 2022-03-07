--Kills player
script.Parent.Touched:Connect(function(part)
	local model = part:FindFirstAncestorOfClass('Model')
	if model then 
		local humanoid = model:FindFirstChild('Humanoid')
		if humanoid then -- It's a character
			humanoid.Health = 0
		end
	end
end)