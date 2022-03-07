--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--ServerStorage
ServerStorage = game.ServerStorage

--[[Converts the time froms seconds to minutes and seconds
	ex) 250s => 3m 10s
	
	Param(s):
	timer => time in secs

	Return(s):
	converted time => time in mins and secs
]]
function convertSecsToMinsSecs(timer)
	--Minutes
	local minutes = math.floor(timer/60)
	--Seconds from 0 to 59
	local seconds = timer % 60

	if seconds >= 0 and seconds < 10 then
		return minutes..':0'..seconds
	end

	return minutes..':'..seconds
end

--[[Converts the time to regular time format

	ex) 35 => 0:35, 75 => 1:15

	timer => player's best time
]]
function changeTimeFormat(player, timer)
	if timer >= 0 and timer < 10 then
		return '0:0'..timer
	elseif timer >= 10 and timer < 60 then
		return '0:'..timer
	end

	return convertSecsToMinsSecs(timer)
end

--Invoked whenever the elapsed time gets loaded to UI and needs to format the time
ReplicatedStorage:FindFirstChild('Change Time Format').OnServerInvoke = changeTimeFormat
--Invoked whenever the elapsed time gets updated and needs to format the time
ServerStorage:FindFirstChild('Change Time Format').OnInvoke = changeTimeFormat
