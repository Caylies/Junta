--!strict

local Logger = {}
Logger.__index = Logger

-------------------------------------------------------------------------------------------------------------------------

local TYPE_COLORS: { [string]: string } = {
	ERROR = "\27[31m",
	WARNING = "\27[33m",
	INFO = "\27[32m",
	CRITICAL = "\27[35m",
}

local RESET_COLOR: string = "\27[0m"

-------------------------------------------------------------------------------------------------------------------------

export type Logger = setmetatable<{
	read Name: string,
}, typeof(Logger)>

------------------------------------------------------------------------------------------------------------------------

--[[
    Creates a new logger with the specified name.

    @param Name -- The name of the logger.
    @return A new logger with the specified name.
]]
function Logger.new(Name: string): Logger
	return setmetatable({
		Name = Name,
	}, Logger) :: Logger
end

-------------------------------------------------------------------------------------------------------------------------

--[[
    Formats a log message with colors and formatting.

    @param Message -- The message to format.
    @param Type -- The type of the log message.
    @return The formatted log message.
]]
function Logger._FormatMessage(self: Logger, Message: string, Type: keyof<typeof(TYPE_COLORS)>): string
	local Timestamp: string = os.date("%Y-%m-%d %H:%M:%S")
	local Color: string = TYPE_COLORS[Type] or RESET_COLOR

	return `\27[90m[{Timestamp}]\27[0m \27[36m[{self.Name}]\27[0m {Color}{Type}{RESET_COLOR}: {Message}`
end

-------------------------------------------------------------------------------------------------------------------------

--[[
    Logs an info message.

    @param Message -- The message to log.
]]
function Logger.Info(self: Logger, Message: string): ()
	print(self:_FormatMessage(Message, "INFO"))
end

--[[
    Logs a warning message.

    @param Message -- The message to log.
]]
function Logger.Warn(self: Logger, Message: string): ()
	print(self:_FormatMessage(Message, "WARNING"))
end

--[[
    Logs an error message.

    @param Message -- The message to log.
]]
function Logger.Error(self: Logger, Message: string): ()
	print(self:_FormatMessage(Message, "ERROR"))
end

--[[
    Logs a critical message and terminates execution.

    @param Message -- The message to log.
]]
function Logger.Critical(self: Logger, Message: string): never
	error(self:_FormatMessage(Message, "CRITICAL"), 0)
end

-------------------------------------------------------------------------------------------------------------------------

return Logger
