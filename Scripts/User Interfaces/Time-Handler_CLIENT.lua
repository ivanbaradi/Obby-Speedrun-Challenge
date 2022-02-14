--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Player
player = game.Players.LocalPlayer
--Timer TextLabel
timer_text = script.Parent

--[[Records best time on Stage UI

	Param(s):
	timer text => best time in minutes and seconds
	prev stage => previous stage number
]]
function recordBestTimeOnStageUI(timer_text)
	local TimerUI = script:FindFirstAncestorOfClass('ScreenGui')
	local StageUI = TimerUI.Parent:FindFirstChild('Stage UI')
	--Gets the current stage number to locate the corresponding stage from Stages UI
	local stageNumUI = StageUI.Main:FindFirstChild(tostring(player['Current Stage'].Value))
	--Sets best time on Stage UI
	stageNumUI['Best Time'].Text = timer_text.Text
end

--[[Displays time on the player's UI

	Param(s):
	timer => current time of the player doing the obby
]]
function displayTime(timer)
	if timer >= 0 and timer < 10 then
		timer_text.Text = '0:0'..timer
	elseif timer >= 10 and timer < 60 then
		timer_text.Text = '0:'..timer
	else
		timer_text.Text = ReplicatedStorage:FindFirstChild('Convert Secs to Mins & Secs'):InvokeServer(timer)
	end
end

--Starts the timer
ReplicatedStorage:FindFirstChild('Start Time').OnClientEvent:Connect(function()
	
	--Current time of the player doing the obby
	local timer = 0
	
	--Time increases
	while player['Is Performing Obby'].Value do
		
		--Cannot record time if the player dies (Timer suspended)
		if player.Character:FindFirstChild('Humanoid').Health == 0 then 
			print('Timer suspended due to '..player.Name.."'s death")
			return 
		end
		
		timer += 1
		displayTime(timer)
		wait(1)
	end
	
	wait(.1)
	local playerBeatsTime = ReplicatedStorage:FindFirstChild('Record Best Time'):InvokeServer(timer)
	
	--Records best time on the Stages UI
	if playerBeatsTime then
		recordBestTimeOnStageUI(timer_text)
	end
	
	timer = 0
	displayTime(timer)
end)