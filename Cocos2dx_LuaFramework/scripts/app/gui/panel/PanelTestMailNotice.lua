local PanelTestMailNotice = class("PanelTestMailNotice")
PanelTestMailNotice.__index = PanelTestMailNotice

function PanelTestMailNotice.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, PanelTestMailNotice)
    return target
end

function PanelTestMailNotice:initExtend()
    self._uiLayer = TouchGroup:create()
    self:addChild(self._uiLayer)

    local winSize = CCDirector:sharedDirector():getWinSize()
    local scale   = winSize.height / 320
    --self._uiLayer:setAnchorPoint(ccp(0,0))
    --self._uiLayer:setScale(scale)
    --self._uiLayer:setPosition(ccp((winSize.width - 480 * scale) / 2, (winSize.height - 320 * scale) / 2))
    --self:init()

    self._widget = GUIReader:shareReader():widgetFromJsonFile("gui_ccs/PanelTestMailNotice.json")
    self._uiLayer:addWidget(self._widget)
    
    local function callback(sender, eventType)
        PanelManager.SwitchRootPanel(PanelMailBox.create())
    end

    local btnShowMailBox = self._uiLayer:getWidgetByName("btnShowMailBox")
    btnShowMailBox:addTouchEventListener(callback)

    local widgetSize = self._widget:getSize()
end

function PanelTestMailNotice.create()
    local layer = PanelTestMailNotice.extend(CCLayer:create())
    layer:initExtend()
    return layer
end

return PanelTestMailNotice