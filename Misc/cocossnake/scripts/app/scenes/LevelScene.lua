
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

  cx = display.cx
  cy = display.cy

  ui.newTTFLabel({text = "Hello, World", size = 64, align = ui.TEXT_ALIGN_CENTER})
    :pos(display.cx, display.top - 40)
    :addTo(self)

  img = "RadioButtonOff.png"
  space = 50

  for i=1,10 do
    y = cy + (i-6) * 50
    for j=1,10 do
      x = cx + (j-6) * 50 + 25
      sp = display.newSprite(img, {is9Scale = true})
        :size(10, 10)
        :pos(x, y)
        :addTo(self)
      sp:setTouchEnabled(true)
      sp:setTouchSwallowEnabled(false)
      sp.level = (i * 10 + j)
      sp:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        printf("clicked %d", sp.level)
        require("app.MyApp"):switchScene("GameScene")
        require("app.MyApp"):setLevel(sp.level)
        return true
      end)
      --sp:setContentSize(10, 10)
    end
  end
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
