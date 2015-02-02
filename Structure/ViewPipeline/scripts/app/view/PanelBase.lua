--
-- Author: tanghongyang@apowo.com
-- Date: 2014-09-18 16:11:33
--


local PanelBase = class("PanelBase", function()
    return display.newLayer()
end)

function PanelBase:ctor()
    self:setTouchEnabled(true)
end

PanelBase.EAnimModeNone = 0
PanelBase.EAnimModeScale = 1
PanelBase.EAnimModeSlideBothLR = 2
PanelBase.EAnimModeSlideLeft = 3
PanelBase.EAnimModeSlideRight = 4

---
-- @alphaLayer  true-使用半透层
function PanelBase:show(parent, params)
    params = params or {}
    self:addTo(parent)

    if params.alphaLayer then
        display.newColorLayer(ccc4(0, 0, 0, 190))
            :addTo(self, -1)
    end

    self._fromPanel = params.fromPanel
    
    self._widgetRoot = display.newNode()
      :size(display.width, display.height)
      :anchor(0.5, 0.5)
      :pos(display.cx, display.cy)
      :addTo(self, -1)

    self:initialize(params.initParams)
    self:refresh(params.refreshParams)
end

-- virtual 初始化布局
function PanelBase:initialize(params)
    params = params or {}
end

-- virtual 刷新数据
function PanelBase:refresh(params)
    params = params or {}
end

function PanelBase:close(params)
  params = params or {}
  self:removeAllNodeEventListeners()
  self:removeFromParent()
end

--- 获取面板类名
function PanelBase:getTypeName()
  return self.__cname
end

-- virtual
function PanelBase:saveState()
    local persist = {}
    for k, v in pairs(self._data) do 
        persist[k] = v
    end
    return persist
end

-- virtual
function PanelBase:loadState(persist)
    self._data = {}
    for k,v in pairs(persist) do
        self._data[k] = v
    end
    global.inspector:SetTarget(self._data)
end

--- 添加一条面板状态记录
-- 每次从一个面板主动Move到另一个面板时，即将关闭的面板应该调用pushState
-- 因为以类名为Key，所以使用状态记录的面板类名应当不同
-- PS 此版本只记录一个push, 因为现在操作链上，同一面板只会出现一次
function PanelBase:pushState(state)
    state = state or nil      -- state 至少得是个空表

    local className = self:getTypeName()
    PanelBase._stateStack = PanelBase._stateStack or {}

    PanelBase._stateStack[className] = PanelBase._stateStack[className] or {}
    PanelBase._stateStack[className][1] = state
end

--- 删除一条面板状态记录
-- 每次从一个面板Back到另一个面板时，即将显示的面板应该调用popState，并恢复视图
function PanelBase:popState()
    local className = self:getTypeName()
    PanelBase._stateStack = PanelBase._stateStack or {}
    PanelBase._stateStack[className] = PanelBase._stateStack[className] or {}

    local stackSize = #PanelBase._stateStack[className]
    if stackSize == 0 then
        return nil
    end

    local topState = PanelBase._stateStack[className][stackSize]
    PanelBase._stateStack[className][stackSize] = nil
    return topState
end

--- 清空操作链上的所有状态记录
-- 最常见的情况: 返回主界面时
function PanelBase.clearAllStates()
    PanelBase._stateStack = {}
end

return PanelBase