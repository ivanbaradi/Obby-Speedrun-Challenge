--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Player
player = game.Players.LocalPlayer
--Timer TextLabel
timer_text = script.Parent
--Client to Client Communications Event
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')
--Current time of the player doing the obby
timer = 0

--[[Records best time on Stage UI

	Param(s):
	timer text => best time in minutes and seconds
	prev stage => previous stage number
]]
function recordBestTimeOnStageUI(timer_text)
	local TimerUI = script:FindFirstAncestorOfClass('ScreenGui')
	local StageUI = TimerUI.Parent:FindFirstChild('Stage UI')
	--Gets the previous stage number to locate the corresponding stage from Stages UI
	local prevStageNumUI = StageUI.Main:FindFirstChild(tostring(player['Current Stage'].Value-1))
	--Sets best time on Stage UI
	prevStageNumUI['Best Time'].Text = timer_text.Text
	
	--Tells server to communicate with other client to play sound effect (See 'Play Sound Effect' LocalScript for code)
	CLIENT_CLIENT:FireServer('Play Sound', {
		soundObj = 'Mini Song' ,
		soundName = 'New Record!'
	})	
	
	--Tells server to communicate with other client to display message (See 'Display Message' LocalScript for code)
	CLIENT_CLIENT:FireServer('Display Message', {
		message = 'New Record of '..timer_text.Text..'!',
		color = Color3.fromRGB(34, 255, 31),
		duration = 4
	})
end

--Gets the current time
ReplicatedStorage:FindFirstChild('Get Current Time').OnClientInvoke = function()
	return timer
end

--Starts the timer
ReplicatedStorage:FindFirstChild('Start Time').OnClientEvent:Connect(function()
	
	print('Timer has started')
	--Time increases
	while true do
		
		--Cannot record time if the player dies (Timer suspended)
		if player.Character:FindFirstChild('Humanoid').Health == 0 then 
			print('Timer suspended due to '..player.Name.."'s death")
			return 
		end
		
		wait(1)
		
		--Timer should not increase after the player is finished with the obby
		if not player['Is Performing Obby'].Value then break end
		
		timer += 1
		print('Time: '..timer..'s')
		--Needs to change time format to 0:00. ex) 30s => 0:30; 90s => 1:30
		timer_text.Text = ReplicatedStorage:FindFirstChild('Change Time Format'):InvokeServer(timer)
	end
	print('Timer has ended')
	
	local playerBeatsTime = ReplicatedStorage:FindFirstChild('Record Best Time'):InvokeServer(timer)
	
	--Records best time on the Stages UI
	if playerBeatsTime then
		recordBestTimeOnStageUI(timer_text)
	end
	
	
	--Resets time 
	timer = 0
	timer_text.Text = '0:00'
end)