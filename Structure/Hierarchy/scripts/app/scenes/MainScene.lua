
local PanelX = import(".PanelX")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

end

function MainScene:onEnter()
  local px = PanelX.new()
  px:show({p="pp", c="cc"})
end

function MainScene:onExit()
end

return MainScene
