--!strict

--[[
    A logging library made for Luau.
    By @Cayla
]]

local logging = {}

-------------------------------------------------------------------------------------------------------------------------

local Logger = require("@self/Logger")

-------------------------------------------------------------------------------------------------------------------------

local Loggers: { [string]: Logger.Logger } = {}

-------------------------------------------------------------------------------------------------------------------------

--[[
    Gets a logger with the specified name.

    @param Name -- The name of the logger.
    @return A logger with the specified name.
]]
function logging.GetLogger(Name: string): Logger.Logger
	local FoundLogger = Loggers[Name]

	if not FoundLogger then
		FoundLogger = Logger.new(Name)
		Loggers[Name] = FoundLogger
	end

	return FoundLogger
end

-------------------------------------------------------------------------------------------------------------------------

return logging
