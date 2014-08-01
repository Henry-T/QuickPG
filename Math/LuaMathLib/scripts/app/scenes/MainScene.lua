
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self._label = ui.newTTFLabel({text = "Hello, World", size = 20, align = ui.TEXT_ALIGN_CENTER})
        :pos(100, display.cy)
        :addTo(self)

    self._vX = 0
    self._posX = 0
    self._rot = 0
end

function MainScene:onEnter()
    -- NOTE SmoothDamp测试
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
        --self._posX = self._label:getPositionX()
        --self._posX, self._vX = Math.SmoothDamp(self._posX, 300, self._vX, 1, 1000, dt)
        --self._label:setPosition(self._posX, self._label:getPositionY())

        self._rot = self._label:getRotation()
        self._rot, self._vX = Math.SmoothDamp(self._rot, 7200, self._vX, 5, 1000, dt)
        self._label:setRotation(self._rot)
    end)
    self:scheduleUpdate()
end

function MainScene:onExit()
end

return MainScene
