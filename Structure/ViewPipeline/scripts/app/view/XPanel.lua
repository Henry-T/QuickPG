--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 11:42:47
--

local PanelBase = require("app.view.PanelBase")

local XPanel = class("XPanel", PanelBase)

function XPanel:ctor()
	self._data = {}
end

function XPanel:refresh()
	global.inspector:SetTarget(self._data)
end

return XPanel