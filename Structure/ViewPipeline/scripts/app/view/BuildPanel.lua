--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:54:55
--

  
local PanelBase = require("app.view.PanelBase")

local BuildPanel = class("BuildPanel", PanelBase)

function BuildPanel:ctor(params)
    BuildPanel.super.ctor(self, params)
end

function BuildPanel:initialize(params)
    BuildPanel.super.initialize(self, params)

    ui.newTTFLabel({font=FONT, size=FONT_SIZE, text="", align=ui.TEXT_ALGIN_LEFT})
    	:anchor(0, 0.5)
    	:pos(display.cx, display.cy)
    	:addTo(self)
    	:string("建造")
end

function BuildPanel:close(params)
    BuildPanel.super.close(self, params)
end

function BuildPanel:refresh(params)
    BuildPanel.super.refresh(self, params)
end

return BuildPanel