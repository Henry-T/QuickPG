
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    ui.newTTFLabel({text = "Path:"..device.writablePath, x = 10, y = display.cy, align = ui.TEXT_ALIGN_CENTER})
        :addTo(self)
end

function MainScene:onEnter()

end

function MainScene:onExit()
end

return MainScene
