local Loader = {}

function Loader.LoadDirectory(Directory: Instance, CurrentModules:{}?)
	if CurrentModules == nil then CurrentModules = {} end
	for _, NewDirectory in Directory:GetChildren() do
		if NewDirectory:IsA("ModuleScript") then
			local Source = require(NewDirectory)
			if typeof(Source) == "table" and Source.Enabled == false then
				warn(`{NewDirectory.Name} is disabled.`)
				continue
			end
			CurrentModules[NewDirectory.Name] = require(NewDirectory)
		else
			Loader.LoadDirectory(NewDirectory, CurrentModules)
		end
	end
	return CurrentModules
end

return Loader