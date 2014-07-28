
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    ui.newTTFLabel({text = "Hello, World", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self)

end

function MainScene:onEnter()
    -- local sprite1 = display.newSprite("#AddCoinButton.png")
    -- sprite1:setPosition(display.width, display.height)
    -- printf("%f %f ", display.width, display.height);
    -- sprite1:setAnchorPoint(0.5, 0.5)
    -- self:addChild(sprite1)

    -- local sprite2 = display.newSprite("#AddCoinButton.png")
    -- sprite2:setPosition(50, 50)
    -- sprite2:setAnchorPoint(0, 0)
    -- self:addChild(sprite2)
    
    -- local pX, pY = sprite2:getPosition()

    -- local p3 = sprite1:convertToNodeSpace(CCPoint(pX, pY))
    -- local p4 = sprite1:convertToWorldSpace(CCPoint(pX, pY))

    -- printf("position = (%f,%f)", p3.x, p3.y)
    -- printf("position = (%f,%f)", p4.x, p4.y)

    -- User Type
    -- local fillParam = {fill=true, color=ccc4f(255, 100, 100, 128)}

    -- ## 绘制矩形
    -- local red = display.newRect(100, 100, fillParam)
    -- red:setPosition(100, 100)
    --self:addChild(red)

    -- ## 绘制多边形
    -- local points = {{10, 10}, {50, 50}, {100, 10},}
    -- local polygon = display.newPolygon(points, fillParam)
    -- polygon:setClose(true) -- 将第一个点和最后一个点相连
    -- polygon:setPosition(100, 100)
    -- self:addChild(polygon)  --? 不显示

    -- ## 绘制圆形
    -- local circle = display.newCircle(20, fillParam)
    -- circle:setPosition(100, 300)
    -- self:addChild(circle)

    -- ## 文件精灵
    -- local spriteFile = display.newSprite("sprite.png")
    -- spriteFile:setPosition(display.cx, display.cy)
    -- self:addChild(spriteFile)

    -- ## Atlas精灵
    -- local spriteAtlas = display.newSprite("#AddCoinButton.png")
    -- spriteAtlas:setPosition(display.cx, display.cy)
    -- self:addChild(spriteAtlas)

    -- ## 序列帧动画
    --local sprite = display.newSprite("#role01.png"):pos(display.cx, display.cy)
    --self:addChild(sprite)
    --local frames = display.newFrames("role%02d.png", 1, 10, true)
    --local animation = display.newAnimation(frames, 0.3 / 10)
    ----self:playAnimationOnce(animation, false, function() end) -- 來自CoinFlip transation类方法
    --sprite:runAction(CCRepeatForever:create(CCAnimate:create(animation)))

    -- ## CocoStudio骨骼动画 luatest cocostudio导出出错
    -- local armature = CCArmature:create("Cowboy")
    -- armature:getAnimation():playWithIndex(0)
    -- armature:setScale(0.2)
    -- armature:setAnchorPoint(ccp(0.5, 0.5))
    -- armature:setPosition(ccp(display.cx, display.cy))
    -- self:addChild(armature)

    -- ## CocoStudio骨骼动画 sample做好的资源
    local manager = CCArmatureDataManager:sharedArmatureDataManager()
    manager:addArmatureFileInfo("Dragon.png", "Dragon.plist", "Dragon.xml")
    local dragon = CCArmature:create("Dragon")
    self.animationNames = {"stand", "walk", "jump", "fall"}
    local animation = dragon:getAnimation()
    animation:setSpeedScale(24 / 60) -- Flash fps is 24, cocos2d-x is 60
    local aniName = self.animationNames[math.random(1,4)]
    animation:play(aniName)
    dragon:setPosition(math.random(display.left, display.right), math.random(display.bottom, display.top))
    dragon:setScale(math.random(50, 100) / 100)
    self:addChild(dragon)

    -- ## 粒子
    -- CCParticleBatchNode
    --local fire = CCParticleSystemQuad:create():pos(display.cx, display.cy)
    --self:addChild(fire)

    -- ## 粒子 內置
    emitter = CCParticleRain:create()
    self:addChild(emitter)

    -- ## 绘图API
    -- ccDrawLine( ccp(0, 200),  ccp(200, 0) );
    -- glLineWidth( 5.0);
    -- ccDrawColor4B(255,0,0,255);
    -- ccDrawLine(ccp(0, 0), ccp(200, 200) );

    -- 音效
    -- audio.playSound("sfx/ConFlipSound.mp3")

end

function MainScene:onExit()
end

return MainScene
