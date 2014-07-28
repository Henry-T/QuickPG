
require("config")
require("framework.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    CCFileUtils:sharedFileUtils():addSearchPath("res/ui/")
    CCFileUtils:sharedFileUtils():addSearchPath("res/ui2/")
    CCFileUtils:sharedFileUtils():addSearchPath("res/fonts/")
    CCFileUtils:sharedFileUtils():addSearchPath("res/guide/")
    display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)
    display.addSpriteFramesWithFile("role.plist", "role.png")
    display.addSpriteFramesWithFile("enemy.plist", "enemy.png")

    --CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfoAsync("Hero/Hero.ExportJson", function() end)

    self:enterScene("MainScene")
    --self:enterScene("UIScene")
    --self:enterScene("InputScene")
end

function MyApp:drawGrid(scene)
    
    -- display.newColorLayer(ccc4(255, 255, 255, 255)):addTo(scene)
end


return MyApp
