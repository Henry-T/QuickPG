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
	self._persist = {}		-- 寄存数据 关闭的时候赋值，再次实例化时自动恢复
	self:createView()
end

function ViewStateInfo:createView(loadState)
	local viewClass = require("app.view."..self._viewName)
	self._instance = viewClass.new()
	if self._instance.show and type(self._instance.show) == "function" then
		self._instance:show(self._parent)
	end
	if loadState and self._instance.loadState and type(self._instance.loadState) == "function" then
		self._instance:loadState(self._persist)
	end
end

function ViewStateInfo:refreshView()
	if self._instance and self._instance.refresh and type(self._instance.refresh) == "function" then
		self._instance:refresh()
	end
end

function ViewStateInfo:destroyView()
	if self._instance then
		if self._instance.saveState and type(self._instance.saveState) == "function" then
			self._persist = self._instance:saveState()
		end
		if self._instance.close and type(self._instance.close) == "function" then
			self._instance:close()
		end
	end
	self._instance = nil
end

return ViewStateInfo