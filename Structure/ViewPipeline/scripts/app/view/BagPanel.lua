--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:54:49
--


  
local PanelBase = require("app.view.PanelBase")

local BagPanel = class("BagPanel", PanelBase)

function BagPanel:ctor(params)
    BagPanel.super.ctor(self, params)
end

function BagPanel:initialize(params)
    BagPanel.super.initialize(self, params)

    ui.newTTFLabel({font=FONT, size=FONT_SIZE, text="", align=ui.TEXT_ALGIN_LEFT})
    	:anchor(0, 0.5)
    	:pos(0, 0)
    	:addTo(self)
    	:string("this is Bag!")
end

function BagPanel:close(params)
    BagPanel.super.close(self, params)
end

function BagPanel:refresh(params)
    BagPanel.super.refresh(self, params)
end

return BagPanel