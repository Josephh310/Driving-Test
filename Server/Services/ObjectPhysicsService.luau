local ObjectPhysics = {}

--Dependancies
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local ObjectPhysicsUtils = require(ReplicatedStorage.Shared.Utilities.ObjectPhysicsUtils)
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
return ObjectPhysics