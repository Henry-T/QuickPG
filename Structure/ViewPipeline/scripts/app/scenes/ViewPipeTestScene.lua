--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:26:19
--

local ViewPipeline = require("app.ViewPipeline.ViewPipeline")
local ViewStateInfo = require("app.ViewPipeline.ViewStateInfo")
local Button = require("app.view.Button")

local ViewPipeTestScene = class("ViewPipeTestScene", function()
    return display.newScene("ViewPipeTestScene")
end)

function ViewPipeTestScene:ctor()

    local names = {"X","A","B"}

    for i, name in ipairs(names) do
        Button.new("80x20button_n.png", "80x20button_h.png", "堆叠"..name, function()
                viewPipe:pushPanel(name.."Panel")
            end)
            :pos(90*1-40, display.height+10-28*i)
            :addTo(self)

        Button.new("80x20button_n.png", "80x20button_h.png", "替换"..name, function()
                viewPipe:replacePanel(name.."Panel")
            end)
            :pos(90*2-40, display.height+10-28*i)
            :addTo(self)

        Button.new("80x20button_n.png", "80x20button_h.png", "层叠"..name, function()
                viewPipe:addPanel(name.."Panel")
            end)
            :pos(90*3-40, display.height+10-28*i)
            :addTo(self)
    end

    Button.new("80x20button_n.png", "80x20button_h.png", "返回", function()
            viewPipe:back()
        end)
        :pos(90*1-40, display.height+10-28*4)
        :addTo(self)

    Button.new("80x20button_n.png", "80x20button_h.png", "清空", function()
            viewPipe:clear()
        end)
        :pos(90*2-40, display.height+10-28*4)
        :addTo(self)

    viewPipe:setViewNode(display.newNode():addTo(self))
    viewPipe:setDebugNode(display.newNode():addTo(self))
    viewPipe:showDebugger(true)
end

function ViewPipeTestScene:onEnter()
end

function ViewPipeTestScene:onExit()
end

return ViewPipeTestScene
