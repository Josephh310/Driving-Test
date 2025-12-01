local ObjectPhysics = {}

--Dependancies
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local ObjectPhysicsUtils = require(ReplicatedStorage.Shared.Utilities.ObjectPhysicsUtils)

--Helper functions
local function OnCharacterAdded(Character: Model)
	for _, Descendant in Character:GetDescendants() do
		if not Descendant:IsA("BasePart") then
			continue;
		end
		ObjectPhysics.SetCollisionGroup(Descendant, ObjectPhysicsUtils.Enums.Characters)
	end
end

local function OnPlayerAdded(Player: Player)
	if Player.Character then
		OnCharacterAdded(Player.Character)
	end
	Player.CharacterAdded:Connect(OnCharacterAdded)
end

--Main functions
function ObjectPhysics.SetMassless(Object: Model|BasePart, IsMassless: boolean)
	if Object:IsA("BasePart") then
		Object.Massless = IsMassless
	end
	for _, Part: BasePart in Object:GetDescendants() do
		if Part:IsA("BasePart") then
			Part.Massless = IsMassless
		end
	end
end

function ObjectPhysics.SetCollisionGroup(Object: Model|BasePart, CollisionGroup: string)
	if Object:IsA("BasePart") then
		Object.CollisionGroup = CollisionGroup
	end
	for _, Part: BasePart in Object:GetDescendants() do
		if Part:IsA("BasePart") then
			Part.CollisionGroup = CollisionGroup
		end
	end
end

--Init functions
function ObjectPhysics.Start()
	for _, Player in Players:GetPlayers() do
		OnPlayerAdded(Player)
	end
	Players.PlayerAdded:Connect(OnPlayerAdded)
end

function ObjectPhysics.Init()
	--Register collision groups
	for _, GroupName in ObjectPhysicsUtils.Enums do
		local Registered = PhysicsService:IsCollisionGroupRegistered(GroupName)
		if not Registered then
			PhysicsService:RegisterCollisionGroup(GroupName)
		end
	end
	--Set collisions
	for Index, CollisionPair in ObjectPhysicsUtils.CollisionData do
		local Group1 = CollisionPair[1]
		local Group2 = CollisionPair[2]
		local CanCollide = CollisionPair[3]
		PhysicsService:CollisionGroupSetCollidable(Group1, Group2, CanCollide)
	end
end

return ObjectPhysics