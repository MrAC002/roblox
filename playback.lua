

plrs = {}
i=0
ended=false

game.Players.PlayerAdded:Connect(function(plr)
	table.insert(plrs,plr.Name)
	print(plrs)
	local folder = Instance.new("Folder")
	folder.Parent = workspace.rec
	folder.Name=plr.Name
end)

function start()
	while not ended do
			wait(0.03)
				for p in plrs do
					local pos = Instance.new("StringValue")
					pos.Value = tostring(game.Workspace:FindFirstChild(plrs[p]).HumanoidRootPart.CFrame)
					pos.Parent = game.Workspace.rec:FindFirstChild(plrs[p])
					pos.Name="Frame_"..tostring(i)
				end
			i+=1				
		end
end

function endrec()
	ended=true
end

function playback()
	print(i)
	if ended==true then
		for s=0,i-2,1 do
			for _, name in workspace.rec:GetChildren() do
				game.Workspace:FindFirstChild(tostring(name)).HumanoidRootPart.Anchored=true
				game.Workspace:FindFirstChild(tostring(name)).Humanoid.PlatformStand=true
				local val = game.Workspace.rec:WaitForChild(tostring(name)):FindFirstChild("Frame_"..tostring(s+1))
				local value = tostring(val.Value):split(',')
				for i,val in value do
					value[i]=tonumber(val)
				end
				game.Workspace:FindFirstChild(tostring(name)).HumanoidRootPart.CFrame=CFrame.new(unpack(value))
			end
			wait(0.02)
		end
		for _, name in workspace.rec:GetChildren() do
			game.Workspace:FindFirstChild(tostring(name)).HumanoidRootPart.Anchored=false
			game.Workspace:FindFirstChild(tostring(name)).Humanoid.PlatformStand=false
		end
	end
end

function clear()
	i=0
	ended=false
	for _, name in workspace.rec:GetChildren() do
		if game.Workspace:FindFirstChild(tostring(name)).HumanoidRootPart.Anchored==false and game.Workspace:FindFirstChild(tostring(name)).Humanoid.PlatformStand==false then
				local chilldern = name:GetChildren()
				for i, child in chilldern do
					child:Destroy()
				end
		end
	end
end

game.ReplicatedStorage.clear.OnServerEvent:Connect(clear)
game.ReplicatedStorage.start.OnServerEvent:Connect(start)
game.ReplicatedStorage.stop.OnServerEvent:Connect(endrec)
game.ReplicatedStorage.replay.OnServerEvent:Connect(playback)
