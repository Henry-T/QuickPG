-- 这是由QxGen生成的UI类



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

function PanelCollectMailBonus:initExtend()
    self.uiLayer = TouchGroup:create()
    self:addChild(self.uiLayer)
    self.widget = GUIReader:shareReader():widgetFromJsonFile("PanelCollectMailBonus.json")
    self.uiLayer:addWidget(self.widget)
    
    

    self.lbTitle = self.widget:getChildByName(lbTitle)
    self.imgSomeIcon = self.widget:getChildByName(imgSomeIcon)

    self.btnOK = self.widget:getChildByName(btnOK)
    self.btnOK:addTouchEventListener(function(sender, eventType)
        -- QxGEN_CUSTOM_BTN_CLICK_BEGIN btnOK

        -- QxGEN_CUSTOM_BTN_CLICK_END btnOK
    end)

    self.lstBonusItem = self.widget:getChildByName("lstBonusItem")
    self.tplBonusItem = self.widget:getChildByName("tplBonusItem")
    self.tplBonusItem:removeFromParentAndCleanup(false)
    -- QxGEN_CUSTOM_CLASS_INIT_BEGIN
    -- HERE initExtend()
    -- QxGEN_CUSTOM_CLASS_INIT_END
end

function PanelCollectMailBonus:addBonusItem(data)
    local widgetBonusItem = self.tmplBonusItem:clone()

        widgetBonusItem.lbCount = widgetBonusItem:getChildByName(lbCount)
    widgetBonusItem.imgItemIcon = widgetBonusItem:getChildByName(imgItemIcon)

    widgetBonusItem.btnViewItem = widgetBonusItem:getChildByName(btnViewItem)
    widgetBonusItem.btnViewItem:addTouchEventListener(function(sender, eventType)
        -- QxGEN_CUSTOM_BTN_TOUCH_BEGIN widgetBonusItem.btnViewItem

        -- QxGEN_CUSTOM_BTN_TOUCH_END widgetBonusItem.btnViewItem
    end)


    -- QxGEN_CUSTOM_LIST_ADD_BEGIN BonusItem
    -- HERE 这里通常写数据绑定代码
    -- QxGEN_CUSTOM_LIST_ADD_END BonusItem
end

function PanelCollectMailBonus:removeBonusItem(id)
    -- coming soon !
end

function PanelCollectMailBonus:getBonusItem(id)
    -- comins soon !
end

-- QxGEN_CLASS_LEVEL_CUSTOM_BEGIN
-- HERE 自定义代码
-- QxGEN_CLASS_LEVEL_CUSTOM_END

return PanelCollectMailBonus
