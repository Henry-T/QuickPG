--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-30 10:31:50
--

local Matrix4x4 = class("Matrix4x4")

function Matrix4x4:ctor()
    self.m00 = 0
    self.m01 = 0
    self.m02 = 0
    self.m03 = 0
    self.m10 = 0
    self.m11 = 0
    self.m12 = 0
    self.m13 = 0
    self.m20 = 0
    self.m21 = 0
    self.m22 = 0
    self.m23 = 0
    self.m30 = 0
    self.m31 = 0
    self.m32 = 0
    self.m33 = 0

    self.x = 0
end

--- 创建一个单位矩阵
function Matrix4x4.identity()
    local matrix = Matrix4x4:new()
    matrix.m00 = 1
    matrix.m01 = 0
    matrix.m02 = 0
    matrix.m03 = 0
    matrix.m10 = 0
    matrix.m11 = 1
    matrix.m12 = 0
    matrix.m13 = 0
    matrix.m20 = 0
    matrix.m21 = 0
    matrix.m22 = 1
    matrix.m23 = 0
    matrix.m30 = 0
    matrix.m31 = 0
    matrix.m32 = 0
    matrix.m33 = 1
    return matrix
end

--- 创建一个0矩阵
function Matrix4x4.zero()
    local matrix = Matrix4x4:new()
    matrix.m00 = 0
    matrix.m01 = 0
    matrix.m02 = 0
    matrix.m03 = 0
    matrix.m10 = 0
    matrix.m11 = 0
    matrix.m12 = 0
    matrix.m13 = 0
    matrix.m20 = 0
    matrix.m21 = 0
    matrix.m22 = 0
    matrix.m23 = 0
    matrix.m30 = 0
    matrix.m31 = 0
    matrix.m32 = 0
    matrix.m33 = 0
    return matrix
end

-- TODO inverse改为getter实现
function Matrix4x4.inverse()
    reutrn Matrix4x4.Inverse(self)
end

-- TODO 实现isIdentity
function Matrix4x4.isIdentity()
    return false
end

function Matrix4x4:transpose()
    return Matrix4x4.Transpose(self)
end

-- TODO 支持indexer
-- function this(row, column)
-- end

-- function this(index)
-- end

function Matrix4x4.Inverse(m)
    -- NOTE Unity未实现在C#中
end

function Matrix4x4.Ortho(left, right, bottom, top, zNear, zFar)
end

function Matrix4x4.Perspective(fov, aspect, zNear, zFar)

end

function Matrix4x4.Scale(vec3)
    local matrix = Matrix4x4.zero()
    matrix.m00 = vec3.x
    matrix.m11 = vec3.y
    matrix.m22 = vec3.z
end

function Matrix4x4.Transpose(m)
    -- NOTE Unity未实现在C#中
end

function Matrix4x4.TRS(pos, q, s)
    -- NOTE Unity未实现在C#中
end

-- TODO 重载'='运算符
function Matrix4x4:Equals(other)
    -- TODO 自己实现个简单的tolua.type() 批注下它们兼容 便于适应别的框架
    -- NOTE 支持不完善，无法搬运
end

function Matrix4x4:GetColumn(i)
    local vec4 = Vector4:new()
    vec4.x = self[0, i]
    vec4.y = self[1, i]
    vec4.z = self[2, i]
    vec4.w = self[3, i]
    return vec4
end

function Matrix4x4:GetHashCode()
    return self.GetColumn(0).GetHashCode () ^ self.GetColumn(1).GetHashCode () << 2 ^ self.GetColumn(2).GetHashCode () >> 2 ^ self.GetColumn(3).GetHashCode() >> 1;
end

function Matrix4x4:GetRow()
    local vec4 = Vector4:new()
    vec4.x = self[i, 0]
    vec4.y = self[i, 1]
    vec4.z = self[i, 2]
    vec4.w = self[i, 3]
    return vec4
end

