
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

    local node = CCNode:create()
    _uiLayer:addChild(node)
    node:setContentSize(CCSize(100, 100))

    -- 9 scale
    --- display.newScale9Sprite("30round.png", display.cx, display.cy):size(320, 320):addTo(self):cap(10, 10, 10, 10)

    --- very basic sprite
    -- local sprite = display.newSprite("40.png", display.cx, display.cy):addTo(self)
    -- print("getContentSize() returns: ", sprite:getContentSize().width, sprite:getContentSize().height)

    -- local sprite = display.newSprite("40.png", display.cx, display.cy, {size=cc.size(48, 48)}):addTo(self)
    -- sprite:setAnchorPoint(CCPoint(0.5, 0.5))
    -- sprite:scale(2)
    -- sprite:setContentSize(cc.size(64, 64))

    -- LabelAtlas Test
    -- local lbAtlas = ui.newLabelAtlas("0123456789", "num19x26.png", 19, 26, string.byte("0")):pos(display.cx, display.cy):addTo(self)
    -- lbAtlas:pos(display.cx, display.cy)
    -- lbAtlas:scale(1)

    -- 
    local bmFont = ui.newBMFontLabel({text = "仁义礼智信", font = "nature.fnt",}):pos(display.cx, display.cy):addTo(self)

    -- local sprite = ImageView:create()
    -- sprite:loadTexture("40.png")
    -- sprite:setPosition(CCPoint(0, 0))
    -- sprite:setContentSize(CCSize(1,1))
    -- node:addChild(sprite)

    --local sprite = display.newSprite("40.png"):pos(display.cx, display.cy):addTo(self)

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
