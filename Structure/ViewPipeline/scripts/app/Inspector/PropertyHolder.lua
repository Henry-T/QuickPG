--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-09 16:40:53
--

local Button = require("app.view.Button")

local PropertyHolder = class("PropertyHolder", function()
	return display.newNode()
end)

function PropertyHolder:ctor(target)
	self._target = target

	self.onDelete = nil

	self.height = 26
	self.heightH = 11
	self.nameX = 0
	self.nameWidth = 60
	self.valueX = 64
	self.valueWidth = 60
	self.btnX = 150

	local tbName = ui.newEditBox({
			image = "60x24tbBg.png",
			size = CCSize(self.nameWidth, self.height)
		})
		:anchor(0, 0.5)
		:pos(self.nameX, self.heightH)
		:addTo(self)

	local tbValue = ui.newEditBox({
			image = "60x24tbBg.png",
			size = CCSize(self.valueWidth, self.height)
		})
		:anchor(0, 0.5)
		:pos(self.valueX, self.heightH)
		:addTo(self)

	Button.new("40x20button_n.png", "40x20button_h.png", "添加", function()
			local name = string.trim(tbName:getText())
			local value = string.trim(tbValue:getText())
			if name~="" and value~="" then
				self._target[name] = value
			end

			if self.onAdd then
				self.onAdd()
			end
		end)
	    :pos(self.btnX, self.heightH)
	    :addTo(self)
end

return PropertyHolder

