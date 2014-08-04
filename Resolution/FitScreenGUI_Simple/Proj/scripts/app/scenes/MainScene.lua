
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    local _uiLayer = TouchGroup:create()
    _uiLayer:setContentSize(CCSize(100,100))
    self:addChild(_uiLayer)

    -- 带标尺的底图
    local bg = ImageView:create()
    bg:loadTexture("grid1140x640.png")
    bg:setAnchorPoint(CCPoint(0.5, 0.5))
    bg:setPosition(CCPoint(display.cx, display.cy))
    bg:setSize(CCSize(100, 100))
    _uiLayer:addChild(bg)

    -- 加载Max面板
    local node = CCNode:create()
    _uiLayer:addChild(node)
    node:setContentSize(CCSize(100, 100))


    local sprite = ImageView:create()
    sprite:loadTexture("40.png")
    sprite:setPosition(CCPoint(0, 0))
    sprite:setContentSize(CCSize(1,1))
    node:addChild(sprite)


    self._widget = GUIReader:shareReader():widgetFromJsonFile("res/UIProj/PanelMax.json")
    sprite:addChild(self._widget)

    print(tolua.type(self._widget))
    local p3 = _uiLayer:getWidgetByName("Panel_3")
    print(tolua.type(self._widget))

    -- 安全区标志
    self._guide = TouchGroup:create()
    self:addChild(self._guide)
    
    local safeLeft = Layout:create()
    safeLeft:setAnchorPoint(CCPoint(0.5, 0.5))
    safeLeft:setSize(CCSize(4, display.height))
    safeLeft:setBackGroundColorType(LAYOUT_COLOR_SOLID);
    safeLeft:setBackGroundColor(ccc3(255, 255, 0));
    safeLeft:setPosition(CCPoint(display.safeLeft, display.cy))
    self._guide:addChild(safeLeft)

    local safeRight = Layout:create()
    safeRight:setAnchorPoint(CCPoint(0.5, 0.5))
    safeRight:setSize(CCSize(4, display.height))
    safeRight:setBackGroundColorType(LAYOUT_COLOR_SOLID);
    safeRight:setBackGroundColor(ccc3(255, 255, 0));
    safeRight:setPosition(CCPoint(display.safeRight, display.cy))
    self._guide:addChild(safeRight)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
