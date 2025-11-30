local ObjectCollisionService = {}

--Dependancies
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

local function OnDescendantAdded(Descendant: BasePart?)
	if Descendant:IsA("BasePart") then
		Descendant.CollisionGroup = "Characters"
	end
end

local function OnCharacterAdded(Character: Model)
	for _, Descendant in Character:GetDescendants() do
		OnDescendantAdded(Descendant)
	end
	Character.DescendantAdded:Connect(OnDescendantAdded)
end

local function OnPlayerAdded(Player: Player)
	if Player.Character then
		OnCharacterAdded(Player.Character)
	end
	Player.CharacterAdded:Connect(OnCharacterAdded)
end

function ObjectCollisionService.Start()
	for _, Player in Players:GetPlayers() do
		OnPlayerAdded(Player)
	end
	Players.PlayerAdded:Connect(OnPlayerAdded)
end

function ObjectCollisionService.Init()
	PhysicsService:RegisterCollisionGroup("Characters")
	PhysicsService:RegisterCollisionGroup("CarBody")
	PhysicsService:RegisterCollisionGroup("CarWheels")
	PhysicsService:CollisionGroupSetCollidable("Characters", "Characters", false)
	PhysicsService:CollisionGroupSetCollidable("Characters", "CarBody", false)
	PhysicsService:CollisionGroupSetCollidable("Characters", "CarWheels", false)
	PhysicsService:CollisionGroupSetCollidable("CarBody", "CarWheels", false)
end

return ObjectCollisionService