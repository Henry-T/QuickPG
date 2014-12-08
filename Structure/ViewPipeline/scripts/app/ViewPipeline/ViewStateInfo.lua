--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 10:50:06
--

local ViewStateInfo = class("ViewStateInfo")

ViewStateInfo.EMode_Stack = 1 	 -- 堆栈
ViewStateInfo.EMode_Override = 2  -- 代替
ViewStateInfo.EMode_Layer = 3     -- 分层

function ViewStateInfo:ctor(viewName, mode, parent)
	self._viewName = viewName
	self._mode = mode
	self._instance = nil
	self._parent = parent
	self:createView()
end

function ViewStateInfo:createView()
	-- dump(self._viewName)
	local viewClass = require("app.view."..self._viewName)
	self._instance = viewClass.new()
	if self._instance.show and type(self._instance.show) == "function" then
		self._instance:show(self._parent)
	end
end

function ViewStateInfo:refreshView()
	if self._instance and self._instance.refresh and type(self._instance.refresh) == "function" then
		self._instance:refresh()
	end
end

function ViewStateInfo:destroyView()
	if self._instance then
		if self._instance.close and type(self._instance.close) == "function" then
			self._instance:close()
		end
	end
	self._instance = nil
end

return ViewStateInfo