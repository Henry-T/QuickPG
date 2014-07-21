
function {0}:show(parent)
    if not self._isShowing then
        self._isShowing = true
        parent:addChild(self)
    end
end

-- QxGEN_CUSTOM_LIST_REFRESH_BEGIN {0}
-- TODO 请将这个函数改为你自己的Panel刷新逻辑
function {0}:refreshView()
end
-- QxGEN_CUSTOM_LIST_REFRESH_END {0}

function {0}:close()
    if self._isShowing then
        self._isShowing = false
        -- TODO 移除所有的list项 以节约内存
        -- 例如:
        -- self._listMails:removeAllItems()
        transition.scaleTo(self, {{time = .2, scale = .2, easing = "BACKIN", onComplete = function ()
            self:removeFromParentAndCleanup(true)
            self:setScale(1)
        end}})
    end
end

return {0}
