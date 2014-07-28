local CommonGUI = class("CommonGUI", function()
    return display.newScene("CommonGUI")
end)

local margin = 40
local marginH = 20
local marginD = 80

function CommonGUI:ctor()

  -- ## 纯色背景
  --display.newColorLayer(ccc4(255, 255, 255, 255)):addTo(self)

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

  -- ## 创建CocoStudio GUI容器

  -- ## !!! TouchGroup我暂时拿不到，先用普通节点做容器 暂未返现问题
  local _uiLayer = TouchGroup:create()

  --self._uiLayer = CCNode:create()
  self:addChild(self._uiLayer)

  -- ## 载入ExportJson文件
  self._widget = GUIReader:shareReader():widgetFromJsonFile("ccs_gui/common_all_in_one/Export/common_all_in_one_1/common_all_in_one_1.json")
  --self._uiLayer:addWidget(self._widget)
  self._uiLayer:addChild(self._widget)




end

function CommonGUI:onEnter()

end

function CommonGUI:onExit()
end


return CommonGUI
