

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self._testPanel = import("app.ui.PanelTest").new()
    --self:addChild(self._testPanel)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
