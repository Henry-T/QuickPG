--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 11:42:47
--

local PanelBase = require("app.view.PanelBase")

local APanel = class("APanel", PanelBase)

function APanel:ctor()
	self._data = {}
end

function APanel:refresh()
	global.inspector:SetTarget(self._data)
end

function APanel:saveState()
	local persist = {}
	for k, v in pairs(self._data) do 
		persist[k] = v
	end
	return persist
end

function APanel:loadState(persist)
	self._data = {}
	for k,v in pairs(persist) do
		self._data[k] = v
	end
	global.inspector:SetTarget(self._data)
end

return APanel