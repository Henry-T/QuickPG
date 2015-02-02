--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-29 17:49:12
--


local c = cc
local Node = c.Node
local Layer = c.Layer
local Sprite = c.Sprite

-- dump(cc, "", 1)

--- 获取对象的类型名
-- Cocos对象和Quick对象的名称获取方式不同，这里统一一下
function getClassName(data)
    -- local luaType = type(data)
    -- if luaType == "userdata" then
    --     tolua.type()
    -- elseif luaType == "table" then
    -- else
    -- end
end

--- 检查对象类型 (含父类)
function isClassInstance(obj)
    local t = type(obj)
    
end

--- 设置九宫格的切割区域
function Node:cap(x, y, w, h)
    self:setCapInsets(CCRect(x, y, w, h))
    return self
end

--- 设置锚点
function Node:anchor(x, y)
    self:setAnchorPoint(ccp(x,y))
    return self
end

--- 设置/获取颜色
function Node:color(color)
	if not color then
		print("error Node:color() argument nil!")
		return self
	end
    self:setColor(color)
    return self
end

--- 将此Node的世界坐标设置到参考Node的世界坐标上
-- @node 参考Node
function Node:matchPos(node)
    local worldPos = node:convertToWorldSpace(CCPoint(0, 0))
    printf("world pos: %s %s", worldPos.x, worldPos.y)
    local parent = self:getParent()
    if not parent then
        printf("QuickExt: 设定了父节点的Node才能调用matchPos")
        return self
    else
        local localPos = parent:convertToNodeSpace(worldPos)
        printf("local pos: %s %s", localPos.x, localPos.y)
        return self:pos(localPos.x, localPos.y)
    end
end

--- 将此Node的世界坐标设置到参考Node的世界坐标上 (AR)
-- @node 参考Node
function Node:matchPosAR(node)
    local worldPos = node:convertToWorldSpaceAR(CCPoint(0, 0))
    printf("world pos: %s %s", worldPos.x, worldPos.y)
    local parent = self:getParent()
    if not parent then
        printf("QuickExt: 设定了父节点的Node才能调用matchPos")
        return self
    else
        local localPos = parent:convertToNodeSpace(worldPos)
        printf("local pos: %s %s", localPos.x, localPos.y)
        return self:pos(localPos.x, localPos.y)
    end
end

-- cc(Node):addComponent("components.behavior.EventProtocol"):exportMethods()

--- 设置Sprite的Texture
function Sprite:texture(path)
    local sharedTextureCache = CCTextureCache:sharedTextureCache()
    local texture = sharedTextureCache:addImage(path)
    -- local texture = sharedTextureCache:addImageWithMask(path, path .. ".mask")
    self:setTexture(texture)
    return self
end

--- 设置CCScale9Sprite的Texture，命名为texture9方便debug
-- function CCScale9Sprite:texture9(path)
--     local sharedTextureCache = CCTextureCache:sharedTextureCache()
--     local texture = sharedTextureCache:addImage(path)
--     self:setTexture(texture)
--     return self
-- end

--- 可见性
function Node:visible(visible)
    if visible == nil then
        return self:isVisible()
    else
        self:setVisible(visible)
        return self
    end
end

--- 设置宽度
function Node:width(width)
    local oldSize = self:getContentSize()
    if width then
        self:setContentSize(CCSize(width, oldSize.height))
        return self
    else
        return oldSize.width
    end
end

--- 设置高度
function Node:height(height)
    local oldSize = self:getContentSize()
    if height then
        self:setContentSize(CCSize(oldSize.width, height))
        return self
    else
        return oldSize.height
    end
end

--- 设置各种文本控件(TTFFont/BMFont)的显示文本
function Node:string(str)
	self:setString(str)
	return self
end

--- 将特定的Cell卷动到视觉焦点
-- 仅支持Vertical滚动的TableView
-- Cell尺寸必须相同
-- @index 索引号 1+
-- @cellHeight Cell统一高度
-- @animated 是否播卷动动画
function CCTableView:setFocusIndex(index, cellHeight, animated)
    local offsetYMin = self:minContainerOffset().y
    local newOffsetY = math.min(offsetYMin + cellHeight*(index-1), 0)
    self:setContentOffset(CCPoint(0, newOffsetY), animated)
end

--- 将特定的Cell卷动到底部视觉焦点
-- @index 索引号 1+
-- @cellHeight Cell统一高度
-- @animated 是否播卷动动画
-- @tabelHeight TableView的高度
function CCTableView:setFocusIndexBottom(index, cellHeight, animated, tabelHeight)
    local offsetYMin = self:minContainerOffset().y
    if offsetYMin <= 0 then
        local newOffsetY = math.max((offsetYMin-tabelHeight)+cellHeight*index, offsetYMin)
        if newOffsetY>0 then newOffsetY = 0 end
        self:setContentOffset(CCPoint(0, newOffsetY), animated)
    else
        -- 此时Cell无法填满TableView，卷动到默认状态即可
        self:setContentOffset(CCPoint(0, offsetYMin), animated)
    end
end

function CCTableView:setFocusIndexH(index, cellWidth, animated)
    local offsetXMin = self:minContainerOffset().x
    local newOffsetX = -1*cellWidth*(index-1)
    -- print(string.format("index:%d, offsetXMin:%d, newOffsetX:%d, math.max(newOffsetX, offsetXMin):%d", index, offsetXMin, newOffsetX, math.max(newOffsetX, offsetXMin)))
    newOffsetX = math.max(newOffsetX, offsetXMin)
    if newOffsetX>0 then newOffsetX = 0 end
    self:setContentOffset(CCPoint(newOffsetX, 0), animated)
