--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage

--[[Converts the time froms seconds to minutes and seconds
	ex) 250s => 3m 10s
	
	Param(s):
	timer => time in secs

	Return(s):
	converted time => time in mins and secs
]]
ReplicatedStorage:FindFirstChild('Convert Secs to Mins & Secs').OnServerInvoke = function(player, timer)

	--Minutes
	local minutes = math.floor(timer/60)
	--Seconds from 0 to 59
	local seconds = timer % 60

	if seconds >= 0 and seconds < 10 then
		return minutes..':0'..seconds
	end

	return minutes..':'..seconds
end