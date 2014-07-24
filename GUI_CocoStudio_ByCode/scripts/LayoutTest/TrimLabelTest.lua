--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-24 11:09:00
--

-- 测试验证Label的尺寸是随内容变化的
local TrimLabelTest = class("TrimLabelTest", function()
    return CCScene:create()
end)

function TrimLabelTest:ctor()
    local _uiLayer = TouchGroup:create()
    _uiLayer:setTouchEnabled(true)
    self._uiLayer = _uiLayer
    self:addChild(_uiLayer)

    -- 创建底色
    local color = Layout:create()
    color:setAnchorPoint(CCPoint(0.5, 0.5))
    color:setSize(CCSize(display.width, display.height))
    color:setBackGroundColorType(LAYOUT_COLOR_SOLID);
    color:setBackGroundColor(ccc3(200, 200, 200));
    color:setPosition(CCPoint(display.cx, display.cy))
    _uiLayer:addChild(color)

    -- Label
    local label = Label:create()
    label:setText("hello!\n111111\n222222\n333333\n444444\n555555")
    label:setPosition(CCPoint(display.cx, display.cy))
    _uiLayer:addChild(label)

    local size = label:getSize()

    local rect = display.newRect(size.width, size.height)
    rect:setPosition(CCPoint(display.cx, display.cy))
    _uiLayer:addChild(rect)

    -- 创建Grid
    for i=1,12 do
      local lineH = Layout:create()
      lineH:setAnchorPoint(CCPoint(0, 0))
      lineH:setSize(CCSize(display.width, 1))
      lineH:setBackGroundColorType(LAYOUT_COLOR_SOLID);
      lineH:setBackGroundColor(ccc3(0, 0, 0));
      lineH:setPosition(CCPoint(0, 40 * i))
      _uiLayer:addChild(lineH)

      local lineV = Layout:create()
      lineV:setAnchorPoint(CCPoint(0, 0))
      lineV:setSize(CCSize(1, display.height))
      lineV:setBackGroundColorType(LAYOUT_COLOR_SOLID)
      lineV:setBackGroundColor(ccc3(0, 0, 0))
      lineV:setPosition(CCPoint(40 * i, 0))
      _uiLayer:addChild(lineV)
    end

    local btn = Button:create()
    btn:loadTextureNormal("80x40button_n.png")
    btn:setAnchorPoint(CCPoint(0,1))
    btn:setPosition(CCPoint(100, 100))
    btn:setTitleText("改变文本")
    btn:setTouchEnabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        print("Ok")
        if eventType == 3 then
            print("3")
        end
    end)
    _uiLayer:addChild(btn)

end

return TrimLabelTest