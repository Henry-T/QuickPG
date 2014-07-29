
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("grossini.plist")

    local frames = display.newFrames("grossini_dance_%02d.png", 1, 14)
    local animation = display.newAnimation(frames, 0.2)
    display.setAnimationCache("dance", animation)

    self._sprite = display.newSprite("#grossini_dance_01.png"):pos(display.cx, display.cy):addTo(self)

    transition.playAnimationForever(self._sprite, display.getAnimationCache("dance"))

    local function moveStop()
        -- 将动画停止在当前帧
        transition.stopTarget(self._sprite)
    end

    self._layerTouch = display.newLayer()
    self._layerTouch:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            transition.stopTarget(self._sprite)

            transition.playAnimationForever(self._sprite, display.getAnimationCache("dance"))

            local seq = transition.sequence({CCMoveTo:create(1, CCPoint(event.x, event.y)), CCCallFunc:create(moveStop)})
            self._sprite:runAction(seq)
        end
    end)
    self._layerTouch:setTouchEnabled(true)
    self._layerTouch:setPosition(ccp(0,0))
    self._layerTouch:setContentSize(CCSize(display.width, display.height))
    self:addChild(self._layerTouch)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
