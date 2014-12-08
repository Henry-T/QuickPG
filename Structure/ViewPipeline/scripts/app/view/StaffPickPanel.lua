--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:55:56
--

  
local PanelBase = require("app.view.PanelBase")

local StaffPickPanel = class("StaffPickPanel", PanelBase)

function StaffPickPanel:ctor(params)
    StaffPickPanel.super.ctor(self, params)
end

function StaffPickPanel:initialize(params)
    StaffPickPanel.super.initialize(self, params)
end

function StaffPickPanel:close(params)
    StaffPickPanel.super.close(self, params)
end

function StaffPickPanel:refresh(params)
    StaffPickPanel.super.refresh(self, params)
end

return StaffPickPanel