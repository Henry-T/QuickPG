--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-01 09:54:47
--


--- 构造方法
print("Matrix4x4.new() is \n"..Matrix4x4.new())
-- TODO 支持Matrix4x4.identity和zero
print("Matrix4x4.identity is \n"..Matrix4x4.identity)
print("Matrix4x4.zero is \n"..Matrix4x4.zero)

--- Inverse
print("Inverse of Matrix.identity is \n"..Matrix4x4.new(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1).inverse)

--- Ortho
print("Ortho of {left=-100, right=100, bottom=-50, top=50, zNear=1, zFar = 100} is \n"..Matrix4x4.Ortho(-100, 100, -50, 50, 1, 100))

--- OrthoCentered
print("OrthoCentered of {width=200, height=100, zNear=1, zFar = 100} is \n"..Matrix4x4.OrthoCentered(-100, 100, -50, 50, 1, 100))

--- Perspective
print("Perspective of {fov=1.5, aspect=100, zNear=1, zFar=100} is \n"..Matrix4x4.Perspective(1.5, 100, 1, 100))

--- PerspectiveWH
print("PerspectiveWH of {width=200, height=100, zNear=1, zFar=100} is \n"..Matrix4x4.PerspectiveWH(200, 100, 1, 100))

--- Scale
local vecScale = Vector3.new(2,2,2)
print("ScaleMatrix of "..vecScale.." is \n"..Matrix4x4.Scale(vecScale))

--- Transpose
local matrixTranspose = Matrix4x4.new(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)
print("Transpose of \n"..matrixTranspose.."is \n"..matrixTranspose.transpose)

--- TODO Equals

--- MultiplyPoint
local matrixToMulti = Matrix4x4.new(1,0,0,0,0,1,0,0,0,0,1,0,2,0,0,1)
local vec3ToMulti = Vector3.new(100,100,100)
print("MultiplyPoint by\n"..matrixToMulti.."on "..vec3ToMulti.." is "..matrixToMulti:MultiplyPoint(vec3ToMulti))

--- MultiplyPoint3x4
local matrix3x4ToMulti = Matrix4x4.new(1,0,0,1,0,2,0,1,0,0,3,1,0,0,0,1)
local vec3ToMultiBy3x4 = Vector3.new(100,200,300)
print("MultiplyPoint3x4 by\n"..matrix3x4ToMulti.."on "..vec3ToMultiBy3x4.." is "..matrix3x4ToMulti:MultiplyPoint3x4(vec3ToMultiBy3x4))

--- MultiplyVector
local matrixToMultiVec = Matrix4x4.new(1,0,0,1,0,2,0,1,0,0,3,1,0,0,0,1)
local vec3ToMultiAsVec = Vector3.new(100,200,300)
print("MultiplyVector by\n"..matrixToMultiVec.."on "..vec3ToMultiAsVec.." is "..matrixToMultiVec:MultiplyVector(vec3ToMultiAsVec))


--- TODO == 比较

--- Matrix4x4 * Vector4
local matrixMultiByVec4 = Matrix4x4.new(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)
local vec4ToMultiMatrix = Vector4.new(1,2,3,4)
print("Multiply \n"..matrixMultiByVec4.." by "..vec4ToMultiMatrix.." is "..matrixMultiByVec4*vec4ToMultiMatrix)

--- Matrix4x4 * Matrix4x4
local matrixMultiByM = Matrix4x4.new(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)
local matrixToMultiM = Matrix4x4.new(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)
print("Multiply \n"..matrixMultiByM.." by \n"..matrixToMultiM.." is \n"..matrixMultiByM*matrixToMultiM)

