
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    local ButtonClass = class("ButtonClass", function()
        return display.newNode()
    end)

    function ButtonClass:ctor()
        local img = display.newSprite("40x20button_h.png")
            :addTo(self)
    end

    local button = ButtonClass.new():pos(0,0):addTo(self)

    local bound = button:getCascadeBoundingBox()
    print("Bound x y width height: \n", bound.origin.x, bound.origin.y, bound.size.width, bound.size.height)

    print("Bound origin is bottom-left corner")
    -- dump(tolua.getpeer(myButton))
end

function MainScene:onEnter()

end

function MainScene:onExit()
end

return MainScene
