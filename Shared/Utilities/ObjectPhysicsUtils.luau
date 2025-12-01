--[[
	Game Collision Groups:
		Default:
			Most parts inside the map.
		Character: 
			Players characters
		CarBody:
			Main body of the car
		CarWheels:
			Wheels of the car
			Is seperate from CarBody so that collision between the wheels and body
			doesn't effect driving.
]]

local CollisionGroups = {}

CollisionGroups.Enums = {
	Default = "Default",
	Characters = "Characters",
	CarBody = "CarBody",
	CarWheels = "CarWheels"
}

CollisionGroups.CollisionData = {
	--Default (map)
	--Everything can collide with the map.
	{
		CollisionGroups.Enums.Default,
		CollisionGroups.Enums.Default,
		true
	},
	{
		CollisionGroups.Enums.Default,
		CollisionGroups.Enums.Characters,
		true
	},
	{
		CollisionGroups.Enums.Default,
		CollisionGroups.Enums.CarBody,
		true
	},
	{
		CollisionGroups.Enums.Default,
		CollisionGroups.Enums.CarWheels,
		true
	},
	--Characters
	{
		CollisionGroups.Enums.Characters,
		CollisionGroups.Enums.Characters,
		false
	},
	{
		CollisionGroups.Enums.Characters,
		CollisionGroups.Enums.CarBody,
		false
	},
	{
		CollisionGroups.Enums.Characters,
		CollisionGroups.Enums.CarWheels,
		false
	},
	--CarBody
	{
		CollisionGroups.Enums.CarBody,
		CollisionGroups.Enums.CarBody,
		false -- Prevent vehicle collisions
	},
	{
		CollisionGroups.Enums.CarBody,
		CollisionGroups.Enums.CarWheels,
		false
	},
	--CarWheels
	{
		CollisionGroups.Enums.CarWheels,
		CollisionGroups.Enums.CarWheels,
		false -- Prevent vehicle collisions
	}
	
}

return CollisionGroups