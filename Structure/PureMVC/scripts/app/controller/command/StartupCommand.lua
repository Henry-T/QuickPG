--
-- Author: tanghongyang@apowo.com
-- Date: 2015-02-02 15:35:09
--

local StartupCommand = class("StartupCommand")

function StartupCommand:Execute(note)
	local storyArchitectApp = note:GetBody()

	-- Register the Proxys

	-- Register the Mediators

end

return StartupCommand