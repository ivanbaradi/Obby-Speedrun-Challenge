--Lava System
LavaSystem = script.Parent
--ServerStorage
ServerStorage = game.ServerStorage
--Lava Tube ID
lavaTube_ID = 1

--[[Creates a lava block

	Param(s):
	id => id of the lava ball

	Return(s):
	new lava block => allocated Lava ball (Part)
]]
function createLavaBall()
	local newLavaBall = Instance.new('Part')
	newLavaBall.Name = 'Lava Ball'
	newLavaBall.Material = 'Neon'
	newLavaBall.Size = Vector3.new(100, 100, 100)	
	newLavaBall.BrickColor = BrickColor.new('Neon orange')
	newLavaBall.Shape = 'Ball'
	return newLavaBall
end

--[[Positions the lava ball

	Param(s):
	lava block => lava ball (Part)
	lavatube ID => lava tube number
]]
function positionLavaBall(lavaBlock, lavaTube)
	lavaBlock.Position = Vector3.new(lavaTube.Position.X,lavaTube.Position.Y-80,lavaTube.Position.Z)
end

--[[Adds a kill script to the lava ball

	Param(s):
	lava block => lava ball (Part)
]]
function addKillToLavaBall(lavaBlock)
	local Scripts = ServerStorage:FindFirstChild('Scripts')
	Scripts:FindFirstChild('Kill'):Clone().Parent = lavaBlock
end

--[[Spawns (pours) the lava ball

	Param(s):
	lava ball => lava ball (Part)
]]
function spawnLavaBall(lavaBlock)
	lavaBlock.Parent = workspace
end

--Switches lava tubes
function switchLavaTube()
	lavaTube_ID+=1
	if lavaTube_ID == 4 then
		lavaTube_ID = 1
	end
end


while true do
	local lavaBall = createLavaBall()
	positionLavaBall(lavaBall, LavaSystem:FindFirstChild('Huge Lava Tube '..tostring(lavaTube_ID)))
	addKillToLavaBall(lavaBall)
	spawnLavaBall(lavaBall)
	switchLavaTube()
	wait(1.5)
end