function Matrix4x4:MultiplyPoint(vec3)
    local result = Vector3:new()
    result.x = self.m00 * v.x + self.m01 * v.y + self.m02 * v.z + self.m03
    result.y = self.m10 * v.x + self.m11 * v.y + self.m12 * v.z + self.m13
    result.z = self.m20 * v.x + self.m21 * v.y + self.m22 * v.z + self.m23
    local num = self.m30 * v.x + self.m31 * v.y + self.m32 * v.z + self.m33
    num = 1 / num
    result.x = result.x * num
    result.y = result.y * num
    result.z = result.z * num
    return result
end

function Matrix4x4:MultiplyPoint3x4(vec3)
    local result = Vector3:new()
    result.x = self.m00 * v.x + self.m01 * v.y + self.m02 * v.z + self.m03
    result.y = self.m10 * v.x + self.m11 * v.y + self.m12 * v.z + self.m13
    result.z = self.m20 * v.x + self.m21 * v.y + self.m22 * v.z + self.m23
    return result
end


function Matrix4x4:MultiplyVector(vec3)
    local result = Vector3:new()
    result.x = self.m00 * v.x + self.m01 * v.y + self.m02 * v.z
    result.y = self.m10 * v.x + self.m11 * v.y + self.m12 * v.z
    result.z = self.m20 * v.x + self.m21 * v.y + self.m22 * v.z
    return result
end


function Matrix4x4:SetColumn(i, v)
    self.[0, i] = v.x
    self.[1, i] = v.y
    self.[2, i] = v.z
    self.[3, i] = v.w
end

function Matrix4x4:SetRow(i, v)
    self.[i, 0] = v.x
    self.[i, 1] = v.y
    self.[i, 2] = v.z
    self.[i, 3] = v.w
end

function Matrix4x4:SetTRS (pos, q, s)
    -- TODO 真的可以这样给self赋值?
    self = Matrix4x4.TRS (pos, q, s)
end

-- TODO 使lua的tostring()能够检测到
function Matrix4x4:ToString()
    return string.format("{0:F5}\t{1:F5}\t{2:F5}\t{3:F5}\n{4:F5}\t{5:F5}\t{6:F5}\t{7:F5}\n{8:F5}\t{9:F5}\t{10:F5}\t{11:F5}\n{12:F5}\t{13:F5}\t{14:F5}\t{15:F5}\n",
        self.m00,
        self.m01,
        self.m02,
        self.m03,
        self.m10,
        self.m11,
        self.m12,
        self.m13,
        self.m20,
        self.m21,
        self.m22,
        self.m23,
        self.m30,
        self.m31,
        self.m32,
        self.m33)
end

function Matrix4x4:ToString(format)
    return string.format ("{0}\t{1}\t{2}\t{3}\n{4}\t{5}\t{6}\t{7}\n{8}\t{9}\t{10}\t{11}\n{12}\t{13}\t{14}\t{15}\n", new object[]
        string.format(format, self.m00),
        string.format(format, self.m01),
        string.format(format, self.m02),
        string.format(format, self.m03),
        string.format(format, self.m10),
        string.format(format, self.m11),
        string.format(format, self.m12),
        string.format(format, self.m13),
        string.format(format, self.m20),
        string.format(format, self.m21),
        string.format(format, self.m22),
        string.format(format, self.m23),
        string.format(format, self.m30),
        string.format(format, self.m31),
        string.format(format, self.m32),
        string.format(format, self.m33))
end


-- TODO 重载运算符
function Matirx:equal(lhs, rhs)
    return lhs:GetColumn(0)==rhs:GetColumn(0) and lhs:GetColumn(1)==rhs:GetColumn(1) and lhs:GetColumn(2)==rhs:GetColumn(2) and lhs:GetColumn(3)==rhs:GetColumn(3)
end

function Matrix4x4:notEqual(lhs, rhs)
    return !(lhs == rhs)
end

