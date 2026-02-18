--!strict

local Functions = {}

------------------------------------------------------------------------------------------------------------------------

--[[
    Returns the contents of a file.

    @param Path -- The file's path.
    @return The file's contents.
]]
function Functions.Read(Path: string): string
	local File = io.open(Path, "r")

	if not File then
		error(`'{Path}' is an invalid file path.`)
	end

	local Content = File:read("*all")
	File:close()

	return Content
end

------------------------------------------------------------------------------------------------------------------------

return Functions
