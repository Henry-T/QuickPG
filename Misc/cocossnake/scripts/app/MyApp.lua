
require("config")
require("framework.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
  MyApp.super.ctor(self)
end

function MyApp:run()
  CCFileUtils:sharedFileUtils():addSearchPath("res/")
  CCFileUtils:sharedFileUtils():addSearchPath("res/ui/")
  self:enterScene("MainScene")
end

function MyApp:switchScene(name)
  local scenePackageName = "app.scenes." .. name
  local sceneClass = require(scenePackageName)
  local scene = sceneClass.new({})
  display.replaceScene(scene, transitionType, time, more)
end

function MyApp:setLevel(level)
  MyApp.CurLevel = level
end

return MyApp