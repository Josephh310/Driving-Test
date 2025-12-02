--Credit to CoodSlayer for this awesome OOP framework!

local FILTER_FRAMEWORK_TRACES = true
local PATTERN = "%." .. script.Name .. ":%d+"

local function errorHandler(err)
	local errStr = tostring(err)
	if errStr:match("^[^\n]+:%d+:") then -- don't process if it's already filtered
		return errStr
	end

	local trace = debug.traceback(tostring(err), 2)

	if not FILTER_FRAMEWORK_TRACES then
		return trace
	end

	-- Filter framework lines from stack trace
	local filtered = {}
	for line in trace:gmatch("[^\n]+") do
		if not line:match(PATTERN) then
			table.insert(filtered, line)
		end
	end

	return table.concat(filtered, "\n")
end

local _Base = { className = "_Base" }
_Base.__index = _Base
function _Base:isA(className: string)
	local current = getmetatable(self)
	while current do
		if current.className == className then
			return true
		end
		current = getmetatable(current)
	end
	return false
end

local function create(className: string, parent)
	local newClass = { className = className }

	local newObject = { className = className }
	newObject.__index = newObject

	parent = parent or _Base

	setmetatable(newObject, parent.__index)

	newClass.__index = newObject
	newClass.super = parent.__index

	function newClass.new(...)
		local o = setmetatable({}, newObject)

		local constructors = {}
		local currentClass = newClass

		while currentClass do
			local ctor = rawget(currentClass, "constructor")
			if ctor then
				table.insert(constructors, 1, ctor)  -- Prepend
			end

			local mt = getmetatable(currentClass)
			if mt then
				currentClass = mt.__index  -- Parent class
			else
				break
			end
		end

		-- Call all constructors in order
		for _, ctor in ipairs(constructors) do
			local success, err = xpcall(ctor, errorHandler, o, ...)
			if not success then
				error(err, 0)
			end
		end

		return o
	end

	newClass.static = setmetatable({}, {
		__newindex = function(t, k, v)
			rawset(newClass, k, v)
		end,
	})

	return setmetatable(newClass, {
		__index = parent,
		__newindex = function(t, key, value)
			if key == "constructor" then
				rawset(t, "constructor", value)
			elseif type(value) == "function" then
				rawget(t, "__index")[key] = function(self, ...)
					local parentMethod = newClass.super and newClass.super[key]

					local oldSuper = rawget(self, "_super")

					local newSuper = parentMethod and function(...)
						return parentMethod(self, ...)
					end or function()
						error(string.format(
							"No parent method '%s' to call with _super in class '%s'",
							key, newClass.className
							), 3)
					end

					rawset(self, "_super", newSuper)

					local results = table.pack(xpcall(value, errorHandler, self, ...))
					rawset(self, "_super", oldSuper)

					if results[1] then
						return table.unpack(results, 2, results.n)
					else
						error(results[2], 2)
					end
				end
			else
				rawset(t, key, value)
			end
		end
	})
end

return create