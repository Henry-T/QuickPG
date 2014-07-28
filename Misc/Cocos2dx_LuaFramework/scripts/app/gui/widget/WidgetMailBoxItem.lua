local WidgetMailBoxItem = class("WidgetMailBoxItem")


function WidgetMailBoxItem:ctor()
    self.data = nil
    self.widget = nil
end

function WidgetMailBoxItem:Rebind()
    self.lbTitle:setText(self.data.title)
    self.lbSender:setText(self.data.sender)
    self.lbTime:setText(self.data.time)
    self.imgIsNew:setVisible(self.data.hasRead == false)

    if self.data.type == 0 then
        self.imgMailType:loadTexture("imgMailType_item.png")
    elseif self.data.type == 1 then
        self.imgMailType:loadTexture("imgMailType_web.png")
    else
        self.imgMailType:loadTexture("123")
    end
end

function WidgetMailBoxItem:Initialize(_widget, _data)
    _widget.data = self
    self.widget = _widget
    self.data = _data

    self.lbTitle = self.widget:getChildByName("lbTitle")
    self.lbSender = self.widget:getChildByName("lbSender")
    self.lbTime = self.widget:getChildByName("lbTime")
    self.imgIsNew = self.widget:getChildByName("imgIsNew")
    self.imgMailType = self.widget:getChildByName("imgTypeIcon")

    self:Rebind()
end

return WidgetMailBoxItem