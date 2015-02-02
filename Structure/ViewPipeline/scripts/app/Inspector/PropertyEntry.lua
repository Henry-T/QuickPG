--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-09 16:40:46
--
local Button = require("app.view.Button")

local PropertyEntry = class("PropertyEntry", function()
	return display.newNode()
end)

function PropertyEntry:ctor(target, name)
	self._target = target
	self._name = name

	self.onDelete = nil

	self.height = 26
	self.heightH = 11
	self.nameX = 0
	self.nameWidth = 60
	self.valueX = 64
	self.valueWidth = 60
	self.btnX = 150

	ui.newTTFLabel({font=FONT, size=16, align=ui.TEXT_ALGIN_LEFT})
		:anchor(0, 0.5)
		:pos(0, self.heightH)
		:addTo(self)
		:string(name)

	local tbValue = ui.newEditBox({
		image = "60x24tbBg.png",
		listener = function(event, editbox)
			if evnet == "began" then
			elseif event == "changed" then
			elseif event == "ended" then
			elseif event == "return" then
				self:changeValue(string.trim(tbValue:getText()))
			end
		end,
		size = CCSize(self.valueWidth, self.height)
		})
		:anchor(0, 0.5)
		:pos(self.valueX, self.heightH)
		:addTo(self)

	tbValue:setText(self._target[name])

	-- local oldValue = ""

	-- local tbName = ui.newEditBox({
	-- 	listener = function(event, editbox)
	-- 		if evnet == "began" then
	-- 			oldName = string.trim(tbName:getText())
	-- 		elseif event == "changed" then
	-- 		elseif event == "ended" then
	-- 		elseif event == "return" then
	-- 			if not isPlaceHolder then
	-- 				local newName = string.trim(tbName:getText())
	-- 				if oldName ~= "" and newName ~= "" then
	-- 					self:changePropName(oldName, newName)
	-- 				end
	-- 			end
	-- 		end
	-- 	end,
	-- 	size = CCSize(60, 16)
	-- 	})
	-- 	:pos(40, entryHeightH)
	-- 	:addTo(self)

	Button.new("40x20button_n.png", "40x20button_h.png", "删除", function()
			self._target[self._name] = nil
			if self.onDelete then
				self.onDelete()
	    	end
	    end)
	    :pos(self.btnX, self.heightH)
	    :addTo(self)

end

function PropertyEntry:changeValue(value)
	self._target[self._name] = value
end


return PropertyEntry

