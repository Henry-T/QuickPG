local ScrollGrid = class("ScrollGrid", function()
    return display.newScene("ScrollGrid")
end)

local margin = 40
local marginH = 20
local marginD = 80

function ScrollGrid:ctor()

  -- ## 纯色背景
  display.newColorLayer(ccc4(255, 255, 255, 255)):addTo(self)

  -- ## 网格
  for y = display.bottom, display.top, 40 do
      local line = display.newPolygon({{display.left, y}, {display.right, y}}):addTo(self)
      line:setLineColor(ccc4f(0.9, 0.9, 0.9, 1.0))
  end

  for x = display.left, display.right, 40 do
      local line = display.newPolygon({{x, display.top}, {x, display.bottom}}):addTo(self)
      line:setLineColor(ccc4f(0.9, 0.9, 0.9, 1.0))
  end

  local line = display.newPolygon({{display.left, display.cy}, {display.right, display.cy}}):addTo(self)
  line:setLineColor(ccc4f(1.0, 0.75, 0.75, 1.0))

  local line = display.newPolygon({{display.cx, display.top}, {display.cx, display.bottom}}):addTo(self)
  line:setLineColor(ccc4f(1.0, 0.75, 0.75, 1.0))

  -- ## 尺寸
  local scrollWidth = display.width - marginD
  local scrollHeight = display.height - marginD

  local screenCenter = CCPoint(display.width/2, display.height/2)
  local centerAnchor = CCPoint(0.5, 0.5)

  -- ## 底图
  local bg = cc.ui.UIImage.new("10gradient.png", {scale9 = true})
    :pos(display.cx, display.cy)
    :setLayoutSize(scrollWidth, scrollHeight)
    :addTo(self)
  bg:setAnchorPoint(CCPoint(0.5, 0.5))

  -- ## 水平滚动的ScrollView
  local scrollView = ScrollView:create()
  scrollView:setTouchEnabled(true)
  scrollView:setAnchorPoint(centerAnchor)
  scrollView:setSize(CCSize(scrollWidth, scrollHeight))
  scrollView:setPosition(CCPoint(display.cx, display.cy))
  scrollView:setBounceEnabled(true)
  scrollView:setDirection(3)    -- both

  --scrollView:setBackGroundColor(ccc3(0, 255 , 0))
  --scrollView:setBackGroundColorType(1)

  self:addChild(scrollView)


  for i=0,19 do
    for j=0,19 do
      local imageView = ImageView:create()
      imageView:loadTexture("10halfAlpha.png");
      imageView:setScale9Enabled(true);
      imageView:setPosition(CCPoint((i)*80, (j)*20))
      imageView:setSize(CCSize(78, 18))
      imageView:setAnchorPoint(CCPoint(0, 0))
      imageView:setTouchEnabled(true)
      scrollView:addChild(imageView, 0)

      -- 文本
      local t = Label:create()
      t:setText(i .. "-" .. j)
      --t:setFontName(getFont())
      t:setFontSize(15)
      t:setColor(ccc3(159, 168, 176))
      t:setPosition(CCPoint(imageView:getSize().width / 2.0, imageView:getSize().height / 2.0 ))
      imageView:addChild(t)
    end
  end



  local oWidth = scrollView:getSize().width
  local oHeight = scrollView:getSize().height

  local contentHeight = 20 * 20
  local contentWidth = 20 * 80

  local setHeight = contentHeight
  if setHeight < oHeight then
    setHeight = oHeight
  end

  local setWidth = contentWidth
  if setWidth < oWidth then
    setWidth = oWidth
  end

  scrollView:setInnerContainerSize(CCSize(setWidth, setHeight));
   --scrollView:scrollToTop(5000, true);

  function scrollView:ccTouchBegan(touch, event)
    print("What!")
  end

  function scrollView:touchEvent(type)
    print("What! 2")
  end

  --scrollView:scrollToPercentBothDirection(CCPoint(50, 50), 10, true)

  -- ## 垂直滚动条
  SLIDER_IMAGES2 = {
    bar = "30x120vscrollbar.png",
    button = "30x60vscrollhandle.png",
  }

  local vScroll = cc.ui.UISlider.new(display.TOP_TO_BOTTOM, SLIDER_IMAGES2, {scale9 = true})
      :onSliderValueChanged(function(event)
        printf(string.format("value = %0.2f", event.value))
          scrollView:scrollToPercentVertical(event.value, 0.1, true);
      end)
      :setSliderSize(30, display.height - marginD)
      :setSliderValue(75)
      :align(display.CENTER, display.width - 25, display.height / 2)
      :addTo(self)

  -- ## 水平滚动条
  SLIDER_IMAGES = {
    bar = "120x30hscrollbar.png",
    button = "60x30hscrollhandle.png",
  }

  local hScroll = cc.ui.UISlider.new(display.LEFT_TO_RIGHT, SLIDER_IMAGES, {scale9 = true})
      :onSliderValueChanged(function(event)
          printf(string.format("value = %0.2f", event.value))
          scrollView:scrollToPercentHorizontal(event.value, 0.1, true);
      end)
      :setSliderSize(display.width - marginD, 30)
      :setSliderValue(75)
      :align(display.CENTER, display.width /2 , 25)
      :addTo(self)

end

function ScrollGrid:onEnter()

end

function ScrollGrid:onExit()
end


return ScrollGrid
