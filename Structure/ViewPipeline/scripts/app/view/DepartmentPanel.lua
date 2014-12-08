--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:55:30
--


local PanelBase = require("app.view.PanelBase")
local HeadWidget = require("app.view.HeadWidget")

local DepartmentPanel = class("DepartmentPanel", PanelBase)

function DepartmentPanel:ctor(params)
    DepartmentPanel.super.ctor(self, params)
end

function DepartmentPanel:initialize(params)
    DepartmentPanel.super.initialize(self, params)
    
    HeadWidget.new():addTo(self)
end

function DepartmentPanel:close(params)
    DepartmentPanel.super.close(self, params)
end

function DepartmentPanel:refresh(params)
    DepartmentPanel.super.refresh(self, params)
end

return DepartmentPanel