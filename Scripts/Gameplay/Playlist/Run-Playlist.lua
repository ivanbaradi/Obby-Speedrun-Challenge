--Playlist 
local Playlist = script.Parent
--Playlist Modules
local Modules = script:FindFirstChild('Playlist Modules')
--List of songs from the playlist
local Songs = Playlist:FindFirstChild('Songs'):GetChildren()



--Playlist runs forever in the server
while true do
	
	local Song = Songs[math.random(#Songs)]
	Playlist.SoundId = 'rbxassetid://'..Song.Value
	--print("Loading song: '"..Song.Name.."'")
	
	if Modules:FindFirstChild('Can Play Song'):Invoke() then
		Modules:FindFirstChild('Play Song'):Invoke(Song)
	end
end