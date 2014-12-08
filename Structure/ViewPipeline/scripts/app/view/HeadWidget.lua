--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 14:47:56
--

local Button = require("app.view.Button")

local HeadWidget = class("HeadWidget", function()
		return display.newNode()
	end)

function HeadWidget:ctor( )
	Button.new("80x40button_n.png", "80x40button_h.png", "返回", function()
			viewPipe:back()
		end)
		:pos(display.width - 100, display.height-20)
	    :addTo(self)
end

return HeadWidget