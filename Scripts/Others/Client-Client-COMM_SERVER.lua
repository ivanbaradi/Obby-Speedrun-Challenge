--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Client to Client Remote Event
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')

--[[Deals with client to client communications

	Params(s):
	remote event name => name of remote event to fire (Remote Event)
	tuple => collection of data
	
	ex)
	tuple for displaying message = {
		message = 'Hello World',
		color = Color3.fromRBG(10,10,10),
		duration = 4
	}
	
]]
CLIENT_CLIENT.OnServerEvent:Connect(function(player, remoteEventName, tuple)
	CLIENT_CLIENT:FindFirstChild(remoteEventName):FireClient(player, tuple)
end)