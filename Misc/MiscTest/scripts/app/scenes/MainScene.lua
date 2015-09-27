
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.newColorLayer(ccc4(255, 255, 255, 255)):addTo(self)

    for y = display.bottom, display.top, 40 do
        local line = display.newPolygon({{display.left, y}, {display.right, y}}):addTo(self)
        line:setLineColor(ccc4f(0.9, 0.9, 0.9, 1.0))
    end

    for x = display.left, display.right, 40 do
        local line = display.newPolygon({{x, display.top}, {x, display.bottom}}):addTo(self)
        line:setLineColor(ccc4f(0.9, 0.9, 0.9, 1.0))
    end

    local line = display.newPolygon({{display.left, display.cy}, {display.right, display.cy}}):addTo(self)
    line:setLineColor(ccc4f(1.0, 0.75, 0.75, 1.0))

    local line = display.newPolygon({{display.cx, display.top}, {display.cx, display.bottom}}):addTo(self)
    line:setLineColor(ccc4f(1.0, 0.75, 0.75, 1.0))

  local node = display.newNode()
    :anchor(0.5, 0.5)
    :pos(display.cx, display.cy)
    :addTo(self)

  display.newSprite("400.png")
    :pos(20,0)
    :addTo(node)

  display.newSprite("400.png")
    :pos(60,0)
    :addTo(node)

  local size = node:getCascadeBoundingBox().size
  node:size(80, 0)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
