--
-- Author: tanghongyang@apowo.com
-- Date: 2014-11-27 10:30:04
--

--- 事件机制

Object = class("Object")

--- 初始化事件分发
function Object:initEventDispatcher()
	if self._eventDispatcherInitialized then
		return
	end
	self._eventDispatcherInitialized = true

	self._eventHandlers = {}
end

--- 注册侦听器
-- name 事件名称
-- obj 侦听此事件的对象
-- handler 侦听对象的事件处理函数
function Object:addEventListener(name, obj, handler)
	self:initEventDispatcher()
	local handlerList = table.getOrNewTableByKey(self._eventHandlers, name)
	table.insert(handlerList, {obj=obj, handler=handler})
end

--- 移除一个侦听器
function Object:removeEventListener(name, obj, handler)
	self:initEventDispatcher()
	local handlerList = table.getOrNewTableByKey(self._eventHandlers, name)
	for i=#handlerList,1,-1 do
		local h = handlerList[i]
		if h.obj == obj and h.handler == handler then
			table.remove(handlerList, i)
		end
	end
	-- print("test OKOK")
	-- self:printCnt()
end

--- 移除特定事件的所有侦听器
function Object:removeAllEventListeners(name)
	self:initEventDispatcher()
	self._eventHandlers[name] = {}
end

--- 移除所有侦听器
function Object:clearAllEventListener()
	self:initEventDispatcher()
	self._eventHandlers = {}
end

--- 触发事件
function Object:fireEvent(name, params)
	self:initEventDispatcher()
	local handlerList = table.getOrNewTableByKey(self._eventHandlers, name)
	for i=#handlerList, 1, -1 do
		local h = handlerList[i]
		if h.obj and h.handler then
			h.handler(h.obj, self, h.params)
		else
			table.remove(handlerList, i)
		end
	end
end

function Object:printCnt()
	for _, handlerList in ipairs(self._eventHandlers) do
		print(#handlerList.." ")
	end
end