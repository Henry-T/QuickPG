--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:55:00
--

  
local PanelBase = require("app.view.PanelBase")

local LevelPanel = class("LevelPanel", PanelBase)

function LevelPanel:ctor(params)
    LevelPanel.super.ctor(self, params)
end

function LevelPanel:initialize(params)
    LevelPanel.super.initialize(self, params)
end

function LevelPanel:close(params)
    LevelPanel.super.close(self, params)
end

function LevelPanel:refresh(params)
    LevelPanel.super.refresh(self, params)
end

return LevelPanel