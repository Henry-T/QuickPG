
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	self._upCnt = 0
	self._ctCnt = 0
	self._etCnt = 0

    self.layer = display.newColorLayer(ccc4(255,255,255,255)):addTo(self)
    self.layer:addNodeEventListener(cc.KEYPAD_EVENT,function(event)
        local str = "event.name:"..event.name  .."\t".. "event.key:"..event.key
        print(str)
        self._lb:setString(str)

        if event.key == "up" then
        	self._upCnt = self._upCnt + 1
        	self._lbUpCnt:setString(self._upCnt)
        elseif event.key == "center" then
        	self._ctCnt = self._ctCnt + 1
        	self._lbCtCnt:setString(self._ctCnt)
        elseif event.key == "enter" then
        	self._etCnt = self._etCnt + 1
        	self._lbEtCnt:setString(self._etCnt)
        end
    end)
    self.layer:setKeypadEnabled(true)

    self._lbUpCnt = ui.newTTFLabel({text="0", size=20, color=display.COLOR_BLACK, x=0, y=display.height-10})
    	:addTo(self)

    self._lbCtCnt = ui.newTTFLabel({text="0", size=20, color=display.COLOR_BLACK, x=0, y=display.height-40})
    	:addTo(self)

    self._lbEtCnt = ui.newTTFLabel({text="0", size=20, color=display.COLOR_BLACK, x=0, y=display.height-70})
    	:addTo(self)

    self._lb = ui.newTTFLabel({text="纯白 English 12345", size=32, color=display.COLOR_BLACK, x=0, y=display.cy+100}):addTo(self)
end

function MainScene:onEnter()

end

function MainScene:onExit()
end

return MainScene
