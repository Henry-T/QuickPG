
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
end

function MainScene:onEnter()

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

    -- local sprite1 = display.newSprite("walkBomb.png")
    -- sprite1:setPosition(display.cx, display.cy)
    -- sprite1:setAnchorPoint(0.5, 0.5)
    -- sprite1:setScale(1)
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
    -- local fillParam = {fill=true, color=ccc4f(255, 0, 0, 0.5)}

    -- -- ## 绘制矩形
    -- local red = display.newRect(80, 80, fillParam)
    -- red:setPosition(display.cx, display.cy)
    -- self:addChild(red)

    -- ## 绘制多边形
    -- local points = {{0, 0}, {80, 80}, {160, 0},}
    -- local polygon = display.newPolygon(points, fillParam)
    -- polygon:setClose(true)
    -- polygon:setPosition(display.cx, display.cy)
    -- self:addChild(polygon)

    -- ## 绘制圆形
    -- local circle = display.newCircle(80, fillParam)
    -- circle:setPosition(display.cx, display.cy)
    -- self:addChild(circle)

    -- ## 文件精灵
    -- local spriteFile = display.newSprite("sprite.png")
    -- spriteFile:setPosition(display.cx, display.cy)
    -- self:addChild(spriteFile)

    -- ## Atlas精灵
    -- local spriteAtlas = display.newSprite("#beeBomb.png")
    -- spriteAtlas:setPosition(display.cx, display.cy)
    -- self:addChild(spriteAtlas)

    -- ## 序列帧动画
    -- local sprite = display.newSprite("#role01.png"):pos(display.cx, display.cy)
    -- self:addChild(sprite)
    -- local frames = display.newFrames("role%02d.png", 1, 10, true)
    -- local animation = display.newAnimation(frames, 0.3 / 10)
    -- sprite:runAction(CCRepeatForever:create(CCAnimate:create(animation)))

    --self:playAnimationOnce(animation, false, function() end) -- 來自CoinFlip transation类方法 无效?

    -- ## CocoStudio骨骼动画
    -- display.addSpriteFramesWithFile("cowboy/cowboy0.plist", "cowboy/cowboy0.png")
    -- CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("cowboy/cowboy.ExportJson")
    -- local armature = CCArmature:create("Cowboy")

    -- WARN !!
    -- 这里存在个问题 BoilingFoam.png Comet.png fire.png 被CocosStudio嵌入到plist中
    -- 单下面的读取方法仍然要寻找png文件

    -- 异步方法 addArmatureFileInfoAsync("Hero/Hero.ExportJson", function() end)

    -- display.addSpriteFramesWithFile("DemoPlayer/DemoPlayer0.plist", "DemoPlayer/DemoPlayer0.png")
    -- CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("DemoPlayer/DemoPlayer.ExportJson")
    -- local armature = CCArmature:create("DemoPlayer")
    -- armature:getAnimation():playWithIndex(0)
    -- armature:setScale(0.2)
    -- armature:setAnchorPoint(ccp(0.5, 0.5))
    -- armature:setPosition(ccp(display.cx, display.cy))
    -- self:addChild(armature)

    -- ## DragonBone动画
    -- local manager = CCArmatureDataManager:sharedArmatureDataManager()
    -- manager:addArmatureFileInfo("Dragon.png", "Dragon.plist", "Dragon.xml")
    -- local dragon = CCArmature:create("Dragon")

    -- self.animationNames = {"stand", "walk", "jump", "fall"}
    -- local aniName = self.animationNames[math.random(1,4)]

    -- local animation = dragon:getAnimation()
    -- animation:setSpeedScale(24 / 60) -- Flash fps is 24, cocos2d-x is 60
    -- animation:play(aniName)
    -- dragon:setPosition(display.cx, display.cy - 200)
    -- dragon:setScale(math.random(50, 100) / 100)
    -- self:addChild(dragon)

    -- ## 粒子
    -- TODO
    -- CCParticleBatchNode
    -- local fire = CCParticleSystemQuad:create():pos(display.cx, display.cy)
    -- self:addChild(fire)

    -- ## 粒子 內置
    -- emitter = CCParticleRain:create()
    -- self:addChild(emitter)

    -- ## 绘图API
    -- TODO
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
