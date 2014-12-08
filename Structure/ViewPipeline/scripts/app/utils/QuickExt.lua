--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-29 17:49:12
--


local c = cc
local Node = c.Node
local Sprite = c.Sprite

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

--- 设置可见性
function Node:visible(visible)
    self:setVisible(visible)
    return self
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
-- @index 索引号
-- @cellHeight Cell统一高度
-- @animated 是否播卷动动画
function CCTableView:setFocusIndex(index, cellHeight, animated)
    local offsetYMin = self:minContainerOffset().y
    local newOffsetY = math.min(offsetYMin + cellHeight*(index-1), 0)
    self:setContentOffset(CCPoint(0, newOffsetY), animated)
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

