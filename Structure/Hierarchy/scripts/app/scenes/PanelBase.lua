--
-- Author: tanghongyang@apowo.com
-- Date: 2014-09-12 01:34:18
--

local PanelBase = class("PanelBase", function()
  return display.newLayer()
end)

function PanelBase:ctor()
  print("PanelBase initialized!")
end

function PanelBase:show(params)
  print("PanelBase gets p:", params.p)
end

return PanelBase