local UIScene = class("UIScene", function()
    return display.newScene("UIScene")
end)

function UIScene:ctor()

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

  -- ## 底图
  local bg = cc.ui.UIImage.new("30round.png", {scale9 = true})
    :pos(display.cx, display.cy)
    :setLayoutSize(240, 240)
    --:addTo(self)
  bg:setAnchorPoint(CCPoint(0.5, 0.5))

  -- ## 水平滚动
  --local hScroll =

  -- ## 垂直滚动


  -- ## 图片
  -- cc.ui.UIImage.new("40.png")
  --   :pos(display.cx, display.cy)
  --   :addTo(self)

  -- ## 拉伸
  -- cc.ui.UIImage.new("40.png")
  --   :setLayoutSize(80, 80)
  --   :pos(display.cx, display.cy)
  --   :addTo(self)

  -- ## 九宫格
  -- cc.ui.UIImage.new("slice30.png", {scale9 = true})
  --     :setLayoutSize(80, 80)
  --     :pos(display.cx, display.cy)
  --     :addTo(self)

  -- ## 文字
  -- cc.ui.UILabel.new({
  --     text = "这是一行TTF文字",
  --     size = 16,
  --     color = display.COLOR_BLACK,
  -- }):pos(display.cx, display.cy):addTo(self)

  -- ## 位图字体
  -- atlasLabel = CCLabelAtlas:create("AtlasLabel", "tuffy_bold_italic-charmap.png", 48, 64, string.byte(' ')):pos(display.left, display.cy)
  -- self:addChild(atlasLabel)

  -- ## 位图CheckBox
  -- btn1_img = {
  --   off = "30check_off.png",
  --   off_pressed = "30check_off.png",
  --   off_disabled = "30check_off.png",
  --   on = "30check_on.png",
  --   on_pressed = "30check_on.png",
  --   on_disabled = "30check_on.png",
  -- }

  -- btn1 = cc.ui.UICheckBoxButton.new(btn1_img)
  --   :setButtonLabelOffset(0,0)
  --   :setButtonLabelAlignment(display.CENTER)
  --   :setButtonSelected(false)   -- 初始按下状态
  --   :onButtonStateChanged(function(event)print("CheckBox点击")end)
  --   :pos(display.cx, display.cy)
  --   :addTo(self)

  -- ## 位图按钮
  -- btn3_img = {
  --   normal = "80x40button_n.png",
  --   pressed = "80x40button_h.png",
  --   disabled = "80x40button_dis.png",
  -- }

  -- btn3 = cc.ui.UIPushButton.new(btn3_img)
  --   :setButtonLabel("normal", ui.newTTFLabel({
  --       text = "Button",
  --       size = 24,
  --       color = ccc3(255, 255, 255),
  --     }))    
  --   :setButtonLabel("pressed", ui.newTTFLabel({
  --       text = "Down",
  --       size = 24,
  --       color = ccc3(255, 255, 255),
  --     }))   
  --   :setButtonLabel("disabled", ui.newTTFLabel({
  --       text = "Disable",
  --       size = 24,
  --       color = ccc3(200, 200, 200),
  --     }))
  --   :pos(display.cx, display.cy)
  --   :addTo(self)

  -- ## 单选按钮
  -- RADIO_BUTTON_IMAGES = {
  --     off = "30radio_off.png",
  --     off_pressed = "30radio_off.png",
  --     off_disabled = "30radio_dis.png",
  --     on = "30radio_on.png",
  --     on_pressed = "30radio_on.png",
  --     on_disabled = "30radio_dis.png",
  -- }

  -- local group = cc.ui.UICheckBoxButtonGroup.new(display.TOP_TO_BOTTOM)
  --     :addButton(cc.ui.UICheckBoxButton.new(RADIO_BUTTON_IMAGES)
  --         :setButtonLabel(cc.ui.UILabel.new({text = "option 1", color = display.COLOR_BLACK}))
  --         :setButtonLabelOffset(20, 0)
  --         :align(display.LEFT_CENTER))
  --     :addButton(cc.ui.UICheckBoxButton.new(RADIO_BUTTON_IMAGES)
  --         :setButtonLabel(cc.ui.UILabel.new({text = "option 2", color = display.COLOR_BLACK}))
  --         :setButtonLabelOffset(20, 0)
  --         :align(display.LEFT_CENTER))
  --     :addButton(cc.ui.UICheckBoxButton.new(RADIO_BUTTON_IMAGES)
  --         :setButtonLabel(cc.ui.UILabel.new({text = "option 3", color = display.COLOR_BLACK}))
  --         :setButtonLabelOffset(20, 0)
  --         :align(display.LEFT_CENTER))
  --     :addButton(cc.ui.UICheckBoxButton.new(RADIO_BUTTON_IMAGES)
  --         :setButtonLabel(cc.ui.UILabel.new({text = "option 4 disabled", color = display.COLOR_BLACK}))
  --         :setButtonEnabled(false)
  --         :setButtonLabelOffset(20, 0)
  --         :align(display.LEFT_CENTER))
  --     :setButtonsLayoutMargin(0, 0, 0, 0)
  --     :onButtonSelectChanged(function(event)
  --         printf("Option %d selected, Option %d unselected", event.selected, event.last)
  --     end)
  --     :pos(display.cx, display.cy)
  --     :addTo(self)
  -- group:getButtonAtIndex(4):setButtonSelected(true)


  -- ## 水平滚动条
  -- SLIDER_IMAGES = {
  --   bar = "120x30hscrollbar.png",
  --   button = "60x30hscrollhandle.png",
  -- }

  -- local hScroll = cc.ui.UISlider.new(display.LEFT_TO_RIGHT, SLIDER_IMAGES, {scale9 = true})
  --     :onSliderValueChanged(function(event)
  --         printf(string.format("value = %0.2f", event.value))
  --     end)
  --     :setSliderSize(display.width, 30)
  --     :setSliderValue(75)
  --     :pos(display.width /2 , 15)
  --     :addTo(self)
  

  -- ## 垂直滚动条
  SLIDER_IMAGES2 = {
    bar = "30x120vscrollbar.png",
    button = "30x60vscrollhandle.png",
  }

  local vScroll = cc.ui.UISlider.new(display.TOP_TO_BOTTOM, SLIDER_IMAGES2, {scale9 = true})
      :onSliderValueChanged(function(event)
        printf(string.format("value = %0.2f", event.value))
      end)
      :setSliderSize(30, display.height)
      :setSliderValue(75)
      :align(display.CENTER, display.width - 15, display.height / 2)
      :addTo(self)

  -- 垂直滚动条可以 重用按钮图片
      --:setSliderButtonRotation(90)

  -- ** align在竖直滚动条中似乎有着特别的必要性 用pos不用align会错位，也许是quick的问题
              --:pos(display.cx, display.cy)

  -- bar 似乎不能从太大尺寸往小了缩

  -- ## 测试 场景切换
  --[[
  btn3_img = {
    normal = "prepare_go_battle.jpg",
    pressed = "prepare_go_battle_press.jpg",
    disabled = "prepare_go_battle_press.jpg",
  }

  btn3 = cc.ui.UIPushButton.new(btn3_img)
    :setButtonLabel("normal", ui.newTTFLabel({
        text = "按钮",
        size = 18
      }))    
    :setButtonLabel("pressed", ui.newTTFLabel({
        text = "按下",
        size = 18,
        color = ccc3(255, 64, 64)
      }))   
    :setButtonLabel("disabled", ui.newTTFLabel({
        text = "禁用",
        size = 18,
        color = ccc3(0, 0, 0)
      }))
    :onButtonClicked(function(event)
        CCDirector:sharedDirector():replaceScene(MainScene.new())
      end)
    :align(display.LEFT_CENTER, display.left + 10, display.top - 80)
    :addTo(self)
  ]]
end

function UIScene:onEnter()

end

function UIScene:onExit()
end


return UIScene