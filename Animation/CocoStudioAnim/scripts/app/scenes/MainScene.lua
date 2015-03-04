
local MainScene = class("MainScene", function()
	return display.newScene("MainScene")
end)

function MainScene:ctor()

	display.newColorLayer(ccc4(255, 255, 255, 255)):addTo(self)

	-- CocosStudio 多个相同动画实例并不会互相影响
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("res/CocoStudioAnimProj.ExportJson")
	self._animL = CCArmature:create("CocoStudioAnimProj")
	self._animL:pos(display.cx-80, display.cy)
	self._animL:getAnimation():play("Animation1")
	self:addChild(self._animL)

	self._animL:getAnimation():setFrameEventCallFunc(function (bone, evt, originFrameIndex, currentFrameIndex) 
		if evt == "mid" then
			if not self._animR then
				self._animR = CCArmature:create("CocoStudioAnimProj")
				self._animR:pos(display.cx+80, display.cy)
				self._animR:getAnimation():play("Animation1")
				self:addChild(self._animR)
			end
		elseif evt == "end" then
			print("end!")
			self._animL:getAnimation():stop()
		end
	end)
end

function MainScene:onEnter()

end

function MainScene:onExit()
end

return MainScene
