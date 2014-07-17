
    self._{0} = self:getWidgetByName("{0}")
    self._{0}:addTouchEventListener(function(sender, eventType)
        -- QxGEN_CUSTOM_BTN_TOUCH_BEGIN {0}
        if eventType == ccs.TouchEventType.ended then
        end
        -- QxGEN_CUSTOM_BTN_TOUCH_END {0}
    end)
