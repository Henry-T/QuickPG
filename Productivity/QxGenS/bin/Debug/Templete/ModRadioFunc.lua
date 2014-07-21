
function {0}:onRadGroup{1}Changed(sender, eventType)
    -- QxGEN_CUSTOM_RADIOGROUP_CHANGE_BEGIN {1}
    if eventType == ccs.CheckBoxTouchEvent.selected then
      -- HERE 自定义选中代码
    elseif eventType == ccs.CheckBoxTouchEvent.unselected then
        -- TODO 完善 .. 对Radio Group禁用Unselect
    else
    -- QxGEN_CUSTOM_RADIOGROUP_CHANGE_END {1}
end
