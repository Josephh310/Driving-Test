--Dependancies
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CreateClass = require(ReplicatedStorage.Shared.Classes.CreateClass)

--Class
local Vehicle = CreateClass("Vehicle")

--Functions
function Vehicle:Construct(Owner: Player)
	self.Identifier = HttpService:GenerateGUID(false)
	self.Owner = Owner
	self.Active = false
	self.Destroyed = false
	self.Health = 100
	self.Model = nil
end

function Vehicle:SetActive(State: boolean)
	if typeof(State) ~= "boolean" then
		return;
	end
	if self.Active ~= State then
		self.Active = State
	end
end

return Vehicle