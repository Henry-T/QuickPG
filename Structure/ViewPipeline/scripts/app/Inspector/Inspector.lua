--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-09 16:14:31
--

local PropertyEntry = import(".PropertyEntry")
local PropertyHolder = import(".PropertyHolder")

local Inspector = class("Inspector", function()
	return display.newNode()
end)

function Inspector:ctor()
	self.entryHeight = 30
	self.entryHeightH = 11

end

function Inspector:SetTarget(target)
	self._target = target
	self:Refresh()
end

function Inspector:Refresh()

	self:removeAllChildren()
	local index = 0

	-- create properties
	for k,v in pairs(self._target) do
		if type(v) == "string" then
			local entry = self:createPropertyEntry(k, v)
			entry:pos(0, index * -self.entryHeight)
			entry:addTo(self)
			entry.onDelete = function()
				self:Refresh()
			end
			index = index + 1
		end
	end

	-- create new place holder
	local holder = self:createPropertyHolder()
	holder:pos(0, index * -self.entryHeight)
	holder:addTo(self)
	holder.onAdd= function()
		self:Refresh()
	end

end

function Inspector:changePropName(oldName, newName)
	if oldName and newName and oldName~="" and newName~="" then
		self._target[newName], self._target[oldName] = self._target[oldName], nil
	end
end

function Inspector:createPropertyEntry(name, value)
	return PropertyEntry.new(self._target, name, value)
end

function Inspector:createPropertyHolder()
	return PropertyHolder.new(self._target)
end

return Inspector
