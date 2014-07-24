--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-24 10:26:58
--
local ScrollView_Slider = class("ScrollView_Slider", function()
    return CCScene:create()
end)

local margin = 40
local marginH = 20
local marginD = 80

function ScrollView_Slider:ctor()
    self._uiLayer = TouchGroup:create()
    self:addChild(self._uiLayer)

    -- ## 尺寸
    local scrollWidth = display.width - marginD
    local scrollHeight = display.height - marginD

    local screenCenter = CCPoint(display.width/2, display.height/2)
    local centerAnchor = CCPoint(0.5, 0.5)

    -- 创建底色
    local color = Layout:create()
    color:setAnchorPoint(CCPoint(0.5, 0.5))
    color:setSize(CCSize(display.width, display.height))
    color:setBackGroundColorType(LAYOUT_COLOR_SOLID);
    color:setBackGroundColor(ccc3(200, 200, 200));
    color:setPosition(CCPoint(display.cx, display.cy))
    self._uiLayer:addChild(color)

    -- 创建测试容器
    local panel = Layout:create()
    panel:setAnchorPoint(CCPoint(0, 0))
    panel:setPosition(CCPoint(80, 80))
    panel:setSize(CCSize(480-160, 320-160))
    panel:setBackGroundColorType(LAYOUT_COLOR_SOLID)
    panel:setBackGroundColor(ccc3(240, 240, 240))
    panel:setLayoutType(LAYOUT_LINEAR_VERTICAL)
    self._uiLayer:addChild(panel)


    -- ## 水平滚动的ScrollView
    local scrollView = ScrollView:create()
    scrollView:setTouchEnabled(true)
    scrollView:setAnchorPoint(centerAnchor)
    scrollView:setSize(CCSize(scrollWidth, scrollHeight))
    scrollView:setPosition(CCPoint(display.cx, display.cy))
    scrollView:setBounceEnabled(true)
    scrollView:setDirection(3)    -- both

    scrollView:setBackGroundColor(ccc3(0, 255 , 0))
    scrollView:setBackGroundColorType(1)
    self._uiLayer:addChild(scrollView)

    local slider = Slider:create()
    slider:loadBarTexture("slice30.png")
    slider:setScale9Enabled(true)
    slider:setSize(CCSize(40, 240))
    slider:setPosition(CCPoint(display.width-marginH,display.cy))
    self._uiLayer:addChild(slider)

    -- 创建Grid
    for i=1,12 do
        local lineH = Layout:create()
        lineH:setAnchorPoint(CCPoint(0, 0))
        lineH:setSize(CCSize(display.width, 1))
        lineH:setBackGroundColorType(LAYOUT_COLOR_SOLID);
        lineH:setBackGroundColor(ccc3(0, 0, 0));
        lineH:setPosition(CCPoint(0, 40 * i))
        self._uiLayer:addChild(lineH)

        local lineV = Layout:create()
        lineV:setAnchorPoint(CCPoint(0, 0))
        lineV:setSize(CCSize(1, display.height))
        lineV:setBackGroundColorType(LAYOUT_COLOR_SOLID)
        lineV:setBackGroundColor(ccc3(0, 0, 0))
        lineV:setPosition(CCPoint(40 * i, 0))
        self._uiLayer:addChild(lineV)
    end
end

return ScrollView_Slider