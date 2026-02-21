--!strict

--[[
    State manager for Junta.
    By @Cayla & @Entar
]]

-------------------------------------------------------------------------------------------------------------------------

--[[
    This has the BaseState class which other states build on
--]]
local BaseStateModule = require("@self/BaseState")
local BaseState = BaseStateModule.new()

--[[
    All the states are preloaded and stored in this table
--]]
local States = {} :: { [string]: BaseStateModule.BaseState }

local CurrentState: BaseStateModule.BaseState = BaseState

for _, State in next, love.filesystem.getDirectoryItems("Game/States") do
	local Path = string.format("Game.States.%s", State)
	States[State] = require(Path) :: BaseStateModule.BaseState
end

--[[
    Sets up the state and gets everything done
--]]
local function SetState(Name: string, ...)
	if CurrentState then
		CurrentState._Events.Destroying()
		table.clear(CurrentState)
		CurrentState = BaseState
	end

	CurrentState = table.clone(States[Name])
	assert(CurrentState, "Current State is nil.")

	CurrentState._Events.Preloading(...)
	CurrentState._Events.Loading()
	CurrentState._Events.Postloading()
end

--[[
    Connecting the love functions to the CurrentState
--]]
function love.update(delta)
	CurrentState:Call("Updating", delta)
end

function love.draw()
	CurrentState:Call("Drawing")
end

SetState("Menu")

return {
	BaseState = BaseState,
	Switch = SetState,
}
