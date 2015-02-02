--
-- Author: tanghongyang@apowo.com
-- Date: 2015-02-02 10:38:00
--

local Mediator = class("Mediator")

function Mediator:ctor(viewComponent)
	self.__viewComponent = viewComponent
end

return Mediator