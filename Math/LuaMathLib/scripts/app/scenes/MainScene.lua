
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self._label = ui.newTTFLabel({text = "Hello, World", size = 20, align = ui.TEXT_ALIGN_CENTER})
        :pos(0, display.cy)
        :addTo(self)

    self._vX = 100
    self._posX = 0
end

function MainScene:onEnter()
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
        self._posX = self._label:getPositionX()
        self._posX, self._vX = Math.SmoothDamp(self._posX, 100, self._vX, 1, 0, dt)
        self._label:setPosition(self._posX, self._label:getPositionY())
    end)
    self:scheduleUpdate()
end

function MainScene:onExit()
end

return MainScene
