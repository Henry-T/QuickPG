--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-08 14:55:50
--


--UIScene._uiLayer= nil
--UIScene._widget = nil

local PanelManager = {}

function PanelManager.StartRootPanel(layer)
    local scene = CCScene:create()
    scene:addChild(layer)
    CCDirector:sharedDirector():runWithScene(scene)
end

function PanelManager.SwitchRootPanel(layer)
    local scene = CCScene:create()
    scene:addChild(layer)
    CCDirector:sharedDirector():replaceScene(scene)
end

return PanelManager