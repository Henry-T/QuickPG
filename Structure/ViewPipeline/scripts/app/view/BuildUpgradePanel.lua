--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:56:39
--

  
local PanelBase = require("app.view.PanelBase")

local BuildUpgradePanel = class("BuildUpgradePanel", PanelBase)

function BuildUpgradePanel:ctor(params)
    BuildUpgradePanel.super.ctor(self, params)
end

function BuildUpgradePanel:initialize(params)
    BuildUpgradePanel.super.initialize(self, params)
end

function BuildUpgradePanel:close(params)
    BuildUpgradePanel.super.close(self, params)
end

function BuildUpgradePanel:refresh(params)
    BuildUpgradePanel.super.refresh(self, params)
end

return BuildUpgradePanel