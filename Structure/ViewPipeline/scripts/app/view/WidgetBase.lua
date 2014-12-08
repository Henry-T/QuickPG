--
-- Author: tanghongyang@apowo.com
-- Date: 2014-09-18 16:11:45
--

local WidgetBase = class("WidgetBase", function()
    return display.newNode()
end)

function WidgetBase:ctor()
end

function WidgetBase:name(val)
    if val then
        self._name = val
        return self
    end
    return self._name
end

--- virtual 初始化布局
-- @params.panel 所属面板
function WidgetBase:initialize(params)
    params = params or {}
    self._panel = params.panel
    self._layout = params.layout or {}
end

--- virtual 刷新数据
function WidgetBase:refresh(params)
    params = params or {}
end

--- 适应内容尺寸，实现整体居中对齐等功能
function WidgetBase:resizeToContent()
    self:size(self:getCascadeBoundingBox().size)
end

return WidgetBase