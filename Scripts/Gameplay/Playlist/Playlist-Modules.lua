--Playlist 
local Playlist = script:FindFirstAncestor('Playlist')

--[[Gives song time to load and determines if the song can play

	Return(s):
		boolean: flag of song validation
]]
script:FindFirstChild('Can Play Song').OnInvoke = function()
	local maxTime = 5 -- max time of song loading
	local startTime = tick() -- start time song loading

	repeat
		task.wait(.1)
		local loadTime = tick() - startTime -- current loading time
		--print('Song load time: '..loadTime)
	until Playlist.IsLoaded or loadTime > maxTime

	return Playlist.IsLoaded
end



--[[Plays a new song

	Parameter(s):
		Song: song object including name and assetID
]]
script:FindFirstChild('Play Song').OnInvoke = function(Song: IntValue)
	Playlist:Play()
	print("Now playing '"..Song.Name.."'")
	local time_pos = 0
	repeat
		wait(1)
		time_pos += 1
	until time_pos >= Playlist.TimeLength
end