end

--- 设置X轴缩放
function Node:scaleX(val)
    if val then
        self:setScaleX(val)
        return self
    else
        return self:getScaleX()
    end
end

--- 设置Y轴缩放
function Node:scaleY(val)
    if val then
        self:setScaleY(val)
        return self
    else
        return self:getScaleY()
    end
end

--- 通过table key查找子Node
function Node:findNodeByMemberName(name)
    --- 在当前层中查找

    local nodeType = type(self)
    local isCCNode = iskindof(self, "CCNode")

    local searchTable = tolua.getpeer(self)

    _gTemp_searchCnt = _gTemp_searchCnt + 1

    if not searchTable then
        return nil
    end

    for key, member in pairs(searchTable) do
        _gTemp_searchCnt = _gTemp_searchCnt + 1
        if type(member)=="userdata" and key==name then
            print("找到了")
            return member
        else
            print(key, "!=", name)
        end
    end

    --- 在子层中查找
    for key, member in pairs(searchTable) do
        if type(member)=="userdata" and member.findNodeByMemberName then
            print("开始内部检查", key)
            local findResult = member:findNodeByMemberName(name)
            if findResult then
                return findResult
            end
        end
    end

    return nil
end

--- 根据查找路径获取Node
local function getNodeByPath(self, path)
    if (not self) or (not path) then
        debugLayer:info("getNodeByPath 参数错误 nil")
        return nil
    end

    print("检查路径", table.connect(path))

    local curNode = self
    for i, p in ipairs(path) do
        print("检查层", p)
        curNode = curNode[p]
        if not curNode then
            return nil
        end
    end

    return curNode
end

Node.getNodeByPath = getNodeByPath
Layer.getNodeByPath = getNodeByPath


--- 取出此node下面所有的引导控件列表
-- 此函数在运行时不需要
-- 所有的Button和TableView(PropList)会被加入控件树
-- 简单起见，并不会考虑层级关系，因为被筛选的控件不可能出现层叠
-- @ret {{Path={...}, Node=...}}
local function filterGuideNodes(self, curPath)
    local result = {}

    -- print(self:getTypeName())
    -- dump(self)
    -- dump(tolua.getpeer(self))

    local searchTable = tolua.getpeer(self)
    if not searchTable then
        -- debugLayer:info("此node没有peertable")
        return {}
    end

    --- 检查当前层
    for key, member in pairs(searchTable) do
        if type(member)=="userdata" and self:isAncestorOf(member) then
            if member:isGuideNode() then
                --- 创建一个项
                -- print("是祖先节点", key)
                local entry = {Node=member}
                local path = table.clone(curPath)
                -- dump(path)
                path = path or {}
                path[#path+1] = key
                entry.Path = path
                result[#result+1] = entry
                -- debugLayer:info("路径", table.connect(result[#result].Path))
            else
                -- 录制引导的时候，可选中的节点必然是可见的
                if member.visible and member:visible() and member.filterGuideNodes then
                    local newPath = table.clone(curPath)
                    newPath = newPath or {}
                    newPath[#newPath+1] = key
                    -- 只对非Guide节点做子层查找
                    -- debugLayer:info("开始解析子层", key)
                    -- if key == "_labelNode" then
                    --     dump(member)
                    --     dump(tolua.getpeer(member))
                    -- end
                    local findResult = member:filterGuideNodes(newPath)
                    for i=1, #findResult do
                        result[#result+1] = findResult[i]
                    end
                end
            end
        end
    end

    return result
end

Node.filterGuideNodes = filterGuideNodes
Layer.filterGuideNodes = filterGuideNodes


--- 检查一个node是否引导Node
local function isGuideNode(self)
    -- Cocos类派生类的实例都是userdata
    if type(self) ~= "userdata" then
        -- print("isGuideNode not userdata")
        return false
    end

    -- print("isGuideNode __cname is", self.__cname)
    -- 检查Quick类型
    for _, quickType in ipairs(GuideNodeQuickClasses) do 
        if iskindof(self, quickType) then
            -- print("Quick类型相符", quickType, self.__cname)
            return true
        end
    end

    -- print("isGuideNode failed to pass quick type")

    -- -- -- 检查Cocos类型
    -- local cocosType = tolua.type(self)
    -- -- print("isGuideNode tolua.type is", cocosType)
    -- if table.contains(GuideNodeCocosClasses, cocosType) then
    --     return true
    -- else
    --     -- print("isGuideNode failed to pass cocos type")
    -- end

    return false
end

Node.isGuideNode = isGuideNode
Layer.isGuideNode = isGuideNode

--- 检查是否是node的祖先节点
local function isAncestorOf(self, node)
    if not node.getParent then
        return false
    end

    local parent = node:getParent()
    while parent ~= nil do
        if parent == self then
            return true
        else
            parent = parent:getParent()
        end
    end
    return false
end

Node.isAncestorOf = isAncestorOf
Layer.isAncestorOf = isAncestorOf

--- 检查node是否PropList
local function isPropList(self)
    if iskindof(self, "PropList") then
        return true
    else
        return false
    end
end

Node.isPropList = isPropList
Layer.isPropList = isPropList


--- 创建一个可以成为引导焦点的Rect
-- 参数和display.newRect() 一样
function display.newGuideRect(width, height, params)
    local rect = display.newRect(width, height, params)
    local pt = tolua.getpeer(rect)
    if not pt then
        pt = {}
        tolua.setpeer(rect, pt)
    end
    pt.__cname = "GuideRect"

    return rect
end