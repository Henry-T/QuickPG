
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
  rect = display.newRect(display.width, display.height, {color = ccc4f(128, 128, 200, 128)})
  rect:setPosition(CCPoint(display.cx, display.cy))
  rect:addTo(self)

  rect:setTouchEnabled(true)
  rect:setTouchSwallowEnabled(false)
  rect:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
    print("clicked !")
    require("app.MyApp"):switchScene("LevelScene")
    return true
    fadsf
  end)

  ui.newTTFLabel({text = "Some Game", size = 64, align = ui.TEXT_ALIGN_CENTER})
      :pos(display.cx, display.cy)
      :addTo(self)

  label = ui.newTTFLabel({text = "click anywhere to start", size = 32, align = ui.TEXT_ALIGN_CENTER})
    :pos(display.cx, display.cy - 200)
    :addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
