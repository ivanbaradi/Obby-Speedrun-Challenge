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
function recordBestTimeOnStageUI(timer_text, prevStage)
	local TimerUI = script:FindFirstAncestorOfClass('ScreenGui')
	local StageUI = TimerUI.Parent:FindFirstChild('Stage UI')
	--Stage number from Stage UI
	local stageNumUI = StageUI.Main:FindFirstChild(prevStage)
	--Sets best time on Stage UI
	stageNumUI['Best Time'].Text = timer_text.Text
end


--[[Converts the time froms seconds to minutes and seconds
	ex) 250s => 3m 10s
	
	Param(s):
	timer => time in secs

	Return(s):
	converted time => time in mins and secs
]]
function convertSecsToMinSecs(timer)
	
	--Minutes
	local minutes = math.floor(timer/60)
	--Seconds from 0 to 59
	local seconds = timer % 60
	
	if seconds >= 0 and seconds < 10 then
		return minutes..':0'..seconds
	end
	
	return minutes..':'..seconds
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
		timer_text.Text = convertSecsToMinSecs(timer)
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
	
	local playerBeatsTime, prevStage = ReplicatedStorage:FindFirstChild('Record Best Time'):InvokeServer(timer)
	
	--Records best time on the Stages UI
	if playerBeatsTime then
		recordBestTimeOnStageUI(timer_text, prevStage)
	end
	
	timer = 0
	displayTime(timer)
end)