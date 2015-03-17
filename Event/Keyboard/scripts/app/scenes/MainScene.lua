
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self.layer = display.newColorLayer(ccc4(255,255,255,255)):addTo(self)
    self.layer:addNodeEventListener(cc.KEYPAD_EVENT,function(event)
        local str = "event.name:"..event.name  .."\t".. "event.key:"..event.key
        print(str)
        self._lb:setString(str)
    end)
    self.layer:setKeypadEnabled(true)

    self._lb = ui.newTTFLabel({text="纯白 English 12345", size=32, color=display.COLOR_BLACK, x=0, y=display.cy+100}):addTo(self)
end

function MainScene:onEnter()

end

function MainScene:onExit()
end

return MainScene
