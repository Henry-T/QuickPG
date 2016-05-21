--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-01 09:54:37
--


--- 构造方法 (Quaternion不应该修改分量)
print("Quaternion.new() is "..Quaternion.new())
print("Quaternion.Euler(90, 0, 0) is "..Quaternion.Euler(90, 0, 0))

-- TODO 支持Vector3.up
-- print(tostring(Vector3.__index(nil, "up")))
-- print(tostring(Vector3.up)
print("Quaternion.AngleAxis(90, Vector3.up) is "..Quaternion.AngleAxis(90, Vector3.new(0, 1, 0)))

--- 四元数转欧拉角
print("eulerAngles of Quaternion (0,0,0,1) is " .. Quaternion.new(0,0,0,1).eulerAngles)

--- 欧拉角转四元数
local q2 = Quaternion.new()
local euler = Vector3.new(0,0,0)
q2.eulerAngles = euler
print("Set eularAngles (0,0,90) to Quaternion is ".. Quaternion.new().eulerAngles)

--- 夹角
local quatAngleL = Quaternion.Euler(45, 0, 0)
local quatAngleR = Quaternion.Euler(135, 0, 0)
print("Angle between "..quatAngleL.." and "..quatAngleR.." is "..string.format("%.2f", Quaternion.Angle(quatAngleL, quatAngleR)))

--- FromToRotation
local quatFTFrom = Vector3.new(1, 0, 0)
local quatFTTo = Vector3.new(0, 1, 0)
print("FromToRotation of "..quatFTFrom.." and "..quatFTTo.." as eulerAngles is "..Quaternion.FromToRotation(quatFTFrom, quatFTTo).eulerAngles)

--- Lerp
local quatLerpA = Quaternion.Euler(0,0,0)
local quatLerpB = Quaternion.Euler(0,0,90)
print("Lerp from "..quatLerpA.eulerAngles.." to "..quatLerpB.eulerAngles.." by 0.5 is "..Quaternion.Lerp(quatLerpA, quatLerpB, 0.5).eulerAngles.." in euler")

--- TODO 理解并实现LookRotation()
-- Unity中的LookRotation并非是惯常用法，在three.js和XNA中都没有替代函数
-- 参考 等参未测实现 http://www.gamedev.net/topic/613595-quaternion-lookrotationlookat-up/
-- 参考 MonoGame Quaternion http://www.monogame.net/documentation/?page=T_Microsoft_Xna_Framework_Quaternion
-- 参考 不同参较好实现 http://gamedev.stackexchange.com/questions/15070/orienting-a-model-to-face-a-target
-- 参考 Nice LookAt Demo http://mrdoob.github.io/three.js/examples/misc_lookat.html


--- LookRotation
local vec3LookForward =  Vector3.new(100,0,100) - Vector3.new(0,0,0)
print("LookAt on forward "..vec3LookForward.." is "..Quaternion.LookRotation(vec3LookForward).eulerAngles)

--- Slerp
print("Slerp from "..quatLerpA.eulerAngles.." to "..quatLerpB.eulerAngles.." by 0.5 is "..Quaternion.Slerp(quatLerpA, quatLerpB, 0.5).eulerAngles.." in euler")


--- 乘法
local quatMulL = Quaternion.Euler(30, 0, 0)
local quatMulR = Quaternion.Euler(30, 0, 0)
print("Multiply "..quatMulL.eulerAngles.." by "..quatMulR.eulerAngles.." is "..(quatMulL * quatMulR).eulerAngles)

--- TODO 四元数左乘Vector3 不清楚什么意思


