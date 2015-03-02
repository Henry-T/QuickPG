
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    display.newColorLayer(ccc4(255, 255, 255, 255)):addTo(self)

    local lb = ui.newTTFLabel({text="纯白 English 12345", size=64, color=display.COLOR_WHITE, x=0, y=display.cy+100}):addTo(self)
    
    local lb = ui.newTTFLabel({text="纯黑 English 12345", size=64, color=display.COLOR_BLACK, x=0, y=display.cy-100}):addTo(self)
    
    -- local lb = ui.newTTFLabelWithOutline({text="中文 English 12345", outlineColor=ccc3(136, 44, 32), size=128, color=display.COLOR_BLUE, x=0, y=display.cy}):addTo(self)

    -- lb:enableStroke(display.COLOR_BLUE, 1)
    -- lb:setFontFillColor(display.COLOR_BLUE)
end

function MainScene:onEnter()

end

function MainScene:onExit()
end

return MainScene
