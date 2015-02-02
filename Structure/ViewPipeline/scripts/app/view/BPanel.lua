--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 11:42:47
--

local PanelBase = require("app.view.PanelBase")

local BPanel = class("BPanel", PanelBase)

function BPanel:ctor()
	self._data = {}
end

function BPanel:refresh()
	global.inspector:SetTarget(self._data)
end

function BPanel:saveState()
	local persist = {}
	for k, v in pairs(self._data) do 
		persist[k] = v
	end
	return persist
end

function BPanel:loadState(persist)
	self._data = {}
	for k,v in pairs(persist) do
		self._data[k] = v
	end
	global.inspector:SetTarget(self._data)
end

return BPanel