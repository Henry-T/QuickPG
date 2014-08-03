--
-- Author: Henry.T
-- Date: 2014-08-01 21:55:31
--

--- 构造函数 & 修改
local vec2new = Vector2.new(1,2)
print("Constructor called: "..vec2new)
vec2new:Set(3,5)
print("Set called: "..vec2new)


--- 求和
local addL = Vector2.new(1,1)
local addR = Vector2.new(1,1)
local sum = addL + addR
print("Sum of " .. addL .. " and "..addR.." is "..sum)


--- 长度
local vec2Len = Vector2.new(3, 4)
print("Magnitude of " .. vec2Len .. " is " .. vec2Len.magnitude)

--- 归一化
local vec2Nor = Vector2.new(10,10)
print("Normalize of "..vec2Nor.." is "..tostring(vec2Nor.normalized))

--- 夹角
local vec2AngleFrom = Vector2.new(1, 0)
local vec2AngleTo = Vector2.new(0, 1)
print("Angle between "..vec2AngleFrom.." and "..vec2AngleTo.." is "..string.format("%.2f", Vector2.Angle(vec2AngleFrom, vec2AngleTo)))

--- 向量积
-- TODO 支持转换为3D向量后取向量积
-- local vec2CrossL = Vector2.new(1, 0)
-- local vec2CrossR = Vector2.new(0, 1)
-- print("Cross of "..vec2CrossL.." and "..vec2CrossR.." is "..Vector2.Cross(vec2CrossL, vec2CrossR))

--- 距离
local vec2DisL = Vector2.new(30, 0)
local vec2DisR = Vector2.new(0, 40)
print("Distance of "..vec2DisL.." and "..vec2DisR.." is "..Vector2.Distance(vec2DisL, vec2DisR))

-- --- 数量积
local vec2DotL = Vector2.new(1, 1)
local vec2DotR = Vector2.new(40, 0)
print("Dot of "..vec2DotL.." and "..vec2DotR.." is "..Vector2.Dot(vec2DotL, vec2DotR))

-- --- 投影
-- TODO 转3D再转回
-- local vec2ProjBase = Vector2.new(20, 20)
-- local vec2ProjNorm = Vector2.new(20, 0)
-- print("Project "..vec2ProjBase.." on "..vec2ProjNorm.." is "..Vector2.Project(vec2ProjBase, vec2ProjNorm))

-- --- 投影正交向量
-- TODO 转3D再转回
-- local vec2ExcL = Vector2.new(1, 1)
-- local vec2ExcR = Vector2.new(40, 0)
-- print("Exclude "..vec2ExcL.." from "..vec2ExcR.." is "..Vector2.Exclude(vec2ExcL, vec2ExcR))

-- --- 插值
local vec2LerpFrom = Vector2.new(0,0)
local vec2LerpTo = Vector2.new(100,0)
local lerpVal = 0.5
print("Lerp "..lerpVal.." from "..vec2LerpFrom.." to "..vec2LerpTo.." is "..Vector2.Lerp(vec2LerpFrom, vec2LerpTo, lerpVal))

-- --- Max
local vec2MaxL = Vector2.new(10, 0)
local vec2MaxR = Vector2.new(0, 10)
print("Max of "..vec2MaxL.." and "..vec2MaxR.." is "..Vector2.Max(vec2MaxL, vec2MaxR))

-- --- Min
local vec2MinL = Vector2.new(10, 0)
local vec2MinR = Vector2.new(0, 10)
print("Min of "..vec2MinL.." and "..vec2MinR.." is "..Vector2.Min(vec2MinL, vec2MinR))

-- --- MoveTowards
local vec2MTCur = Vector2.new(0,0)
local vec2MTTgt = Vector2.new(20,0)
local mtMaxDisDelta = 10
print("Move from "..vec2MTCur.." to "..vec2MTTgt.." by "..mtMaxDisDelta.." is "..Vector2.MoveTowards(vec2MTCur, vec2MTTgt, mtMaxDisDelta))

-- --- OrthoNormailze
-- -- TODO 先做实现

-- --- RotateTowards
-- -- TODO 先做实现

-- --- Scale
local vec2ScaleL = Vector2.new(1, 2)
local vec2ScaleR = Vector2.new(1, 2)
print("Scale "..vec2ScaleL.." by "..vec2ScaleR.." is "..Vector2.Scale(vec2ScaleL, vec2ScaleR))

-- --- Slerp
-- -- TODO 先做实现

-- --- SmoothDamp 
-- -- NOTE 单独测试

-- --- SqrMagnitude
-- -- NOTE 略

-- --- Equals等值
local vec2EqualL = Vector2.new(1,2)
local vec2EqualR = Vector2.new(1,3)
local vec2EqualM = Vector2.new(1,2)
print("Check "..vec2EqualL.." and "..vec2EqualR.." for equal is "..tostring(vec2EqualL:Equals(vec2EqualR)))
print("Check "..vec2EqualL.." and "..vec2EqualM.." for equal is "..tostring(vec2EqualL:Equals(vec2EqualM)))

-- --- 

