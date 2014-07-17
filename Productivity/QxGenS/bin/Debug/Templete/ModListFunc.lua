
function {0}:add{1}(data)
    local widget{1} = GUIReader():shareReader():widgetFromJsonFile("widget{1}.json")
    widget{1}._data = data
    
    -- QxGEN_SUB_CTRL_DEF {1}

    -- QxGEN_CUSTOM_LIST_ADD_BEGIN {1}
    -- HERE 这里通常写数据绑定代码
    -- QxGEN_CUSTOM_LIST_ADD_END {1}
end
