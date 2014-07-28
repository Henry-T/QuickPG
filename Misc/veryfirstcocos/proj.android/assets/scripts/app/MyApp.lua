
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
    display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)
    display.addSpriteFramesWithFile("role.plist", "role.png")
    display.addSpriteFramesWithFile("cowboy/cowboy0.plist", "cowboy/cowboy0.png")
    CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfoAsync("cowboy/cowboy.ExportJson", function() end)

    --self:enterScene("MainScene")
    --self:enterScene("UIScene")
    self:enterScene("InputScene")
end

return MyApp
