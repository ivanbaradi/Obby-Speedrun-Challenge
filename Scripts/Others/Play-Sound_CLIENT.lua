ReplicatedStorage = game.ReplicatedStorage
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')

--[[Plays Sound to the client (player)

	Param(s):
	tuple = {
		soundObj: 'Sound' Instance
		soundName: name of the sound to play
	}
]]
CLIENT_CLIENT:FindFirstChild('Play Sound').OnClientEvent:Connect(function(tuple)
	local SoundEffect = workspace:FindFirstChild(tuple['soundObj'])
	SoundEffect.SoundId = 'rbxassetid://'..SoundEffect:FindFirstChild(tuple['soundName']).Value
	SoundEffect:Play()
end)