--
-- Author: tanghongyang@apowo.com
-- Date: 2014-12-05 13:56:53
--

  
local Panel = require("app.view.Panel")

local MessagePanel = class("MessagePanel", Panel)

function MessagePanel:ctor(params)
    MessagePanel.super.ctor(self, params)
end

---
-- @params.animMode
function MessagePanel:close(params)
    MessagePanel.super.close(self, params)

    -- uiManager:getHeadPanel():removeOneCloseFrameFunc({animMode=2})
end

---
-- @params.data 
function MessagePanel:refresh(params)
    MessagePanel.super.refresh(self, params)
end

return MessagePanel