--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 14:02:56
--

local ViewStateInfo = require("app.ViewPipeline.ViewStateInfo")
  
local PanelBase = require("app.view.PanelBase")

local MainPanel = class("MainPanel", PanelBase)

function MainPanel:ctor(params)
    MainPanel.super.ctor(self, params)
end

function MainPanel:initialize(params)
    MainPanel.super.initialize(self, params)

    local createBtn = function(pos, text, func)
        local btn = display.newSprite("80x40button_n.png", 90*pos-80, display.height-20)
            :anchor(0, 0.5)
            :addTo(self)
        ui.newTTFLabel({font=FONT, size=FONT_SIZE, text="", align=ui.TEXT_ALGIN_LEFT})
            :anchor(0.5, 0.5)
            :pos(40, 20)
            :addTo(btn)
            :string(text)
        btn:setTouchEnabled(true)
        btn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name == "began" then
                func()
            end
        end)
    end

    createBtn(1, "状态", function()
        viewPipe:pushPanel("StatusPanel")
    end)
    -- createBtn(2, "行动", function()
    --     viewPipe:forward("ActionPanel", ViewStateInfo.EMode_Layer)
    -- end)
    -- createBtn(3, "物品", function()
    --     viewPipe:forward("BagPanel", ViewStateInfo.EMode_Layer)
    -- end)
    -- createBtn(4, "改建", function()
    --     viewPipe:forward("BuildPanel", ViewStateInfo.EMode_Layer)
    -- end)
    createBtn(2, "成员", function()
        viewPipe:pushPanel("StaffPanel")
    end)
    -- createBtn(6, "关卡", function()
    --     viewPipe:forward("LevelPanel", ViewStateInfo.EMode_Layer)
    -- end)

    -- createBtn(4, "Back", function()
    --     viewPipe:back()
    -- end)

    -- createBtn(5, "Close", function()
    --     viewPipe:clear()
    -- end)

end

function MainPanel:close(params)
    MainPanel.super.close(self, params)
end

function MainPanel:refresh(params)
    MainPanel.super.refresh(self, params)
end

return MainPanel