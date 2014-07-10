
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    text = ui.newTTFLabel({text = "Level 000", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self)

    text:setString(tostring(require("app.MyApp").CurLevel))
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
