--Lava Machine
LavaMachine = script.Parent
--ServerStorage
ServerStorage = game.ServerStorage


--[[Creates a lava block

	Return(s):
	new lava block => allocated Lava Block (Part)
]]
function createLavaBlock()
	local newLavaBlock = Instance.new('Part')
	newLavaBlock.Name = 'Lava'
	newLavaBlock.Material = 'Neon'
	newLavaBlock.Size = Vector3.new(13,13,13)	
	newLavaBlock.BrickColor = BrickColor.new('Neon orange')
	return newLavaBlock
end

--[[Positions the lava block

	Param(s):
	lava block => lava block (Part)
	lava tube => tube where the lava block will be poured from (Part)
]]
function positionLavaBlock(lavaBlock, lavaTube)
	lavaBlock.Position = Vector3.new(lavaTube.Position.X,lavaTube.Position.Y-10,lavaTube.Position.Z)
end

--[[Adds a kill script to the lava block

	Param(s):
	lava block => lava block (Part)
]]
function addKillToLavaBlock(lavaBlock)
	local Scripts = ServerStorage:FindFirstChild('Scripts')
	Scripts:FindFirstChild('Kill'):Clone().Parent = lavaBlock
end

--[[Spawns (pours) the lava block

	Param(s):
	lava block => lava block (Part)
]]
function spawnLavaBlock(lavaBlock)
	lavaBlock.Parent = workspace
end

--[[Despawns the lava block

	Param(s):
	lava block => lava block (Part)
]]
function despawnLavaBlock(lavaBlock)
	lavaBlock:Remove()
end

--[[Main functionality of pouring blocks

	Param(s)
	start => index of the first lava block
	end => index of the last lava block
]]
function pourLavaBlocks(start, _end)
	
	--Table of lava blocks (Part Instance)
	local lavaBlocks = {}
	--Used for indexing lava blocks
	local a = start
	
	--Spawns lava blocks
	while a <= _end do
		table.insert(lavaBlocks, a, createLavaBlock())
		addKillToLavaBlock(lavaBlocks[a])
		positionLavaBlock(lavaBlocks[a], LavaMachine:FindFirstChild('Lava Tube '..tostring(a)))
		spawnLavaBlock(lavaBlocks[a])
		a+=1
	end
	
	wait(1)
	a = start
	
	while a <= _end do
		despawnLavaBlock(lavaBlocks[a])
		a+=1
	end
end

while wait(.1) do
	pourLavaBlocks(1, 3)
	pourLavaBlocks(4, 5)
end
