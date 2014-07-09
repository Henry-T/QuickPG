local Test_UILayout_Relative = class("Test_UILayout_Relative")

function Test_UILayout_Relative.Create()
  local scene = CCScene.create(CCScene) -- 这都行...
  local uiLayer = TouchGroup:create()
  scene:addChild(uiLayer)

  -- 创建底色
  local color = Layout:create()
  color:setAnchorPoint(CCPoint(0.5, 0.5))
  color:setSize(CCSize(display.width, display.height))
  color:setBackGroundColorType(LAYOUT_COLOR_SOLID);
  color:setBackGroundColor(ccc3(200, 200, 200));
  color:setPosition(CCPoint(display.cx, display.cy))
  uiLayer:addChild(color)

  -- 创建测试容器
  local panel = Layout:create()
  panel:setAnchorPoint(CCPoint(0, 0))
  panel:setPosition(CCPoint(80, 80))
  panel:setSize(CCSize(480-160, 320-160))
  panel:setBackGroundColorType(LAYOUT_COLOR_SOLID)
  panel:setBackGroundColor(ccc3(240, 240, 240))
  panel:setLayoutType(LAYOUT_RELATIVE)
  uiLayer:addChild(panel)

  -- 创建Grid
  for i=1,12 do
    local lineH = Layout:create()
    lineH:setAnchorPoint(CCPoint(0, 0))
    lineH:setSize(CCSize(display.width, 1))
    lineH:setBackGroundColorType(LAYOUT_COLOR_SOLID);
    lineH:setBackGroundColor(ccc3(0, 0, 0));
    lineH:setPosition(CCPoint(0, 40 * i))
    uiLayer:addChild(lineH)

    local lineV = Layout:create()
    lineV:setAnchorPoint(CCPoint(0, 0))
    lineV:setSize(CCSize(1, display.height))
    lineV:setBackGroundColorType(LAYOUT_COLOR_SOLID)
    lineV:setBackGroundColor(ccc3(0, 0, 0))
    lineV:setPosition(CCPoint(40 * i, 0))
    uiLayer:addChild(lineV)
  end

  local img = ImageView:create()
  img:loadTexture("40.png")
  local layoutParam = UIRelativeLayoutParameter:create()
  local align = UIRelativeAlign.create()
  layoutParam:setAlign(RELATIVE_ALIGN_PARENT_TOP_RIGHT)
  img:setLayoutParameter(layoutParam)
  panel:addChild(img)

  local uiLayout = Layout:create()
  uiLayout:setBackGroundColorType(LAYOUT_COLOR_SOLID);
  uiLayout:setBackGroundColor(ccc3(128, 128, 128));
  uiLayer:addChild(uiLayout)

  return scene
end

return Test_UILayout_Relative