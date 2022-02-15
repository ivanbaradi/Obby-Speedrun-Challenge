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
		
		--Needs to change time format to 0:00. ex) 30s => 0:30; 90s => 1:30
		timer_text.Text = ReplicatedStorage:FindFirstChild('Change Time Format'):InvokeServer(timer)
		wait(1)
	end
	
	local playerBeatsTime = ReplicatedStorage:FindFirstChild('Record Best Time'):InvokeServer(timer)
	
	--Records best time on the Stages UI
	if playerBeatsTime then
		recordBestTimeOnStageUI(timer_text)
	end
	
	--Resets time after 
	timer = 0
	timer_text.Text = '0:00'
end)