--
-- Author: tanghongyang@apowo.com
-- Date: 2015-02-02 15:38:08
--

local AppConstants = require("app.controller.constant.AppConstants")
local StartupCommand = require("app.controller.command.StartupCommand")
local Facade = require("mvc.patterns.facade.Facade")

local ApplicationFacade = class("ApplicationFacade", Facade)

function ApplicationFacade.getInstance()
	if ApplicationFacade.instance == nil then
		ApplicationFacade.instance = ApplicationFacade.new()
	end
	return ApplicationFacade.instance
end

function ApplicationFacade:ctor()
	ApplicationFacade.super.ctor(self, 1)
end

-- protected
function ApplicationFacade:initializeController()
	ApplicationFacade.super.initializeController(self)
	self:registerCommand(AppConstants.STARTUP, StartupCommand)

	-- register the rest of commands...

end

function ApplicationFacade:startUp(app)
	print("sendNote AppConstants.STARTUP")
	self:sendNotification(AppConstants.STARTUP, app)
end

return ApplicationFacade