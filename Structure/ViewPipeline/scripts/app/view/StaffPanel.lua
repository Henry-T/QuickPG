--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:55:05
--

  
local PanelBase = require("app.view.PanelBase")
local HeadWidget = require("app.view.HeadWidget")
local Button = require("app.view.Button")

local StaffPanel = class("StaffPanel", PanelBase)

function StaffPanel:ctor(params)
    StaffPanel.super.ctor(self, params)
end

function StaffPanel:initialize(params)
    StaffPanel.super.initialize(self, params)

    Button.new(nil, nil, "部门", function()
    		viewPipe:addPanel("DepartmentPanel")
    	end)
   		:pos(display.cx, 80)
    	:addTo(self)

    HeadWidget.new():addTo(self)
end

function StaffPanel:close(params)
    StaffPanel.super.close(self, params)
end

function StaffPanel:refresh(params)
    StaffPanel.super.refresh(self, params)
end

return StaffPanel