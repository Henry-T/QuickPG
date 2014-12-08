--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:54:44
--

  
local PanelBase = require("app.view.PanelBase")

local ActionPanel = class("ActionPanel", PanelBase)

function ActionPanel:ctor(params)
    ActionPanel.super.ctor(self, params)
end

function ActionPanel:initialize(params)
    ActionPanel.super.initialize(self, params)

    ui.newTTFLabel({font=FONT, size=FONT_SIZE, text="", align=ui.TEXT_ALGIN_LEFT})
    	:anchor(0, 0.5)
    	:pos(display.cx, display.cy)
    	:addTo(self)
    	:string("行动")
end

function ActionPanel:close(params)
    ActionPanel.super.close(self, params)
end

function ActionPanel:refresh(params)
    ActionPanel.super.refresh(self, params)
end

return ActionPanel