--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 10:32:19
--

local ViewStateInfo = require("app.ViewPipeline.ViewStateInfo")

local ViewPipeDebugger = class("ViewPipeDebugger", function()
	return display.newNode()
end)

function ViewPipeDebugger:ctor(viewPipeline)
	self._viewPipeline = viewPipeline
	self._container = display.newNode():addTo(self)
end

function ViewPipeDebugger:refresh()
	self._container:removeAllChildren()

	local layer = 1
	local stack = 0

	local createNode = function(viewState, layer, stack)
		local color = nil
		if viewState._instance then
			color = ccc4f(0.2, 1, 1, 0.7)
		else
			color = ccc4f(0.2+stack*0.1, 0.2+stack*0.1, 0.2+stack*0.1, 0.7)
		end

		display.newRect(100, 24, {color=color, fill=true})
			:anchor(0, 0.5)
			:pos(10 + (layer-1)*110, 28 * stack)
			:addTo(self._container)

		ui.newTTFLabel({font=FONT, size=18, align=ui.TEXT_ALGIN_LEFT})
			:anchor(0, 0.5)
			:pos(10 + (layer-1)*110, 28 * stack)
			:addTo(self._container)
			:string(viewState._viewName)
	end

	for i=1, #self._viewPipeline._stateInfoStack do
		local stateInfo = self._viewPipeline._stateInfoStack[i]
		stack = stack + 1
		if stateInfo._mode == ViewStateInfo.EMode_Layer then
			-- create layer base
			if i ~= 1 then
				layer = layer + 1
			end
			stack = 1
			createNode(stateInfo, layer, stack)
		else
			-- create layer
			createNode(stateInfo, layer, stack)
		end
	end

	-- for i=offset,#self._viewPipeline._stateInfoStack do
	-- 	local stateInfo = self._viewPipeline._stateInfoStack[i]
	-- 	local color = ccc4f(0, 0, 0.2+i*0.1, 0.7)
	-- 	display.newRect(100, 24, {color=color, fill=true})
	-- 		:anchor(0, 0.5)
	-- 		:pos(10, 28 * i)
	-- 		:addTo(self._container)

	-- 	if stateInfo._instance then
	-- 		display.newRect(100, 24, {color=ccc4f(0, 0.8, 0, 0.7)})
	-- 			:anchor(0, 0.5)
	-- 			:pos(10, 28 * i)
	-- 			:addTo(self._container)
	-- 	end

	-- 	ui.newTTFLabel({font=FONT, size=18, align=ui.TEXT_ALGIN_LEFT})
	-- 		:anchor(0, 0.5)
	-- 		:pos(10, 28 * i)
	-- 		:addTo(self._container)
	-- 		:string(stateInfo._viewName)
	-- end
end

function ViewPipeDebugger:close()
	self:removeFromParent()
end


return ViewPipeDebugger