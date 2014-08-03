
    widget{0}._{1} = UIHelper:seekWidgetByName(widget{0}, "{1}")
    widget{0}._{1}:addTouchEventListener(function(sender, eventType)
        -- QxGEN_CUSTOM_BTN_TOUCH_BEGIN widget{0}.{1}
        if eventType == ccs.TouchEventType.ended then
        end
        -- QxGEN_CUSTOM_BTN_TOUCH_END widget{0}.{1}
    end)
