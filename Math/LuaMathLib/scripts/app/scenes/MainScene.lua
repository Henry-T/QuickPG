local SlimeObject = require("SlimeObject.SlimeObject")
local SlimeBall = require("SlimeObject.SlimeBall")


local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

end

function MainScene:onEnter()
    -- NOTE SmoothDamp测试
    -- self._bg = display.newSprite("spin/bg.png"):scale(0.5):pos(display.cx, display.cy):addTo(self)
    -- self._arrow = display.newSprite("spin/arrow.png"):scale(0.5):pos(display.cx, display.cy+5):addTo(self)

    -- self._vX = 0
    -- self._posX = 0
    -- self._rot = 0
    -- self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
    --     --self._posX = self._arrow:getPositionX()
    --     --self._posX, self._vX = Math.SmoothDamp(self._posX, 300, self._vX, 1, 1000, dt)
    --     --self._arrow:setPosition(self._posX, self._arrow:getPositionY())

    --     self._rot = self._arrow:getRotation()
    --     self._rot, self._vX = Math.SmoothDamp(self._rot, 7200, self._vX, 2, 1000, dt)
    --     self._arrow:setRotation(self._rot)
    -- end)
    -- self:scheduleUpdate()

    -- ==================
    -- 反射测试
    -- ==================
    -- 背景色
    display.newColorLayer(ccc4(140,180,120,255)):addTo(self)

    -- 围墙
    local slimeWall = SlimeObject.new()
    self:addChild(slimeWall)

    -- 角色
    -- local slimeBall = SlimeBall.new(nil, 3.14159)
    -- self:addChild(slimeBall)

    -- 创建一堆随机角色
    local slimeBalls = {}
    math.randomseed(os.time())
    for i=1, 20 do
        local rand = math.random()
        local angle = rand * 3.14159 * 2
        local color = MainScene:HSI2RGB(rand * 360, 1, 1)
        local slimeBall = SlimeBall.new(color, angle)
        self:addChild(slimeBall)

        slimeBalls[#slimeBalls+1] = slimeBall
    end  

    self:addNodeEventListener(NODE_ENTER_FRAME_EVENT, function(dt)
        for _, ball in pairs(slimeBalls) do
            self:checkForCollision(ball, slimeWall)
        end

        -- self:checkForCollision(slimeBall, slimeWall)
    end)
    self:scheduleUpdate()
end


-- 检测是否与墙壁发生碰撞
function MainScene:checkForCollision(ball, wall)
    for i, node in ipairs(wall.Nodes) do
        local nextIdx = i==#wall.Nodes and 1 or i+1
        local nextNode = wall.Nodes[nextIdx]

        local forward = nextNode.Position - node.Position   -- 以墙壁分段一段为原点建立坐标系
        local len = forward.magnitude
        local quatSegmentSpace = Quaternion.LookRotation(forward, Vector3.back)
        local quatSegmentSpaceInvert = quatSegmentSpace:Inverse()

        local ballRelaPos = ball.Position - node.Position             -- 平移变换
        local posInSegSpace = quatSegmentSpaceInvert * ballRelaPos    -- 旋转变换

        -- 在墙壁坐标系中检查ball是否碰到墙壁
        if posInSegSpace.x - ball.Radius < 0 and posInSegSpace.x > 0 and posInSegSpace.z >= 0 and posInSegSpace.z < len then
            posInSegSpace.x = ball.Radius + 1       -- 轻微矫正位置防止黏连
            ball.Velocity = Vector3.Reflect(ball.Velocity, node.Normal)      -- 设置反射速度
            ball.Position = quatSegmentSpace * posInSegSpace + node.Position -- 设定矫正后的世界坐标
            break
        end
    end
end


function MainScene:HSI2RGB(hue, saturation, value)
    local hi = Math.Floor((Math.Floor(hue / 60)) % 6);
    local f = hue / 60 - Math.Floor(hue / 60);

    value = value * 255;
    local v = Math.Floor(value);
    local p = Math.Floor(value * (1 - saturation));
    local q = Math.Floor(value * (1 - f * saturation));
    local t = Math.Floor(value * (1 - (1 - f) * saturation));

    if (hi == 0) then
        return ccc3(v, t, p);
    elseif (hi == 1) then
        return ccc3(q, v, p);
    elseif (hi == 2) then
        return ccc3(p, v, t);
    elseif (hi == 3) then
        return ccc3(p, q, v);
    elseif (hi == 4) then
        return ccc3(t, p, v);
    else
        return ccc3(v, p, q);
    end
end


function MainScene:onExit()
end

return MainScene
