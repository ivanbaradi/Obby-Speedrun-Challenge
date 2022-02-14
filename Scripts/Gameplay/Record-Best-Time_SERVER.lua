ReplicatedStorage = game.ReplicatedStorage

--[[Records player's best time

	Param(s):
	player => player object
	timer => best time in seconds
	
	Return(s):
	true => player beats their PR (setting best time)
	false => player did not beat their 
]]
ReplicatedStorage:FindFirstChild('Record Best Time').OnServerInvoke = function(player, timer)
	--Gets player's stages
	local playerStages = player:FindFirstChild('Stages')
	--Gets the player's current stage number from player stages
	local currentStage = playerStages[tostring(player['Current Stage'].Value)]
	
	--The worst time is 2,147,483,647 since it's the max int value
	if timer == 2147483647 or timer < currentStage['Best Time'].Value then
		currentStage['Best Time'].Value = timer
		print(player.Name.."'s new best time ("..timer.." secs) on Stage "..currentStage.Name)
		return true
	end
	
	return false
end