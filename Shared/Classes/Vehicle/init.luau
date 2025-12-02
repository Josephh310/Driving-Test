--Dependancies
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CreateClass = require(ReplicatedStorage.Shared.Classes.CreateClass)

--Class
local Vehicle = CreateClass("Vehicle") :: typeof({})

--Functions
function Vehicle.constructor(self: typeof(Vehicle), Name: string)
	self.Name = Name
end

function Vehicle.Test(self: typeof(Vehicle))
	print("Beep beep")
end

return Vehicle