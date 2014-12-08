--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 14:42:13
--

local Button = class("Button", function()
	return display.newNode()
end)

function Button:ctor(imgNormal, imgDown, text, onClick)
	self._imgNormal = display.newSprite(imgNormal or "80x40button_n.png")
		:anchor(0.5, 0.5)
		:pos(0, 0)
		:addTo(self)

	self._imgDown = display.newSprite(imgDown or "80x40button_h.png")
		:anchor(0.5, 0.5)
		:pos(0, 0)
		:addTo(self)
		:visible(false)

	ui.newTTFLabel({font=FONT, size=16, text=text, align=ui.TEXT_ALGIN_LEFT})
		:anchor(0.5, 0.5)
		:pos(0, 0)
		:addTo(self)

	self._imgNormal:setTouchEnabled(true)
	self._imgNormal:setTouchSwallowEnabled(true)
	self._imgNormal:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		if event.name == "began" then
			self._imgDown:visible(true)
			return true
		elseif event.name == "ended" then
			self._imgDown:visible(false)
			if onClick then
				onClick()
			end
		end
	end)
end

return Button