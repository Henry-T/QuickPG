-- 这是由QxGen生成的UI类



local PanelTest = class("PanelTest", function()
    local layout = TouchGroup:create()
    print(type(layout))
    return layout
end)

function PanelTest:ctor()
    self._isShowing = false

    self._widget = GUIReader:shareReader():widgetFromJsonFile("res/ListTempleteGUI/PanelTest.json")
    self:addWidget(self._widget)
    
    self._lstTest = self._widget:getChildByName("lstTest")

    -- QxGEN_CUSTOM_CLASS_INIT_BEGIN
    self._tplTest = GUIReader:shareReader():widgetFromJsonFile("res/ListTempleteGUI/widgetTest.json")
    self._tplTest._lbName = self._tplTest:getChildByName("lbName")
    self._tplTest._btnName = self._tplTest:getChildByName("btnName")

    self:addTest(nil)
    self:addTest(nil)
    self:addTest(nil)
    -- QxGEN_CUSTOM_CLASS_INIT_END
end

function PanelTest:addTest(data)
    --local widgetTest = GUIReader:shareReader():widgetFromJsonFile("res/ListTempleteGUI/widgetTest.json")
    local widgetTest = self._tplTest:clone()
    local peer = tolua.getpeer(self._tplTest)
    tolua.setpeer(widgetTest, peer)

    -- local newPeer = tolua.getpeer(widgetTest)
    -- if not newPeer then
    --     newPeer = {}
    --     tolua.setpeer(widgetTest, newPeer)
    -- end
    --setmetatable(newPeer, tolua.getpeer(self._tplTest))

    -- for k,v in pairs(newPeer) do
    --     print("Key:" .. k .. " Val:" .. v)
    -- end

    --setmetatable(widgetTest, getmetatable(self._tplTest))

    widgetTest._data = data
    widgetTest._lbName:setText("hello!")
    self._lstTest:pushBackCustomItem(widgetTest)
    

    -- QxGEN_CUSTOM_LIST_ADD_BEGIN Test
    -- HERE 这里通常写数据绑定代码

    -- QxGEN_CUSTOM_LIST_ADD_END Test
end

-- QxGEN_CUSTOM_CLASS_LEVEL_BEGIN
-- HERE 自定义代码
-- QxGEN_CUSTOM_CLASS_LEVEL_END

function PanelTest:show(parent)
    if not self._isShowing then
        self._isShowing = true
        parent:addChild(self)
    end
end

-- QxGEN_CUSTOM_LIST_REFRESH_BEGIN PanelTest
-- TODO 请将这个函数改为你自己的Panel刷新逻辑
function PanelTest:refreshView()
end
-- QxGEN_CUSTOM_LIST_REFRESH_END PanelTest

function PanelTest:close()
    if self._isShowing then
        self._isShowing = false
        -- TODO 移除所有的list项 以节约内存
        -- 例如:
        -- self._listMails:removeAllItems()
        transition.scaleTo(self, {time = .2, scale = .2, easing = "BACKIN", onComplete = function ()
            self:removeFromParentAndCleanup(true)
            self:setScale(1)
        end})
    end
end

return PanelTest
