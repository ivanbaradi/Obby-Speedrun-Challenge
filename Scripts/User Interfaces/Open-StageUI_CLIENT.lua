--Button
button = script.Parent
--Main Stage UI component
Main = button.Parent:FindFirstChild('Main')
--Error Message
errorMessage = Main.Parent:FindFirstChild('Error Message')
--Player
player = game.Players.LocalPlayer
--Debouncer
debounce = false
--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage



--[[Plays sound effect to the client

	Param(s):
	sound effect => name of the sound effect
]]
function playSoundEffect(soundEffectName)
	local SoundEffect = workspace:FindFirstChild('Sound Effect')
	SoundEffect.SoundId = 'rbxassetid://'..SoundEffect:FindFirstChild(soundEffectName).Value
	SoundEffect:Play()
end



--Automatically closes Stage UI when the player starts the obby
ReplicatedStorage:FindFirstChild('Auto Close Stage UI').OnClientEvent:Connect(function()
	Main.Visible = false
end)



--Displays error message
function displayErrorMessage()
	errorMessage.Visible = true
	wait(5)
	errorMessage.Visible = false
end

--Opens or closes the UI
button.MouseButton1Click:Connect(function()
	
	if debounce then return end
	
	debounce = true
	
	if player['Is Performing Obby'].Value then --Occurs when the player is doing the obby
		playSoundEffect('Error Sound')
		displayErrorMessage()
	else
		playSoundEffect('Button Clicked')
		if not Main.Visible then
			Main.Visible = true
		else
			Main.Visible = false
		end
	end
	
	debounce = false
end)