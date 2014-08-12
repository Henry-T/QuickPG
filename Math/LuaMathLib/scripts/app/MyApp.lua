
require("config")
require("framework.init")
require("LuaMathLib.bit")

require("LuaMathLib.class")      -- 修改class定义使其支持getter/setter/indexer
Math = require("LuaMathLib.Math")
Vector2 = require("LuaMathLib.Vector2")
Vector3 = require("LuaMathLib.Vector3")
Vector4 = require("LuaMathLib.Vector4")
Quaternion = require("LuaMathLib.Quaternion")
Matrix = require("LuaMathLib.Matrix4x4")

print("=============================")
print("Math测试")
print("=============================")
require("MathTest.MathTest")
print("\n")

print("=============================")
print("Vector3测试")
print("=============================")
require("MathTest.Vector3Test")
print("\n")

print("=============================")
print("Vector2测试")
print("=============================")
require("MathTest.Vector2Test")
print("\n")

print("=============================")
print("Vector4测试")
print("=============================")
-- require("MathTest.Vector4Test")
print("\n")

print("=============================")
print("Quaternion测试")
print("=============================")
-- require("MathTest.QuaternionTest")
print("\n")

print("=============================")
print("Matrix测试")
print("=============================")
-- require("MathTest.MatrixTest")
print("\n")


local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    -- self:enterScene("MainScene")
end

return MyApp
