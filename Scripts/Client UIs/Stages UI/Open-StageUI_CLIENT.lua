--Button
button = script.Parent
--Main Stage UI component
Main = button.Parent:FindFirstChild('Main')
--Player
player = game.Players.LocalPlayer
--Debouncer
debounce = false
--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Client to Client Communications Event
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')

--Automatically closes Stage UI when the player starts the obby
ReplicatedStorage:FindFirstChild('Auto Close Stage UI').OnClientInvoke = function()
	Main.Visible = false
end

--Opens or closes the UI
button.MouseButton1Click:Connect(function()
	
	if debounce then return end
	
	debounce = true
	
	if player['Is Performing Obby'].Value then --Player tries to open Stages UI while doing the obby
		
		--Tells server to communicate with other client to play error sound
		CLIENT_CLIENT:FireServer('Play Sound', {
			soundObj = 'Sound Effect',
			soundName = 'Error Sound'
		})			
		
		--Gets server to communicate with other client to create message 
		CLIENT_CLIENT:FireServer('Display Message', {
			message = 'Finish the stage first',
			color = Color3.fromRGB(252, 61, 74),
			duration = 5
		})
		
	else
		--Tells server to communicate with other client to play button click
		CLIENT_CLIENT:FireServer('Play Sound', {
			soundObj = 'Sound Effect' ,
			soundName = 'Button Clicked'
		})	
		
		if not Main.Visible then
			Main.Visible = true
		else
			Main.Visible = false
		end
	end
	
	debounce = false
end)