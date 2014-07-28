
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local label = ui.newTTFLabel({text = "Hello, World", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self)

    local node = display.newNode()
    node:setTouchEnabled(true)
    node:addNodeEventListener(NODE_TOUCH_EVENT, function (event)
        print("OK!")
    end)
    node:size(100,100)
    node:addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
