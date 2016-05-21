--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-12 17:48:31
--

local SlimeBall = class("SlimeBall", function()
    return display.newNode()
end)

function SlimeBall:ctor(color, angle)
    self.Radius = 10
    local angle = angle or 0
    self.Position = Vector3.new(display.cx, display.cy, 0)
    self.Velocity = 100 * Vector3.new(Math.Cos(angle), Math.Sin(angle), 0)
    self.Color = color or ccc3(255,0,0)

    self:rebuildGraphics()

    self:addNodeEventListener(NODE_ENTER_FRAME_EVENT, function(dt)
        self.Position = self.Position + self.Velocity * dt
        self:setPosition(self.Position.x, self.Position.y)
    end)
    self:scheduleUpdate()
end

-- 重新生成图像
function SlimeBall:rebuildGraphics()
    -- display.newSolidCircle(self.Radius,{
    --     x=0,
    --     y=0,
    --     fill=true, 
    --     fillColor = ccc3(255,0,0)
    --     color=ccc3(255,0,0),
    --     lineWidth=2
    -- }):addTo(self)

    display.newSprite("ball20.png"):addTo(self):setColor(self.Color)

end

return SlimeBall
