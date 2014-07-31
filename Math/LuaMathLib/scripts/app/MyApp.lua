
require("config")
require("framework.init")
require("LuaMathLib.bit")
Math = require("LuaMathLib.Math")
Vector2 = require("LuaMathLib.Vector2")
--Vector3 = require("LuaMathLib.Vector3")
Quaternion = require("LuaMathLib.Quaternion")
--Matrix = require("LuaMathLib.Matrix")

require("MathTest.MathTest")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    self:enterScene("MainScene")
end

return MyApp
