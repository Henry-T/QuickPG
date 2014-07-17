-- 这是由QxGen生成的UI类



local PanelCollectMailBonus = class("PanelCollectMailBonus", function()
    return TouchGroup:create()
end)

function PanelCollectMailBonus:ctor()
    self._isShowing = false

    self._widget = GUIReader:shareReader():widgetFromJsonFile("PanelCollectMailBonus.json")
    self:addWidget(self.widget)
    
    

    self._lbTitle = self:getWidgetByName("lbTitle")
    self._imgSomeIcon = self:getWidgetByName("imgSomeIcon")

    self._btnOK = self:getWidgetByName("btnOK")
    self._btnOK:addTouchEventListener(function(sender, eventType)
        -- QxGEN_CUSTOM_BTN_TOUCH_BEGIN btnOK
        if eventType == ccs.TouchEventType.ended then
        end
        -- QxGEN_CUSTOM_BTN_TOUCH_END btnOK
    end)

    self._lstBonusItem = self.widget:getChildByName("lstBonusItem")
    -- QxGEN_CUSTOM_CLASS_INIT_BEGIN
-- HERE 自定义代码 444444
-- QxGEN_CUSTOM_CLASS_INIT_END
end

function PanelCollectMailBonus:addBonusItem(data)
    local widgetBonusItem = GUIReader():shareReader():widgetFromJsonFile("widgetBonusItem.json")
    widgetBonusItem._data = data
    
        widgetBonusItem._lbCount = UIHelper:seekWidgetByName(widgetBonusItem, "lbCount")
    widgetBonusItem._imgItemIcon = UIHelper:seekWidgetByName(widgetBonusItem, "imgItemIcon")

    widgetBonusItem._btnViewItem = UIHelper:seekWidgetByName(widgetBonusItem, "btnViewItem")
    widgetBonusItem._btnViewItem:addTouchEventListener(function(sender, eventType)
        -- QxGEN_CUSTOM_BTN_TOUCH_BEGIN widgetBonusItem.btnViewItem
        if eventType == ccs.TouchEventType.ended then
        
-- 这不是真的！！！ 111111
        end
        -- QxGEN_CUSTOM_BTN_TOUCH_END widgetBonusItem.btnViewItem
    end)


    -- QxGEN_CUSTOM_LIST_ADD_BEGIN BonusItem
    -- HERE 这里通常写数据绑定代码
    -- QxGEN_CUSTOM_LIST_ADD_END BonusItem
end

-- QxGEN_CUSTOM_CLASS_LEVEL_BEGIN
-- HERE 自定义代码 99999
-- QxGEN_CUSTOM_CLASS_LEVEL_END

function PanelCollectMailBonus:show(parent)
    if not self._isShowing then
        self._isShowing = true
        parent:addChild(self)
    end
end

-- QxGEN_CUSTOM_LIST_REFRESH_BEGIN PanelCollectMailBonus
function PanelCollectMailBonus:refreshView()
    -- TODO 请将这个函数改为你自己的Panel刷新逻辑
end
-- QxGEN_CUSTOM_LIST_REFRESH_END PanelCollectMailBonus

function PanelCollectMailBonus:close()
    if self._isShowing then
        self._isShowing = false
        -- TODO 移除所有的list项 以节约内存
        -- 例如:
        -- self._listMails:removeAllItems()
        transition.scaleTo(self, {time = .2, scale = .2, easing = "BACKIN", onComplete = function ()
            self:removeFromParentAndCleanup(true)
            self:setScale(1)
        end})
    end
end

return PanelCollectMailBonus
