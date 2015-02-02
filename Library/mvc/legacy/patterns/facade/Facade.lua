--
-- Author: tanghongyang@apowo.com
-- Date: 2015-02-02 16:31:37
--

require("mvc.core.Controller")
require("mvc.core.Model")
require("mvc.core.View")
require("mvc.patterns.observer.Notification")

local Facade = class("Facade")

function Facade.Instance()
	if not Facade.instance then
		Facade.instance = Facade.new()
	end
	return Facade.instance
end

function Facade:ctor()
	if Facade.instance ~= nil then
		print("error Facade Singleton already constructed!")
	end
	Facade.instance = self
	self:initializeFacade()
end

function Facade:initializeFacade()
	self:initializeModel()
	self:initializeController()
	self:initializeView()
end

function Facade:initializeController()
	if not self._controller then
		return
	end
	self._controller = Controller.Instance()
end

function Facade:initializeModel()
	if not self._model then
		return 
	end
	self._model = Model.Instance()
end

function Facade:initializeView()
	if not self._view then
		return 
	end
	self._view = View.Instance()
end

function Facade:RegisterCommand(noteName, cmdClass)
	self._controller:RegisterCommand(noteName, cmdClass)
end

function Facade:RemoveCommand(noteName)
	self._controller:RemoveCommand(noteName)
end

function Facade:HasCommand(noteName)
	return self._controller:HasCommand(noteName)
end

function Facade:RegisterProxy(proxyClass)
	self._model:RegisterProxy(proxyClass)
end

function Facade:RetrieveProxy(proxyName)
	return self._model:RetrieveProxy(proxyName)
end

function Facade:HasProxy( proxyName )
	return self._model.hasProxy( proxyName )
end

function Facade:RegisterMediator( mediator ) 
	if self._view then
		self._view.registerMediator( mediator )
	end
end

function Facade:RetrieveMediator( mediatorName ) 
	return self._view.retrieveMediator( mediatorName )
end

function Facade:RemoveMediator( mediatorName )
	local mediator = nil
	if self._view ~= nil then
		mediator = self._view.removeMediator( mediatorName )
	end
	return mediator
end

function Facade:HasMediator( mediatorName )
	return self._view.hasMediator( mediatorName )
end

function Facade:SendNotification( notificationName, body, type ) 
	self:notifyObservers(Notification.new(notificationName, body, type) )
end

function Facade:NotifyObservers ( notification )
	if self._view ~= nil then
		self._view.notifyObservers( notification )
	end
end

return Facade