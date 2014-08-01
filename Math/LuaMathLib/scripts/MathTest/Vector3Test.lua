--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-01 09:54:30
--


--- 构造函数 & 修改
local vec3new = Vector3.new(1,2,3)
print("Constructor called: "..vec3new)
vec3new:Set(3,5,6)
print("Set called: "..vec3new)


--- 求和
local addL = Vector3.new(1,1,1)
local addR = Vector3.new(1,1,1)
local sum = addL + addR
print("Sum of " .. addL .. " and "..addR.." is "..sum)


--- 长度
local vec3Len = Vector3.new(3, 4, 0)
print("Magnitude of " .. vec3Len .. " is " .. vec3Len.magnitude)

--- 归一化
local vec3Nor = Vector3.new(10,10,10)
print("Normalize of "..vec3Nor.." is "..tostring(vec3Nor.normalized))

--- 夹角
local vec3AngleFrom = Vector3.new(1, 0, 0)
local vec3AngleTo = Vector3.new(0, 1, 0)
print("Angle between "..vec3AngleFrom.." and "..vec3AngleTo.." is "..string.format("%.2f", Vector3.Angle(vec3AngleFrom, vec3AngleTo)))

--- 向量积
local vec3CrossL = Vector3.new(1, 0, 0)
local vec3CrossR = Vector3.new(0, 1, 0)
print("Cross of "..vec3CrossL.." and "..vec3CrossR.." is "..Vector3.Cross(vec3CrossL, vec3CrossR))

--- 距离
local vec3DisL = Vector3.new(30, 0, 0)
local vec3DisR = Vector3.new(0, 40, 0)
print("Distance of "..vec3DisL.." and "..vec3DisR.." is "..Vector3.Distance(vec3DisL, vec3DisR))

--- 数量积
local vec3DotL = Vector3.new(1, 1, 0)
local vec3DotR = Vector3.new(40, 0, 0)
print("Dot of "..vec3DotL.." and "..vec3DotR.." is "..Vector3.Dot(vec3DotL, vec3DotR))

--- 投影
local vec3ProjBase = Vector3.new(20, 20, 0)
local vec3ProjNorm = Vector3.new(20, 0, 0)
print("Project "..vec3ProjBase.." on "..vec3ProjNorm.." is "..Vector3.Project(vec3ProjBase, vec3ProjNorm))

--- 投影正交向量
local vec3ExcL = Vector3.new(1, 1, 0)
local vec3ExcR = Vector3.new(40, 0, 0)
print("Exclude "..vec3ExcL.." from "..vec3ExcR.." is "..Vector3.Exclude(vec3ExcL, vec3ExcR))

--- 插值
local vec3LerpFrom = Vector3.new(0,0,0)
local vec3LerpTo = Vector3.new(100,0,0)
local lerpVal = 0.5
print("Lerp "..lerpVal.." from "..vec3LerpFrom.." to "..vec3LerpTo.." is "..Vector3.Lerp(vec3LerpFrom, vec3LerpTo, lerpVal))

--- Max
local vec3MaxL = Vector3.new(10, 0, 10)
local vec3MaxR = Vector3.new(0, 10, 0)
print("Max of "..vec3MaxL.." and "..vec3MaxR.." is "..Vector3.Max(vec3MaxL, vec3MaxR))

--- Min
local vec3MinL = Vector3.new(10, 0, 10)
local vec3MinR = Vector3.new(0, 10, 0)
print("Min of "..vec3MinL.." and "..vec3MinR.." is "..Vector3.Min(vec3MinL, vec3MinR))

--- MoveTowards
local vec3MTCur = Vector3.new(0,0,0)
local vec3MTTgt = Vector3.new(20, 0, 0)
local mtMaxDisDelta = 10
print("Move from "..vec3MTCur.." to "..vec3MTTgt.." by "..mtMaxDisDelta.." is "..Vector3.MoveTowards(vec3MTCur, vec3MTTgt, mtMaxDisDelta))

--- OrthoNormailze
-- TODO 先做实现

--- RotateTowards
-- TODO 先做实现

--- Scale
local vec3ScaleL = Vector3.new(1, 2, 3)
local vec3ScaleR = Vector3.new(1, 2, 3)
print("Scale "..vec3ScaleL.." by "..vec3ScaleR.." is "..Vector3.Scale(vec3ScaleL, vec3ScaleR))

--- Slerp
-- TODO 先做实现

--- SmoothDamp 
-- NOTE 单独测试

--- SqrMagnitude
-- NOTE 略

--- Equals等值
local vec3EqualL = Vector3.new(1,2,3)
local vec3EqualR = Vector3.new(1,2,4)
local vec3EqualM = Vector3.new(1,2,3)
print("Check "..vec3EqualL.." and "..vec3EqualR.." for equal is "..tostring(vec3EqualL:Equals(vec3EqualR)))
print("Check "..vec3EqualL.." and "..vec3EqualM.." for equal is "..tostring(vec3EqualL:Equals(vec3EqualM)))

--- 