--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:54:33
--

  
local PanelBase = require("app.view.PanelBase")
local HeadWidget = require("app.view.HeadWidget")
local Button = require("app.view.Button")

local StatusPanel = class("StatusPanel", PanelBase)

function StatusPanel:ctor(params)
    StatusPanel.super.ctor(self, params)
end

function StatusPanel:initialize(params)
    StatusPanel.super.initialize(self, params)

    ui.newTTFLabel({font=FONT, size=FONT_SIZE, text="", align=ui.TEXT_ALGIN_LEFT})
    	:anchor(0, 0.5)
    	:pos(display.cx, display.cy)
    	:addTo(self)
    	:string("状态")

    HeadWidget.new():addTo(self)
end

function StatusPanel:close(params)
    StatusPanel.super.close(self, params)
end

function StatusPanel:refresh(params)
    StatusPanel.super.refresh(self, params)
end

return StatusPanel