--Inheritence
local CarClass = setmetatable({}, require(script.Parent))
CarClass.__index = CarClass

function CarClass.new()
	
end

return CarClass