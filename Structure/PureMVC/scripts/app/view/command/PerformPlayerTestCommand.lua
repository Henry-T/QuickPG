--
-- Author: tanghongyang@apowo.com
-- Date: 2015-02-02 13:00:08
--

local SimpleCommand = require("app.view.command.SimpleCommand")

local PerformPlayerTestCommand = class("PerformPlayerTestCommand", SimpleCommand)

function PerformPlayerTestCommand:ctor()

end

function PerformPlayerTestCommand:Execute(note)
	local playerConfigVO = node:GetBody()

	local playerProxy = Facade.RetrieveProxy("PlayerProxy")

	-- View访问了Model
	playerProxy:TestConfiguration(playerConfigVO)
end

return PerformPlayerTestCommand

