--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-12 17:05:31
--

local SlimeNode = import(".SlimeNode")

local SlimeObject = class("SlimeObject", function()
    return display.newNode()
end)

function SlimeObject:ctor(color)
    -- 顶点列表
    self.Nodes = {
        SlimeNode.new(Vector3.new(131,145,0)),
        SlimeNode.new(Vector3.new(196,260,0)),
        SlimeNode.new(Vector3.new(340,218,0)),
        SlimeNode.new(Vector3.new(325,83,0)),
        SlimeNode.new(Vector3.new(198,30,0)),
        -- SlimeNode.new(Vector3.new(0,0,0)),
        -- SlimeNode.new(Vector3.new(0,display.height,0)),
        -- SlimeNode.new(Vector3.new(display.width,display.height,0)),
        -- SlimeNode.new(Vector3.new(display.width,0,0)),
    }

    self:generateNormal()

    self:rebuildGraphics()
end

-- 生成法线
function SlimeObject:generateNormal()
    local quatRot = Quaternion.Euler(0,0,-90)

    for i, node in ipairs(self.Nodes) do
        local nextIdx = i==#self.Nodes and 1 or i+1
        local nextNode = self.Nodes[nextIdx]
        
        local vec = nextNode.Position - node.Position
        local normal = (quatRot * vec)
        normal = normal.normalized

        node.Normal = normal
    end

end

-- 重新生成图像
function SlimeObject:rebuildGraphics()
    -- local color = display.newColorLayer(ccc4(255,0,0, 100)):size(100,100):addTo(self)

    -- 构造一个包含 3 个点的 CCPointArray 对象
    local points = CCPointArray:create(#self.Nodes)

    for _, node in ipairs(self.Nodes) do
        points:add(CCPoint(node.Position.x, node.Position.y))
    end

    -- 创建 CCPolygonShape 对象
    local polygon = CCPolygonShape:create(points)
    polygon:setColor(ccc3(255,0,0))       -- NOTE 无效
    polygon:setFill(true) -- 填充
    polygon:setClose(true) -- 连接第一个点和最后一个点，形成封闭多边形
    self:addChild(polygon)

    -- 测试 绘制法线
    -- for i,node in ipairs(self.Nodes) do
    --     local nextIdx = i==#self.Nodes and 1 or i+1
    --     local nextNode = self.Nodes[nextIdx]

    --     local beginPos = (node.Position + nextNode.Position) / 2
    --     local endPos = beginPos + node.Normal * 10

    --     local drawNormal = display.newDrawNode()
    --     drawNormal:drawLine({beginPos.x,beginPos.y},{endPos.x,endPos.y}, 1, ccc4f(1,0,0,1))
    --     self:addChild(drawNormal)
    -- end
end

return SlimeObject