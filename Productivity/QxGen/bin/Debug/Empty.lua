-- 这是由QxGen生成的UI类/n
-- QXGEN_CLASS_BEGIN PanelCollectMailBonus
local PanelCollectMailBonus = class("PanelCollectMailBonus")

function PanelCollectMailBonus.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, PanelCollectMailBonus)
    return target
end
-- QXGEN_CLASS_END PanelCollectMailBonus

function PanelCollectMailBonus:initExtend()
    self.uiLayer = TouchGroup:create()
    self:addChild(self.uiLayer)
    self.widget = GUIReader:shareReader():widgetFromJsonFile("PanelCollectMailBonus.json")
    self.uiLayer:addWidget(self.widget)

    self.lbTitle = self.widget:getChildByName("lbTitle")
    self.imgSomeIcon = self.widget:getChildByName("imgSomeIcon")
    self.btnOK = self.widget:getChildByName("btnOK")
    self.listBonusItem = self.widget:getChildByName("listBonusItem")
    self.templBonusItem = self.widget:getChildByName("widgetBonusItem")

    self.btnOK:addTouchEventListener(function(sender, eventType)
        -- QXGEN_BTN_CLICK_BEGIN btnOK
        -- HERE btnOK Touch Event Callback Goes ...
        -- QXGEN_BTN_CLICK_END btnOK
    end)

    -- QXGEN_CUSTOM
    -- HERE initExtend()
    -- QXGEN_CUSTOM
end

-- QXGEN_CLASS_LEVEL_CUSTOM_BEGIN
-- HERE 类级
-- QXGEN_CLASS_LEVEL_CUSTOM_END

-- QXGEN_CLASS_RETURE_BEGIN
return PanelCollectMailBonus
-- QXGEN_CLASS_RETURE_END

