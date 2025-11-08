--Playlist 
local Playlist = script.Parent
--List of songs from the playlist
local Songs = Playlist:FindFirstChild('Songs'):GetChildren()

--[[Gives song time to load and determines if the song can play

	Return(s):
		boolean: flag of song validation
]]
function canPlaySong() : boolean

	local maxTime = 5 -- max time of song loading
	local startTime = tick() -- start time song loading

	repeat
		task.wait(.1)
		local loadTime = tick() - startTime -- current loading time
		--print('Song load time: '..loadTime)
	until Playlist.IsLoaded or loadTime > maxTime

	return Playlist.IsLoaded
end



--Playlist runs forever in the server
while true do
	
	local Song = Songs[math.random(#Songs)]
	Playlist.SoundId = 'rbxassetid://'..Song.Value
	--print("Loading song: '"..Song.Name.."'")
	
	if canPlaySong() then
		Playlist:Play()
		local time_pos = 0
		repeat
			wait(1)
			time_pos += 1
		until time_pos >= Playlist.TimeLength
	end
end