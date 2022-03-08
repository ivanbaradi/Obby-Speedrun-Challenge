--Playlist 
local Playlist = script.Parent
--List of songs from the playlist
local Songs = Playlist:FindFirstChild('Songs')

--Playlist runs forever in the server
while true do
	for _, song in pairs(Songs:GetChildren()) do
		--Gets Sound ID
		Playlist.SoundId = 'rbxassetid://'..song.Value
		--Plays the song
		Playlist:Play()
		--Current time position of the song
		local time_pos = 0
		
		repeat
			wait(1)
			time_pos += 1
		until time_pos >= Playlist.TimeLength
	end
end