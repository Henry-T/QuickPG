
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local label = ui.newTTFLabel({text = "Hello, World", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self)


    local img = display.newSprite("80x40button_n.png", 100, 100, params):addTo(self)
    img:setTouchEnabled(true)
    img:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name ~= "moved" then
            print(event.name)
        end
        if event.name == "began" then
            print("点击开始", event.x, event.y, event.prevX, event.prevY)
            return true
        elseif event.name == "ended" then
            print("完成点击:", event.x, event.y)
        elseif event.name == "moved" then
            print("移动偏移量: ", event.x-event.prevX, event.y-event.prevY)
        elseif event.name == "cancelled" then
            print("点击取消")
        end
    end)
end

function MainScene:onEnter()

end

function MainScene:onExit()

end

return MainScene