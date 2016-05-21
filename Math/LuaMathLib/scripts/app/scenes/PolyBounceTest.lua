--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-06 10:00:48
--

--- 多边形反弹
local PolyBounceTest = class("PolyBounceTest", function()
    return display.newScene("PolyBounceTest")
end)

function PolyBounceTest:ctor()

end

function PolyBounceTest:onEnter()
    -- A
    local wallA = {}
    wallA.start = Vector3.new(display.cx-200, display.cy-100)
    wallA.finish = Vector3.new(display.cx+100, display.cy-100)
    wallA.normal = Vector3.new(0, 1).normalized
    wallA.drawNode = display.newDrawNode()
    wallA.drawNode:drawLine({wallA.start.x, wallA.start.y}, {wallA.finish.x, wallA.finish.y}, 2, ccc4f(1, 1, 1, 1))
    wallA.drawNode:addTo(self)

    -- B
    drawNode = display.newDrawNode()
    drawNode:drawLine({display.cx+100, display.cy-100}, {display.cx+200, display.cy}, 2, ccc4f(1, 1, 1, 1))
    drawNode:addTo(self)

    -- C
    drawNode = display.newDrawNode()
    drawNode:drawLine({display.cx+200, display.cy}, {display.cx+200, display.cy+100}, 2, ccc4f(1, 1, 1, 1))
    drawNode:addTo(self)

    -- D
    drawNode = display.newDrawNode()
    drawNode:drawLine({display.cx-100, display.cy+100}, {display.cx+200, display.cy+100}, 2, ccc4f(1, 1, 1, 1))
    drawNode:addTo(self)

    -- E
    drawNode = display.newDrawNode()
    drawNode:drawLine({display.cx-200, display.cy}, {display.cx-100, display.cy+100}, 2, ccc4f(1, 1, 1, 1))
    drawNode:addTo(self)

    -- F
    drawNode = display.newDrawNode()
    drawNode:drawLine({display.cx-200, display.cy-100}, {display.cx-200, display.cy}, 2, ccc4f(1, 1, 1, 1))
    drawNode:addTo(self)

    local ball = {}
    ball.speed = Vector3.new(10, 10)
    ball.drawNode = display.newDrawNode()
    ball.drawNode:drawCircle(5, {})
    ball:addTo(self)
    
end

function PolyBounceTest:onExit()
end

return PolyBounceTest
