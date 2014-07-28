
local UIScene = class("UIScene", function()
    return display.newScene("UIScene")
end)

function UIScene:ctor()
  -- ## 图片
  -- cc.ui.UIImage.new("PinkScale9Block.png")
  --   :align(display.LEFT_TOP, display.cx - 400, display.cy + 285)
  --   :addTo(self)

  -- ## 文字
  -- cc.ui.UILabel.new({
  --     text = "fixed size",
  --     size = 16,
  --     color = display.COLOR_WHITE,
  -- }):align(display.CENTER, display.cx - 350, display.cy + 170):addTo(self)

  -- ## 九宫格
  -- cc.ui.UIImage.new("PinkScale9Block.png", {scale9 = true})
  --     :setLayoutSize(200, 100)
  --     :align(display.LEFT_CENTER, display.cx - 400, display.cy + 45)
  --     :addTo(self)

  -- ## 拉伸
  -- cc.ui.UIImage.new("PinkScale9Block.png")
  --     :setLayoutSize(200, 100)
  --     :align(display.LEFT_BOTTOM, display.cx - 400, display.cy - 225)
  --     :addTo(self)


  -- ## 位图CheckBox
  --[[
    btn1_img = {
    off = "back2mapbtn.jpg",
    off_pressed = "back2mapbtn.jpg",
    off_disabled = "back2mapbtn.jpg",
    on = "back2mapbtn-disabled.jpg",
    on_pressed = "back2mapbtn-disabled.jpg",
    on_disabled = "back2mapbtn-disabled.jpg",
  }

  btn1 = cc.ui.UICheckBoxButton.new(btn1_img)
    :setButtonLabel(cc.ui.UILabel.new({text = "文字", size = 22,  color = ccc3(255, 255, 255)}))
    :setButtonLabelOffset(0,0)
    :setButtonLabelAlignment(display.CENTER)
    :setButtonSelected(false)   -- 初始按下状态
    :onButtonStateChanged(function(event)
      print("按钮点击")
      end)
    :align(display.RIGHT_TOP, display.right - 10, display.top - 10)
    --:pos(display.cx, display.cy)
    :addTo(self)
  ]]

  -- ## 九宫格CheckBox
  --[[]
  btn2_img = {
    off = "puton_promt.jpg",
    off_pressed = "puton_promt.jpg",
    off_disabled = "puton_promt.jpg",
    on = "puton_promt.jpg",
    on_pressed = "puton_promt.jpg",
    on_disabled = "puton_promt.jpg",
  }

  btn2 = cc.ui.UICheckBoxButton.new(btn2_img, {scale9 = true})
    :setButtonLabel(cc.ui.UILabel.new({text = "文字", size = 22,  color = ccc3(255, 255, 255)}))
    :setButtonLabelOffset(0,0)
    :setButtonLabelAlignment(display.CENTER)
    :setButtonSelected(false)   -- 初始按下状态
    :onButtonStateChanged(function(event)
      print("按钮点击")
      end)
    :align(display.RIGHT_TOP, display.right - 10, display.top - 10)
    --:pos(display.cx, display.cy)
    :addTo(self)
  ]]

  -- ## 位图按钮
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
    :align(display.LEFT_CENTER, display.left + 10, display.top - 80)
    :addTo(self)
  ]]

  -- ## 单选按钮
  --[[
  RADIO_BUTTON_IMAGES = {
      off = "star-disabled.jpg",
      off_pressed = "star-disabled.jpg",
      off_disabled = "star-disabled.jpg",
      on = "star.jpg",
      on_pressed = "star.jpg",
      on_disabled = "star.jpg",
  }

  local group = cc.ui.UICheckBoxButtonGroup.new(display.TOP_TO_BOTTOM)
      :addButton(cc.ui.UICheckBoxButton.new(RADIO_BUTTON_IMAGES)
          :setButtonLabel(cc.ui.UILabel.new({text = "option 1", color = display.COLOR_BLACK}))
          :setButtonLabelOffset(20, 0)
          :align(display.LEFT_CENTER))
      :addButton(cc.ui.UICheckBoxButton.new(RADIO_BUTTON_IMAGES)
          :setButtonLabel(cc.ui.UILabel.new({text = "option 2", color = display.COLOR_BLACK}))
          :setButtonLabelOffset(20, 0)
          :align(display.LEFT_CENTER))
      :addButton(cc.ui.UICheckBoxButton.new(RADIO_BUTTON_IMAGES)
          :setButtonLabel(cc.ui.UILabel.new({text = "option 3", color = display.COLOR_BLACK}))
          :setButtonLabelOffset(20, 0)
          :align(display.LEFT_CENTER))
      :addButton(cc.ui.UICheckBoxButton.new(RADIO_BUTTON_IMAGES)
          :setButtonLabel(cc.ui.UILabel.new({text = "option 4 disabled", color = display.COLOR_BLACK}))
          :setButtonEnabled(false)
          :setButtonLabelOffset(20, 0)
          :align(display.LEFT_CENTER))
      :setButtonsLayoutMargin(10, 10, 10, 10)
      :onButtonSelectChanged(function(event)
          printf("Option %d selected, Option %d unselected", event.selected, event.last)
      end)
      :align(display.LEFT_TOP, display.left + 40, display.top - 240)
      :addTo(self)
  group:getButtonAtIndex(4):setButtonSelected(true)
  ]]


  -- ## 水平滚动条
  
  SLIDER_IMAGES = {
    bar = "SliderBar.png",
    button = "SliderButton.png",
  }

  cc.ui.UISlider.new(display.LEFT_TO_RIGHT, SLIDER_IMAGES, {scale9 = true})
      :onSliderValueChanged(function(event)
          --valueLabel:setString(string.format("value = %0.2f", event.value))
      end)
      :setSliderSize(200, 40)
      :setSliderValue(75)
      :align(display.LEFT_BOTTOM, display.left + 40, display.top - 80)
      :addTo(self)
  

  -- ## 垂直滚动条
  SLIDER_IMAGES2 = {
    bar = "SliderBar.png",
    button = "SliderButton.png",
  }

  cc.ui.UISlider.new(display.TOP_TO_BOTTOM, SLIDER_IMAGES2, {scale9 = true})
      :onSliderValueChanged(function(event)
          --valueLabel:setString(string.format("value = %0.2f", event.value))
      end)
      :setSliderSize(40, 200)
      :setSliderButtonRotation(90)
      :setSliderValue(75)
      :align(display.CENTER_TOP, display.cx + 160, display.top - 40)
      :addTo(self)

  -- ** align在竖直滚动条中似乎有着特别的必要性
end

function UIScene:onEnter()

end

function UIScene:onExit()
end


return UIScene