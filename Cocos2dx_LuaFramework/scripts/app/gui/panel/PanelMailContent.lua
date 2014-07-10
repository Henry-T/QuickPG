

local PanelMailContent = class("PanelMailContent")

function PanelMailContent.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, PanelMailContent)
    return target
end

function PanelMailContent:initExtend()
    self.uiLayer = TouchGroup:create()
    self:addChild(self.uiLayer)
    self.mailItems = {}

    local winSize = CCDirector:sharedDirector():getWinSize()
    --local scale   = winSize.height / 320
    --self.uiLayer:setAnchorPoint(ccp(0,0))
    --self.uiLayer:setScale(scale)
    --self.uiLayer:setPosition(ccp((winSize.width - 480 * scale) / 2, (winSize.height - 320 * scale) / 2))
    --self.uiLayer:setPosition(display.cx - winSize.width / 2, display.cy - winSize.height / 2 )

    self.widget = GUIReader:shareReader():widgetFromJsonFile("gui_ccs/PanelMailContent.json")
    local panelSize = self.widget:getSize()
    self.widget:setPosition(CCPoint(display.cx - panelSize.width / 2,display.cy - panelSize.height / 2))
    self.uiLayer:addWidget(self.widget)

    self.lbTitle = self.uiLayer:getWidgetByName("lbTitle")
    self.lbContent = self.uiLayer:getWidgetByName("lbContent")

    local btnDetail = self.uiLayer:getWidgetByName("btnDetail")
    btnDetail:addTouchEventListener(function()
        PanelManager.SwitchRootPanel(PanelMailDetail.create())
    end)

    local btnOK = self.uiLayer:getWidgetByName("btnOK")
    btnOK:addTouchEventListener(function()
        PanelManager.SwitchRootPanel(PanelMailBox.create())
    end)

end

-- #### 显示一封邮件
function PanelMailContent:Show(mailData)
    print("显示邮件...")
    self.data = mailData

    mailData.hasRead = true

    self.lbContent:setText(mailData.content)
    self.lbTitle:setText(mailData.title)
end

function PanelMailContent.create()
    local layer = PanelMailContent.extend(CCLayer:create())
    layer:initExtend()
    return layer
end

return PanelMailContent