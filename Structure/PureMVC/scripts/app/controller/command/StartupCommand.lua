--
-- Author: tanghongyang@apowo.com
-- Date: 2015-02-02 15:35:09
--

local SimpleCommand = require("mvc.patterns.command.SimpleCommand")

local StartupCommand = class("StartupCommand", SimpleCommand)

function StartupCommand:execute(note)
	local storyArchitectApp = note:getBody()

	-- Register the Proxys

	-- Register the Mediators
	print("execute StartupCommand")
end

return StartupCommand