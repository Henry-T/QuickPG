--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:56:33
--

  
local PanelBase = require("app.view.PanelBase")

local BuildTypePickPanel = class("BuildTypePickPanel", PanelBase)

function BuildTypePickPanel:ctor(params)
    BuildTypePickPanel.super.ctor(self, params)
end

function BuildTypePickPanel:initialize(params)
    BuildTypePickPanel.super.initialize(self, params)
end

function BuildTypePickPanel:close(params)
    BuildTypePickPanel.super.close(self, params)
end

function BuildTypePickPanel:refresh(params)
    BuildTypePickPanel.super.refresh(self, params)
end

return BuildTypePickPanel