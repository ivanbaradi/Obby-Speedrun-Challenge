--ServerStorage
ServerStorage = game.ServerStorage
--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage

--[[Records player's best time

	Param(s):
	player => player object
	timer => best time in seconds
	
	Return(s):
	true => player beats their PR (setting best time)
	false => player did not beat their 
]]
function recordBestTime(player, timer)
	wait(.5)
	--Gets player's stages
	local playerStages = player:FindFirstChild('Stages')
	--Gets the player's previous stage number from player stages
	local prevStage = playerStages[tostring(player['Current Stage'].Value)-1]

	--The worst time is 2,147,483,647 since it's the max int value
	if timer == 2147483647 or timer < prevStage['Best Time'].Value then
		prevStage['Best Time'].Value = timer
		print(player.Name.."'s new best time ("..timer.." secs) on Stage "..prevStage.Name)
		return true
	end

	return false
end


--Starts the timer
ServerStorage:FindFirstChild('Handle Time').Event:Connect(function(player)
	
	--Needs to change time format to 0:00. ex) 30s => 0:30; 90s => 1:30
	local reformattedTime

	print('Timer has started')
	while true do

		--Cannot record time if the player dies (Timer suspended)
		if player.Character:FindFirstChild('Humanoid').Health == 0 then 
			player['Elapsed Time'].Value = 0
			print('Timer suspended due to '..player.Name.."'s death")
			return 
		end

		wait(1)

		--Timer should not increase after the player is finished with the obby
		if not player['Is Performing Obby'].Value then break end
	
		--Updates time here
		player['Elapsed Time'].Value += 1
		print('Time: '..tostring(player['Elapsed Time'].Value)..'s')
		reformattedTime = ServerStorage:FindFirstChild('Change Time Format'):Invoke(nil, player['Elapsed Time'].Value)
		ReplicatedStorage:FindFirstChild('Display New Elapsed Time'):FireClient(player, reformattedTime)
	end
	print('Timer has ended')
	

	--Records best time on the Stages UI
	if recordBestTime(player, player['Elapsed Time'].Value) then 
		ReplicatedStorage:FindFirstChild('Update Record Time'):FireClient(player, reformattedTime)
	end

	--Resets time 
	player['Elapsed Time'].Value = 0
	ReplicatedStorage:FindFirstChild('Display New Elapsed Time'):FireClient(player, '0:00')
end)