function Matrix4x4:multi(lhs, vec4)
    local newVec4 = Vector4:new()
    newVec4.x = lhs.m00 * v.x + lhs.m01 * v.y + lhs.m02 * v.z + lhs.m03 * v.w
    newVec4.y = lhs.m10 * v.x + lhs.m11 * v.y + lhs.m12 * v.z + lhs.m13 * v.w
    newVec4.z = lhs.m20 * v.x + lhs.m21 * v.y + lhs.m22 * v.z + lhs.m23 * v.w
    newVec4.w = lhs.m30 * v.x + lhs.m31 * v.y + lhs.m32 * v.z + lhs.m33 * v.w
    return newVec4
end

function Matrix4x4:multi(lhs, rhs)
    local newMat = Martix:new()
    newMat.m00 = lhs.m00 * rhs.m00 + lhs.m01 * rhs.m10 + lhs.m02 * rhs.m20 + lhs.m03 * rhs.m30
    newMat.m01 = lhs.m00 * rhs.m01 + lhs.m01 * rhs.m11 + lhs.m02 * rhs.m21 + lhs.m03 * rhs.m31
    newMat.m02 = lhs.m00 * rhs.m02 + lhs.m01 * rhs.m12 + lhs.m02 * rhs.m22 + lhs.m03 * rhs.m32
    newMat.m03 = lhs.m00 * rhs.m03 + lhs.m01 * rhs.m13 + lhs.m02 * rhs.m23 + lhs.m03 * rhs.m33
    newMat.m10 = lhs.m10 * rhs.m00 + lhs.m11 * rhs.m10 + lhs.m12 * rhs.m20 + lhs.m13 * rhs.m30
    newMat.m11 = lhs.m10 * rhs.m01 + lhs.m11 * rhs.m11 + lhs.m12 * rhs.m21 + lhs.m13 * rhs.m31
    newMat.m12 = lhs.m10 * rhs.m02 + lhs.m11 * rhs.m12 + lhs.m12 * rhs.m22 + lhs.m13 * rhs.m32
    newMat.m13 = lhs.m10 * rhs.m03 + lhs.m11 * rhs.m13 + lhs.m12 * rhs.m23 + lhs.m13 * rhs.m33
    newMat.m20 = lhs.m20 * rhs.m00 + lhs.m21 * rhs.m10 + lhs.m22 * rhs.m20 + lhs.m23 * rhs.m30
    newMat.m21 = lhs.m20 * rhs.m01 + lhs.m21 * rhs.m11 + lhs.m22 * rhs.m21 + lhs.m23 * rhs.m31
    newMat.m22 = lhs.m20 * rhs.m02 + lhs.m21 * rhs.m12 + lhs.m22 * rhs.m22 + lhs.m23 * rhs.m32
    newMat.m23 = lhs.m20 * rhs.m03 + lhs.m21 * rhs.m13 + lhs.m22 * rhs.m23 + lhs.m23 * rhs.m33
    newMat.m30 = lhs.m30 * rhs.m00 + lhs.m31 * rhs.m10 + lhs.m32 * rhs.m20 + lhs.m33 * rhs.m30
    newMat.m31 = lhs.m30 * rhs.m01 + lhs.m31 * rhs.m11 + lhs.m32 * rhs.m21 + lhs.m33 * rhs.m31
    newMat.m32 = lhs.m30 * rhs.m02 + lhs.m31 * rhs.m12 + lhs.m32 * rhs.m22 + lhs.m33 * rhs.m32
    newMat.m33 = lhs.m30 * rhs.m03 + lhs.m31 * rhs.m13 + lhs.m32 * rhs.m23 + lhs.m33 * rhs.m33
    return newMat
end




-- NOTE 标准Getter和Setter被class定义占用
-- http://stackoverflow.com/questions/10578935/lua-getters-and-setters
-- function Matrix4x4.__newindex(index, value)
--     if index == "X" then
--         self.x = value
--     end
-- end

-- function Matrix4x4.__index(index)
--     if index == "X" then
--         return x
--     elseif index == "ctor()" then
--         return self:ctor()
--     end
-- end

return Matrix4x4