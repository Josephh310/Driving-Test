--Inheritence
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CreateClass = require(ReplicatedStorage.Shared.Classes.CreateClass)
local Vehicle = require(ReplicatedStorage.Shared.Classes.Vehicle)

--Class
local Car = CreateClass("Car", Vehicle) -- Inherits from Vehicle

--Functions
function Car:Construct()
	
end

return Car