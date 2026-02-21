--!strict

--[[
	Set up logging
--]]
local Logging = require("../../../Packages/Logging")
local Logger = Logging.GetLogger("StateLogger")

local BaseState = {}
BaseState.__index = BaseState

-------------------------------------------------------------------------------------------------------------------------

-- selene: allow(unused_variable)
local DEFAULT_EVENTS = {
	Preloading = function()
		return
	end,
	Loading = function()
		return
	end,
	Postloading = function()
		return
	end,
	Updating = function(Delta: number)
		return
	end,
	Destroying = function()
		return
	end,
	Drawing = function()
		return
	end,
}

-------------------------------------------------------------------------------------------------------------------------

export type BaseState = setmetatable<{
	_Events: typeof(DEFAULT_EVENTS),
}, typeof(BaseState)>

-------------------------------------------------------------------------------------------------------------------------

--[[
    Creates a new base state with default events.

    @return A new base state with default events.
]]
function BaseState.new(): BaseState
	return setmetatable({
		_Events = table.clone(DEFAULT_EVENTS),
	}, BaseState) :: BaseState
end

-------------------------------------------------------------------------------------------------------------------------

--[[
    Gets called before the state starts loading.
]]
function BaseState.Preloading(self: BaseState, Callback: () -> ()): ()
	self._Events.Preloading = Callback
end

--[[
    Gets called when the state starts loading.
]]
function BaseState.Loading(self: BaseState, Callback: () -> ()): ()
	self._Events.Loading = Callback
end

--[[
    Gets called after the state finishes loading.
]]
function BaseState.Postloading(self: BaseState, Callback: () -> ()): ()
	self._Events.Postloading = Callback
end

--[[
    Gets called every frame.

    @param Delta -- The time in seconds since the last frame.
]]
function BaseState.Updating(self: BaseState, Callback: (Delta: number) -> ()): ()
	self._Events.Updating = Callback
end

--[[
    Gets called before the state is destroyed.
]]
function BaseState.Destroying(self: BaseState, Callback: () -> ()): ()
	self._Events.Destroying = Callback
end

--[[
	Calls a state function.
]]
function BaseState.Call(self: BaseState, Function: keyof<typeof(DEFAULT_EVENTS)>): ()
	if not self._Events[Function] then
		Logger:Warn("This state doesn't have this function")
	end
	self._Events[Function]()
end

-------------------------------------------------------------------------------------------------------------------------

return BaseState
