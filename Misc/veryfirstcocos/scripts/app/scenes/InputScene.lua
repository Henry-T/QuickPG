
local InputScene = class("InputScene", function()
    return display.newScene("InputScene")
end)

function InputScene:ctor()
  -- ## Touch Sprite
  --[[
  local sprite = display.newScale9Sprite("BlueBlock.png")
  sprite:setContentSize(CCSize(300, 200))
  sprite:setTouchEnabled(true)
  sprite:setTouchSwallowEnabled(false)
  self:addChild(sprite)

  local label = ui.newTTFLabel({text = "123", color = display.COLOR_WHITE})
  label:setPosition(display.cx, display.cy)
  self:addChild(label)

  sprite:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
    -- event.name 是触摸事件的状态：began, moved, ended, cancelled
    -- event.x, event.y 是触摸点当前位置
    -- event.prevX, event.prevY 是触摸点之前的位置
    local l = string.format("sprite: %s x,y: %0.2f, %0.2f", event.name, event.x, event.y)
    label:setString(l)

    -- 返回 true 表示要响应该触摸事件，并继续接收该触摸事件的状态变化
    return true
  end)
  ]]

  -- ## UI触摸封装 按钮等 NO

  



end

function InputScene:onEnter()

end

function InputScene:onExit()
end

return InputScene