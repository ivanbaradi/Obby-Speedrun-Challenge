--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Client to Client Remote Event
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')

--[[Deals with client to client communications

	Params(s):
	remote event name => name of remote event to fire (Remote Event)
	tuple => collection of data
	
	ex)
	Play Sound Effect => {soundID = 12345}
	Display Message => {text = "Hello World", color = green, waitTime = 5}
]]
CLIENT_CLIENT.OnServerEvent:Connect(function(player, remoteEventName, tuple)
	CLIENT_CLIENT:FindFirstChild(remoteEventName):FireClient(player, tuple)
end)