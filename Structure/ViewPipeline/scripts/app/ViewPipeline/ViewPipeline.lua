--
-- View pileling do all the switch
-- Author: tanghongyang@apowo.com
-- Date: 2014-09-18 16:12:59
--

local ViewStateInfo = import(".ViewStateInfo")
local ViewPipeDebugger = import(".ViewPipeDebugger")

local ViewPipeline = class("ViewPipeline")

function ViewPipeline:ctor(viewNode)
	self._viewNode = viewNode

	self._stateInfoStack = {}		-- 状态栈
end

function ViewPipeline:setViewNode(viewNode)
	self._viewNode = viewNode
end

function ViewPipeline:setDebugNode(debugNode)
	self._debugNode = debugNode
end

function ViewPipeline:pushPanel(panelName)
	self:forward(panelName, ViewStateInfo.EMode_Stack)
end

function ViewPipeline:replacePanel(panelName)
	self:forward(panelName, ViewStateInfo.EMode_Override)
end

function ViewPipeline:addPanel(panelName)
	self:forward(panelName, ViewStateInfo.EMode_Layer)
end

---
-- view 新的视图
-- mode 参考:ViewPipeline.EMode_*
function ViewPipeline:forward(viewName, mode)
	local stateInfo = ViewStateInfo.new(viewName, mode, self._viewNode)
	if mode == ViewStateInfo.EMode_Stack then
		if #self._stateInfoStack > 0 then
			self._stateInfoStack[#self._stateInfoStack]:destroyView()
		end
		self._stateInfoStack[#self._stateInfoStack+1] = stateInfo
	elseif mode == ViewStateInfo.EMode_Layer then
		self._stateInfoStack[#self._stateInfoStack+1] = stateInfo
	elseif mode == ViewStateInfo.EMode_Override then
		local replacedMode = ViewStateInfo.EMode_Stack
		if #self._stateInfoStack > 0 then
			replacedMode = self._stateInfoStack[#self._stateInfoStack]._mode
			self._stateInfoStack[#self._stateInfoStack]:destroyView()
		end
		stateInfo._mode = replacedMode
		self._stateInfoStack[#self._stateInfoStack] = stateInfo
	end

	if self._debugger then
		self._debugger:refresh()
	end
end

--- 
function ViewPipeline:back()
	if #self._stateInfoStack == 0 then
		return
	end

	self._stateInfoStack[#self._stateInfoStack]:destroyView()
	self._stateInfoStack[#self._stateInfoStack] = nil
	if #self._stateInfoStack > 0 then
		if self._stateInfoStack[#self._stateInfoStack]._instance then
			self._stateInfoStack[#self._stateInfoStack]:refreshView()
		else
			self._stateInfoStack[#self._stateInfoStack]:createView(true)
		end
	end

	if self._debugger then
		self._debugger:refresh()
	end
end

--- 清空所有状态
function ViewPipeline:clear()
	for i=1,#self._stateInfoStack do
		self._stateInfoStack[i]:destroyView()
	end
	self._stateInfoStack = {}

	if self._debugger then
		self._debugger:refresh()
	end
end

function ViewPipeline:showDebugger(show)
	if show then
		if self._debugger then
			self._debugger:visible(true)
		else
			self._debugger = ViewPipeDebugger.new(self):addTo(self._debugNode)
		end
	else
		if self._debugger then
			self._debugger:close()
			self._debugger = nil
		end
	end
end

return ViewPipeline