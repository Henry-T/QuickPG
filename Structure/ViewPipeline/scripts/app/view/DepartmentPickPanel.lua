--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:56:12
--

  
local PanelBase = require("app.view.PanelBase")

local DepartmentPickPanel = class("DepartmentPickPanel", PanelBase)

function DepartmentPickPanel:ctor(params)
    DepartmentPickPanel.super.ctor(self, params)
end

function DepartmentPickPanel:initialize(params)
    DepartmentPickPanel.super.initialize(self, params)
end

function DepartmentPickPanel:close(params)
    DepartmentPickPanel.super.close(self, params)
end

function DepartmentPickPanel:refresh(params)
    DepartmentPickPanel.super.refresh(self, params)
end

return DepartmentPickPanel