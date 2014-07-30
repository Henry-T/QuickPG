
require("config")
require("framework.init")
require("MathLib.bit")
Math = require("MathLib.Math")
Vector2 = require("MathLib.Vector2")
Vector3 = require("MathLib.Vector3")
Quaternion = require("MathLib.Quaternion")
Matrix = require("MathLib.Matrix")

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
