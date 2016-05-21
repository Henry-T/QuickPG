--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-12 13:46:00
--


--- 构造函数 & 修改
local vec4new = Vector4.new(1,2,3,4)
print("Constructor called: "..vec4new)
vec4new:Set(5,6,7,8)
print("Set called: "..vec4new)


--- 求和
local addL = Vector4.new(1,1,1,1)
local addR = Vector4.new(1,1,1,1)
local sum = addL + addR
print("Sum of " .. addL .. " and "..addR.." is "..sum)


--- 长度
local vec4Len = Vector4.new(3, 4, 0)
print("Magnitude of " .. vec4Len .. " is " .. vec4Len.magnitude)

--- 归一化
local vec4Nor = Vector4.new(10,10,10)
print("Normalize of "..vec4Nor.." is "..tostring(vec4Nor.normalized))

--- 距离
local vec4DisL = Vector4.new(30, 0, 0)
local vec4DisR = Vector4.new(0, 40, 0)
print("Distance of "..vec4DisL.." and "..vec4DisR.." is "..Vector4.Distance(vec4DisL, vec4DisR))

--- 数量积
local vec4DotL = Vector4.new(1, 1, 0)
local vec4DotR = Vector4.new(40, 0, 0)
print("Dot of "..vec4DotL.." and "..vec4DotR.." is "..Vector4.Dot(vec4DotL, vec4DotR))

--- 投影
local vec4ProjBase = Vector4.new(20, 20, 0)
local vec4ProjNorm = Vector4.new(20, 0, 0)
print("Project "..vec4ProjBase.." on "..vec4ProjNorm.." is "..Vector4.Project(vec4ProjBase, vec4ProjNorm))

--- 插值
local vec4LerpFrom = Vector4.new(0,0,0)
local vec4LerpTo = Vector4.new(100,0,0)
local lerpVal = 0.5
print("Lerp "..lerpVal.." from "..vec4LerpFrom.." to "..vec4LerpTo.." is "..Vector4.Lerp(vec4LerpFrom, vec4LerpTo, lerpVal))

--- Max
local vec4MaxL = Vector4.new(10, 0, 10)
local vec4MaxR = Vector4.new(0, 10, 0)
print("Max of "..vec4MaxL.." and "..vec4MaxR.." is "..Vector4.Max(vec4MaxL, vec4MaxR))

--- Min
local vec4MinL = Vector4.new(10, 0, 10)
local vec4MinR = Vector4.new(0, 10, 0)
print("Min of "..vec4MinL.." and "..vec4MinR.." is "..Vector4.Min(vec4MinL, vec4MinR))

--- MoveTowards
local vec4MTCur = Vector4.new(0,0,0)
local vec4MTTgt = Vector4.new(20, 0, 0)
local mtMaxDisDelta = 10
print("Move from "..vec4MTCur.." to "..vec4MTTgt.." by "..mtMaxDisDelta.." is "..Vector4.MoveTowards(vec4MTCur, vec4MTTgt, mtMaxDisDelta))

--- OrthoNormailze
-- TODO 先做实现

--- RotateTowards
-- TODO 先做实现

--- Scale
local vec4ScaleL = Vector4.new(1, 2, 3, 4)
local vec4ScaleR = Vector4.new(1, 2, 3, 4)
print("Scale "..vec4ScaleL.." by "..vec4ScaleR.." is "..Vector4.Scale(vec4ScaleL, vec4ScaleR))

--- Slerp
-- TODO 先做实现

--- SmoothDamp 
-- NOTE 单独测试

--- SqrMagnitude
local vec4SqrMagnitude = Vector4.new(1,2,3,4)
print("SqrMagnitude of "..vec4SqrMagnitude.." is ".. vec4SqrMagnitude:SqrMagnitude())

--- Equals等值
local vec4EqualL = Vector4.new(1,2,3)
local vec4EqualR = Vector4.new(1,2,4)
local vec4EqualM = Vector4.new(1,2,3)
print("Check "..vec4EqualL.." and "..vec4EqualR.." for equal is "..tostring(vec4EqualL:Equals(vec4EqualR)))
print("Check "..vec4EqualL.." and "..vec4EqualM.." for equal is "..tostring(vec4EqualL:Equals(vec4EqualM)))

--- 