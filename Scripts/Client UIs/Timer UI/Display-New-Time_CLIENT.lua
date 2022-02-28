--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Player
player = game.Players.LocalPlayer
--Timer TextLabel
timer_text = script.Parent

--Gets a request from the server to update the time in text
ReplicatedStorage:FindFirstChild('Display New Elapsed Time').OnClientEvent:Connect(function (elapedTime_FORMATTED)
	timer_text.Text = elapedTime_FORMATTED
end)



