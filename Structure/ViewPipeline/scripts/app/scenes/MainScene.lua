
local ViewPipeline = require("app.ViewPipeline.ViewPipeline")
local ViewStateInfo = require("app.ViewPipeline.ViewStateInfo")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    -- game stuff
    display.newSprite("bg.jpg")
        :anchor(0.5, 0.5)
        :pos(display.cx, display.cy)
        :addTo(self)

    viewPipe:setViewNode(self)
    viewPipe:setDebugNode(display.newNode():addTo(self))
    viewPipe:showDebugger(true)

    viewPipe:forward("MainPanel", ViewStateInfo.EMode_Layer)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
