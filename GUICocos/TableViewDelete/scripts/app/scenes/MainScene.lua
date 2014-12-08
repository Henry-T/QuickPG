
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

	ui.newTTFLabel({text = "123123", size = 24, align = ui.TEXT_ALIGN_CENTER})
	    :pos(200, 200)
	    :addTo(self)

    local tv = CCTableView:create(CCSize(400, 300))
	tv:setDirection(kCCScrollViewDirectionVertical)
	tv:setVerticalFillOrder(kCCTableViewFillTopDown)
    tv:setIgnoreAnchorPointForPosition(false)

    tv:pos(200, 200)
    tv:addTo(self)

    tv:registerScriptHandler(handler(self, self.tableHandlerItemCount), CCTableView.kNumberOfCellsInTableView)
    tv:registerScriptHandler(handler(self, self.tableHandlerItemSize), CCTableView.kTableCellSizeForIndex)
    tv:registerScriptHandler(handler(self, self.tableHandlerItemItem), CCTableView.kTableCellSizeAtIndex)
end

function MainScene:tableHandlerItemCount(table, index)
	return 5
end

function MainScene:tableHandlerItemSize(table, index)
	return 20, 100
end

function MainScene:tableHandlerItemItem(table, rowIndex)
	local cell = table:dequeueCell()
	if cell then
		cell:removeFromParentAndCleanup(true)
	end

	-- print("okokokok!")

	cell = CCTableViewCell:new()
	-- cell:setContentSize(100, 20)
	-- cell:ignoreAnchorPointForPosition(false)
	-- cell:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])

	-- ui.newTTFLabel({text = "123123", size = 12, align = ui.TEXT_ALIGN_CENTER})
	--     :pos(0, 0)
	--     :addTo(cell)
	return cell
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
