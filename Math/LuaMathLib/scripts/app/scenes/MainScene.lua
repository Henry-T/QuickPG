
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    self._bg = display.newSprite("spin/bg.png"):scale(0.5):pos(display.cx, display.cy):addTo(self)
    self._arrow = display.newSprite("spin/arrow.png"):scale(0.5):pos(display.cx, display.cy+5):addTo(self)

    self._vX = 0
    self._posX = 0
    self._rot = 0
end

function MainScene:onEnter()
    -- NOTE SmoothDamp测试
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
        --self._posX = self._arrow:getPositionX()
        --self._posX, self._vX = Math.SmoothDamp(self._posX, 300, self._vX, 1, 1000, dt)
        --self._arrow:setPosition(self._posX, self._arrow:getPositionY())

        self._rot = self._arrow:getRotation()
        self._rot, self._vX = Math.SmoothDamp(self._rot, 7200, self._vX, 2, 1000, dt)
        self._arrow:setRotation(self._rot)
    end)
    self:scheduleUpdate()
end

function MainScene:onExit()
end

return MainScene
