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

    self._cbMusicOn = self:getWidgetByName("cbMusicOn")
    self._cbMusicOn:addEventListenerCheckBox(function(sender, eventType)
        -- QxGEN_CUSTOM_CHECK_CHANGE_BEGIN cbMusicOn
        if eventType == ccs.CheckBoxEventType.selected then
            -- TODO 选中 ...
        elseif eventType == ccs.CheckBoxEventType.unselected then
            -- TODO 取消 ...
        end
        -- QxGEN_CUSTOM_CHECK_CHANGE_END cbMusicOn
    end)

    self._radTop_Property = self:getWidgetByName("radTop_Property")
    self._radTop_Property:addEventListenerCheckBox(self.onRadTopChanged)

    self._radTop_Bag = self:getWidgetByName("radTop_Bag")
    self._radTop_Bag:addEventListenerCheckBox(self.onRadTopChanged)

    self._radTop_Team = self:getWidgetByName("radTop_Team")
    self._radTop_Team:addEventListenerCheckBox(self.onRadTopChanged)

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

local function PanelCollectMailBonus:onRadTopChanged(sender, eventType)
    -- QxGEN_CUSTOM_RADIO_CHANGE_BEGIN Top
    if eventType == ccs.CheckBoxTouchEvent.selected then
      -- HERE 自定义选中代码
    elseif eventType == ccs.CheckBoxTouchEvent.unselected then
        -- TODO 完善 .. 对Radio Group禁用Unselect
    else
    -- QxGEN_CUSTOM_RADIO_CHANGE_END Top
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
-- TODO 请将这个函数改为你自己的Panel刷新逻辑
function PanelCollectMailBonus:refreshView()
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
