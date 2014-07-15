
local {0} = class("{0}")

function {0}.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {{}}
        tolua.setpeer(target, t)
    end
    setmetatable(t, {0})
    return target
end

function {0}:initExtend()
    self.uiLayer = TouchGroup:create()
    self:addChild(self.uiLayer)
    self.widget = GUIReader:shareReader():widgetFromJsonFile("{0}.json")
    self.uiLayer:addWidget(self.widget)
    
    -- QXGEN_TOP_CONTROL_DEFINE

    -- QxGEN_CUSTOM_CLASS_INIT_BEGIN
    -- HERE initExtend()
    -- QxGEN_CUSTOM_CLASS_INIT_END
end
