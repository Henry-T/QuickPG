
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self._uiLayer = TouchGroup:create()
    self:addChild(self._uiLayer)

    local label = Label:create()
    label:setPosition(ccp(display.cx, display.cy))
    label:setText("helll")
    label:setColor(ccc3(255,1,1))

    self._uiLayer:addChild(label)

    print(label:getTextAreaSize().width)
    print(label:getFontName())
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
