
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    local function getPos(row, col)
        return display.cx + (col - 1) * 100, display.cy + (row - 1) * 100
    end

    -- 单一Action
    local function testA()
        local labelA = ui.newTTFLabel({text = "Hello, World", size = 16, align = ui.TEXT_ALIGN_CENTER})
            :pos(getPos(0, 0))
            :addTo(self)

        local rot = CCRotateBy:create(1, 90)

        labelA:runAction(rot)
    end

    -- CCSequence循环
    local function testB()
        local labelB = ui.newTTFLabel({text = "Hello, World", size = 16, align = ui.TEXT_ALIGN_CENTER})
            :pos(getPos(0,1))
            :addTo(self)

        local rot = CCRotateBy:create(1, 90)

        local actions = CCArray:create()
        actions:addObject(rot)

        labelB:runAction(CCSequence:create(actions))
    end

    -- 单一RepeatForever
    local function testC()
        local labelC = ui.newTTFLabel({text = "Hello, World", size = 16, align = ui.TEXT_ALIGN_CENTER})
            :pos(getPos(0,2))
            :addTo(self)

        local rot = CCRotateBy:create(1, 90)

        local actions = CCArray:create()
        actions:addObject(rot)

        labelC:runAction(CCRepeatForever:create(CCSequence:create(actions)))
    end

    -- 并行
    local function testD()
        local labelD = ui.newTTFLabel({text = "Hello, World", size = 16, align = ui.TEXT_ALIGN_CENTER})
            :pos(getPos(1,0))
            :addTo(self)

        local action = CCArray:create()
        action:addObject(CCRotateBy:create(1, 90))
        action:addObject(CCScaleTo:create(1, 0.5))

        labelD:runAction(CCSpawn:create(action))
    end

    -- 串行
    local function testE()
        local label = ui.newTTFLabel({text = "Hello, World", size = 16, align = ui.TEXT_ALIGN_CENTER})
            :pos(getPos(1,1))
            :addTo(self)

        local action1 = CCRotateTo:create(1, 90)
        local action2 = CCScaleTo:create(1, 0.5)

        local actions = CCArray:create()
        actions:addObject(action1)
        actions:addObject(action2)

        label:runAction(CCSequence:create(actions))
    end

    -- 并行 + 串行 + Repeat
    local function testF()
        local label = ui.newTTFLabel({text = "Hello, World", size = 16, align = ui.TEXT_ALIGN_CENTER})
            :pos(getPos(1,2))
            :addTo(self)

        local action1 = CCArray:create()
        action1:addObject(CCRotateBy:create(1, 90))
        action1:addObject(CCScaleTo:create(1, 0.5))

        local action2 = CCArray:create()
        action2:addObject(CCRotateBy:create(1, 90))
        action2:addObject(CCScaleTo:create(1, 0.5))

        local actions = CCArray:create()
        actions:addObject(CCSpawn:create(action1))
        actions:addObject(CCSpawn:create(action2))

        label:runAction(CCRepeatForever:create(CCSequence:create(actions)))
    end


    testA()
    testB()
    testC()
    testD()
    testE()
    testF()
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
