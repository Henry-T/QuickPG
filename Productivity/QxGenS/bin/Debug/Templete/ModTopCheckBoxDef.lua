
    self._{0} = self:getWidgetByName("{0}")
    self._{0}:addEventListenerCheckBox(function(sender, eventType)
        -- QxGEN_CUSTOM_CHECK_CHANGE_BEGIN {0}
        if eventType == ccs.CheckBoxEventType.selected then
            -- TODO 选中 ...
        elseif eventType == ccs.CheckBoxEventType.unselected then
            -- TODO 取消 ...
        end
        -- QxGEN_CUSTOM_CHECK_CHANGE_END {0}
    end)
