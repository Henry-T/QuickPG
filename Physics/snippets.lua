
local xy = display.newSprite(UI_RES.."img.png")
	:anchor(0.5, 0.5)
	:pos(display.cx, display.cy)
	:addTo(self)
xy:setTouchEnabled(true)
xy:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
	if event.name == "began" then
		local color = xy:getColorAtPoint(CCPoint(event.x, event.y), true, true)
		-- print(color.r, color.g, color.b, color.a)
		if color.a==0 then
			print("valid pixel pick!")
		end
	end
end)