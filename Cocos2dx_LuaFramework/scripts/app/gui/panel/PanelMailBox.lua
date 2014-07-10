local PanelMailBox = class("PanelMailBox")
PanelMailBox.__index = PanelMailBox

function PanelMailBox.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, PanelMailBox)
    return target
end

function onTouch_WidgetMailItem(sender, eventType)
    if eventType == ccs.TouchEventType.ended then
        local mailContentPanel = PanelMailContent.create()
        PanelManager.SwitchRootPanel(mailContentPanel)
        mailContentPanel:Show(sender.data.data)
    end
end

function PanelMailBox:initExtend()
    -- #### 初始化数据
    self.mailDataList = {}
    self.widgetMailItemList = {}

    -- #### 创建UILayer
    self.uiLayer = TouchGroup:create()
    self:addChild(self.uiLayer)
    self.mailItems = {}

    -- #### 加载CocoStudioGUI
    local winSize = CCDirector:sharedDirector():getWinSize()
    self.uiLayer:setAnchorPoint(ccp(0,0))
    self.uiLayer:setPosition(0,0)
    self.widget = GUIReader:shareReader():widgetFromJsonFile("gui_ccs/PanelMailBox.json")
    self.uiLayer:addWidget(self.widget)
    local panelSize = self.widget:getSize()
    self.widget:setPosition(CCPoint(display.cx - panelSize.width / 2,display.cy - panelSize.height / 2))

    -- #### 保留容器引用
    self.listMails = self.uiLayer:getWidgetByName("listMails")

    -- #### 保留Item模板
    self.wt_widgetMailItem = self.uiLayer:getWidgetByName("widgetMailItem")
    self.wt_widgetMailItem:removeFromParentAndCleanup(false)

    -- #### 控件 - 返回按钮    
    local btnBack = self.uiLayer:getWidgetByName("btnBack")
    btnBack:addTouchEventListener(function()
        PanelManager.SwitchRootPanel(PanelTestMailNotice.create())
    end)

    -- #### 控件 - 全部收取
    local btnCollectAllAttach = self.uiLayer:getWidgetByName("btnCollectAllAttach")

    -- #### 模拟邮件数据

    local mailData1 = DataMail.new()
    mailData1.uid = 1
    mailData1.title = "150万下载量达成！"
    mailData1.sender = "汉献帝"
    mailData1.time = "15分钟前"
    mailData1.content = "恭喜ProjectS获得150万总下载量！全民撒礼包，狂欢开始啦！"
    mailData1.hasRead = false
    mailData1.type = 0
    self:AddMail(mailData1)

    local mailData2 = DataMail.new()
    mailData2.uid = 1
    mailData2.title = "爱扑嘉年华活动公告"
    mailData2.sender = "南伯温"
    mailData2.time = "1天前"
    mailData2.content = "爱扑网络首届ProjectS嘉年华即将开始！这是我们游戏首次线上线下联动的活动，欢迎大家来到活动现场！"
    mailData2.hasRead = false
    mailData2.type = 1
    self:AddMail(mailData2)

    local mailData3 = DataMail.new()
    mailData3.uid = 1
    mailData3.title = "心魔歼灭奖"
    mailData3.sender = "易佛"
    mailData3.time = "3天前"
    mailData3.content = "经过不懈努力，你完成了心魔歼灭任务，黑暗势力暂时不能为害人间了。取走属于你的奖励吧，勇士。"
    mailData3.hasRead = true
    mailData3.type = 0
    self:AddMail(mailData3)


end

function PanelMailBox.create()
    local layer = PanelMailBox.extend(CCLayer:create())
    layer:initExtend()
    return layer
end

-- public 新增邮件项
function PanelMailBox:AddMail(mailData)
    mailItem = WidgetMailBoxItem.new()
    local widget = self.wt_widgetMailItem:clone()
    mailItem:Initialize(widget, mailData)

    table.insert(self.mailDataList, mailData)
    table.insert(self.widgetMailItemList, mailItem)

    -- NOTE clone操作会造成回调丢失，因此Item实例都在加入UILayer之前关联回调
    widget:addTouchEventListener(onTouch_WidgetMailItem)
    self.listMails:addChild(widget)
end

-- public 移除邮件项
function PanelMailBox:RemoveMail(mailDataId)

end

function PanelMailBox:Fill(mails)
    
end

return PanelMailBox