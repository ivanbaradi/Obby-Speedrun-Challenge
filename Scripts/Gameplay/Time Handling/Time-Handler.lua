--Roblox Services
ServerStorage = game.ServerStorage
ReplicatedStorage = game.ReplicatedStorage

--RemoteEvents
DisplayNewElapsedTime = ReplicatedStorage:FindFirstChild('Display New Elapsed Time')

--Bindable Functions & Events
HandleTime = ServerStorage:FindFirstChild('Handle Time')
StartTime = ServerStorage:FindFirstChild('Start Time')
EndTime = ServerStorage:FindFirstChild('End Time')



--[[Records player's best time

	Parameter(s):
		player: player object
		old stage: need to record the player's best time at that stage
		timer: best time in seconds
	
	Return(s):
		boolean: detection of player beating best time
]]
function recordBestTime(player: Player, oldStage: number, timer: number) : boolean
	--Gets player's stages
	local playerStages = player:FindFirstChild('Stages')
	--Gets the player's previous stage number from player stages
	local prevStage = playerStages[tostring(oldStage)]

	--The worst time is 2,147,483,647 since it's the max int value
	if timer == 2147483647 or timer < prevStage['Best Time'].Value then
		prevStage['Best Time'].Value = timer
		print(player.Name.."'s new best time ("..timer.." secs) on Stage "..prevStage.Name)
		return true
	end

	return false
end



--[[Starts the timer

	Parameter(s):
		player: target player
]]
function handleTime(player: Player)
	
	--[[Checks whether the player's character is dead
	
		Parameter(s):
			char: player's character
			
		Return(s):
			boolean: detector of character's death
	]]
	local function charIsDead(char: Model) : boolean
		if char:FindFirstChild('Humanoid').Health == 0 then 
			player['Elapsed Time'].Value = 0
			print('Timer suspended due to '..player.Name.."'s death")
			return true
		end
		
		return false
	end

	--Needs to change time format to 0:00. ex) 30s => 0:30; 90s => 1:30
	local reformattedTime

	--Copies the value of the player's current stage for setting best score
	--local oldStage = player['Current Stage'].Value
	local oldStage = player.leaderstats:WaitForChild('Stage').Value

	--print('Timer has started')
	while true do

		local char = player.Character 

		--Cannot continue timer if player has left the game
		if not char then 
			print('Timer suspended because '..player.Name..' left the game')
			return 
		end

		--Ends timer if player has died before and after timer changes
		if charIsDead(char) then return end
		wait(1)
		if charIsDead(char) then return end

		--Timer should not increase after the player is finished with the obby
		if not player['Is Performing Obby'].Value then break end

		--Updates time here
		player['Elapsed Time'].Value += 1
		--print('Time: '..tostring(player['Elapsed Time'].Value)..'s')
		reformattedTime = ServerStorage:FindFirstChild('Change Time Format'):Invoke(nil, player['Elapsed Time'].Value)
		--Updates time in the player's timer UI
		DisplayNewElapsedTime:FireClient(player, reformattedTime)
	end
	print('Timer has ended')


	--Records best time on the Stages UI
	if recordBestTime(player, oldStage, player['Elapsed Time'].Value) then 
		ReplicatedStorage:FindFirstChild('Update Record Time'):FireClient(player, oldStage, reformattedTime)
	end

	--Resets time 
	player['Elapsed Time'].Value = 0
	DisplayNewElapsedTime:FireClient(player, '0:00')
end


HandleTime.Event:Connect(handleTime)



--Starts player's timer as soon as they cross the start line
StartTime.OnInvoke = function(player: Player)
	if not player['Is Performing Obby'].Value and player['Elapsed Time'].Value == 0 then 
		player['Is Performing Obby'].Value = true
		ReplicatedStorage:FindFirstChild('Auto Close Stage UI'):InvokeClient(player)
		HandleTime:Fire(player)
		print(player.Name..' has started the obby')
	else
		--print('Unable to start timer')
	end
end



--Ends player's timer and teleports them to the next stage
EndTime.OnInvoke = function(player: Player, NextStage: number)
	if player['Is Performing Obby'].Value then
		player['Is Performing Obby'].Value = false
		player['Stages'][player.leaderstats:WaitForChild('Stage').Value]['Has Finished This Stage'].Value = true
		ServerStorage:FindFirstChild('Teleport Player to Stage'):Fire(nil, player.Character, workspace:FindFirstChild(tostring(NextStage)))
		print(player.Name..' has finished the stage and will be teleported to Stage '..NextStage)
	end
end