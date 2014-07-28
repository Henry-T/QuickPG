
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    -- ui.newTTFLabel({text = "Hello, World", size = 64, align = ui.TEXT_ALIGN_CENTER})
    --     :pos(display.cx, display.cy)
    --     :addTo(self)

    local uiLayer = TouchGroup:create()
    uiLayer:setTouchEnabled(true)
    self:addChild(uiLayer)

    local button = Button:create()
    button:loadTextureNormal("80x40button_n.png")
    button:setPosition(CCPoint(100, 100))
    button:setTouchEnabled(true)
    button:addTouchEventListener(function()
        print("hello")
    end)
    uiLayer:add(button)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
