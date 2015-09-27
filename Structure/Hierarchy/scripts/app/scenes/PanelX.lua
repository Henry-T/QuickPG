--
-- Author: tanghongyang@apowo.com
-- Date: 2014-09-12 01:37:06
--

local PanelBase = import(".PanelBase")

local PanelX = class("PanelX", PanelBase)

function PanelX:ctor()
  PanelX.super.ctor(self)
  print("PanelX initialized!")
end

function PanelX:show(params)
  PanelX.super.show(self, params)
  print("PanelX gets c:", params.c)
end

return PanelX