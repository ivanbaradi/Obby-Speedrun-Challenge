--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Button
button = script.Parent
--Playlist
Playlist = workspace:FindFirstChild('Playlist')
--Client to Client COMM Remote Event
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')

--[[Changes the apprearance of the button

	Param(s):
	text => text label of the button
	color => color of the button
]]
function changeButtonState(text, color)
	button.Text = text
	button.BackgroundColor3 = color
end


--Opens or closes the UI
button.MouseButton1Click:Connect(function()
	
	--Tells server to communicate with other client to play button click
	CLIENT_CLIENT:FireServer('Play Sound', {
		soundObj = 'Sound Effect' ,
		soundName = 'Button Clicked'
	})	
	
	if button.Text == 'Music: ON' then --Turns music off
		changeButtonState('Music: OFF', Color3.fromRGB(245, 84, 60))
		Playlist.Volume = 0
	else --Turns music on
		changeButtonState('Music: ON', Color3.fromRGB(36, 255, 6))
		Playlist.Volume = 0.5
	end
end)