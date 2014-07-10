

local PanelMailDetail = class("PanelMailDetail")

function PanelMailDetail.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, PanelMailDetail)
    return target
end

function PanelMailDetail:initExtend()
    self.uiLayer = TouchGroup:create()
    self:addChild(self.uiLayer)
    self.mailItems = {}

    local winSize = CCDirector:sharedDirector():getWinSize()
    --local scale   = winSize.height / 320
    --self.uiLayer:setAnchorPoint(ccp(0,0))
    --self.uiLayer:setScale(scale)
    --self.uiLayer:setPosition(ccp((winSize.width - 480 * scale) / 2, (winSize.height - 320 * scale) / 2))
    --self.uiLayer:setPosition(display.cx - winSize.width / 2, display.cy - winSize.height / 2 )

    self.widget = GUIReader:shareReader():widgetFromJsonFile("gui_ccs/PanelMailDetail.json")
    local panelSize = self.widget:getSize()
    self.widget:setPosition(CCPoint(display.cx - panelSize.width / 2,display.cy - panelSize.height / 2))
    self.uiLayer:addWidget(self.widget)

    local btnClose = self.uiLayer:getWidgetByName("btnClose")
    btnClose:addTouchEventListener(function()
        PanelManager.SwitchRootPanel(PanelMailBox.create())
    end)
    
end

function PanelMailDetail.create()
    local layer = PanelMailDetail.extend(CCLayer:create())
    layer:initExtend()
    return layer
end

return PanelMailDetail