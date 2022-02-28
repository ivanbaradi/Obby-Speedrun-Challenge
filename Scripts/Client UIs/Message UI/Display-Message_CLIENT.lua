--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Message Text
Message = script.Parent:FindFirstChild('Message')
--Client to Client Communications Event
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')

--[[Displays a message on the client's UI within
	a certain amount of time

	Param(s):
	tuple => {
		message: text to display on the client's UI
		color: color of the text
		duration: amount of seconds before the message disappears
	}
]]
CLIENT_CLIENT:FindFirstChild('Display Message').OnClientEvent:Connect(function(tuple)
	
	--Wait until the message has expired
	if Message.Visible then return end
	
	Message.TextColor3 = tuple['color']
	Message.Text = tuple['message']
	Message.Visible = true
	wait(tuple['duration'])
	Message.Visible = false
end)