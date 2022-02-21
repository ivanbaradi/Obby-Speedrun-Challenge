--Button
button = script.Parent
--Stage Number 
stageNumber = button.Parent.Name
--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Player
player = game.Players.LocalPlayer
--Client to Client Communications Event
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')
--Debouncer
debounce = false

--[[Tells server to communicate with other client to play error sound

	Param(s):
	_soundName = name of the sound to play
]]
function playSound(_soundName)
	CLIENT_CLIENT:FireServer('Play Sound', {
		soundObj = 'Sound Effect',
		soundName = _soundName
	})	
end

--[[Tells server to communicate with other client to send a message 

	_message = text (str) to send to the server
]]
function sendMessage(_message)
	CLIENT_CLIENT:FireServer('Display Message', {
		message = _message,
		color = Color3.fromRGB(252, 61, 74),
		duration = 5		
	})
end

--[[Changes the stage button color to unlock the stage to teleport to another stage

	Param(s):
	stage number from workspace => 'stage number' part
]]
ReplicatedStorage:FindFirstChild('Unlock Stage').OnClientEvent:Connect(function(stageNumberFromWorkspace)
	--Do not unlock any other stage but the stage that the player landed on
	if stageNumberFromWorkspace ~= stageNumber then return end
	
	button.BackgroundColor3 = Color3.fromRGB(36, 255, 6)
end)

--Teleports player to stage 
button.MouseButton1Click:Connect(function()
	
	if debounce then return end

	debounce = true
	wait(.1)
	
	--Gets player's humanoid
	local humanoid = player.Character:FindFirstChild('Humanoid')
	
	--Cannot teleport because the player is dead
	if humanoid.Health == 0 then
		playSound('Error Sound')
		sendMessage("Dead players can't teleport")
		debounce = false
		return
	end

	--Cannot teleport because the player is doing the obby (Illegal teleport)
	if player['Is Performing Obby'].Value then
		playSound('Error Sound')
		sendMessage('You seriously have to do that?')
		humanoid.Health = 0
		debounce = false
		return
	end

	--Tells server to communicate with other client to play button click
	playSound('Button Clicked')	
	
	--Tells server to teleport player to another stage
	ReplicatedStorage:FindFirstChild('Teleport Player to Stage'):FireServer(player.Character, workspace:FindFirstChild(stageNumber))
	debounce = false
end)