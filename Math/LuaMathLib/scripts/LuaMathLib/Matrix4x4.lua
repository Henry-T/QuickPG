--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-30 10:31:50
--

local Matrix4x4 = class("Matrix4x4")

function Matrix4x4:ctor(m00, m01, m02, m03, m10, m11, m12, m13, m20, m21, m22, m23, m30, m31, m32, m33)
    self.m00 = m00 or 0
    self.m01 = m01 or 0
    self.m02 = m02 or 0
    self.m03 = m03 or 0
    self.m10 = m10 or 0
    self.m11 = m11 or 0
    self.m12 = m12 or 0
    self.m13 = m13 or 0
    self.m20 = m20 or 0
    self.m21 = m21 or 0
    self.m22 = m22 or 0
    self.m23 = m23 or 0
    self.m30 = m30 or 0
    self.m31 = m31 or 0
    self.m32 = m32 or 0
    self.m33 = m33 or 0
end


-- NOTE 因为下标索引没有数组意义,因此从0开始，与其他语言保持一致
function Matrix4x4:__index(index)
    if index == 0 or index == "_00" then
        return m00
    elseif index == 1 or index == "_01" then
        return m01
    elseif index == 2 or index == "_02" then
        return m02
    elseif index == 3 or index == "_03" then
        return m03
    elseif index == 4 or index == "_10" then
        return m10
    elseif index == 5 or index == "_11" then
        return m11
    elseif index == 6 or index == "_12" then
        return m12
    elseif index == 7 or index == "_13" then
        return m13
    elseif index == 8 or index == "_20" then
        return m20
    elseif index == 9 or index == "_21" then
        return m21
    elseif index == 10 or index == "_22" then
        return m22
    elseif index == 11 or index == "_23" then
        return m23
    elseif index == 12 or index == "_30" then
        return m30
    elseif index == 13 or index == "_31" then
        return m31
    elseif index == 14 or index == "_32" then
        return m32
    elseif index == 15 or index == "_33" then
        return m33
    elseif index == "inverse" then
        return Matrix4x4.Inverse(self)
    elseif index == "isIdentity" then
        return self:Equals(Matrix4x4.identity)
    elseif index == "transpose" then
        return Matrix4x4.Transpose(self)
    else
        return rawget(self, index)
    end
end

local MetaMatrix4x4 = {}

function MetaMatrix4x4:__index(index)
    if index == "identity" then
        return Matrix4x4.new(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
    elseif index == "zero" then
        return Matrix4x4.new(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    else 
        return rawget(self, index)
    end
end

setmetatable(Matrix4x4, MetaMatrix4x4)

function Matrix4x4:__newindex(index, value)
    if index == 0 or index == "_00" then
        self.m00 = value
    elseif index == 1 or index == "_01" then
        self.m01 = value
    elseif index == 2 or index == "_02" then
        self.m02 = value
    elseif index == 3 or index == "_03" then
        self.m03 = value
    elseif index == 4 or index == "_10" then
        self.m10 = value
    elseif index == 5 or index == "_11" then
        self.m11 = value
    elseif index == 6 or index == "_12" then
        self.m12 = value
    elseif index == 7 or index == "_13" then
        self.m13 = value
    elseif index == 8 or index == "_20" then
        self.m20 = value
    elseif index == 9 or index == "_21" then
        self.m21 = value
    elseif index == 10 or index == "_22" then
        self.m22 = value
    elseif index == 11 or index == "_23" then
        self.m23 = value
    elseif index == 12 or index == "_30" then
        self.m30 = value
    elseif index == 13 or index == "_31" then
        self.m31 = value
    elseif index == 14 or index == "_32" then
        self.m32 = value
    elseif index == 15 or index == "_33" then
        self.m33 = value
    else
        return rawset(self, index, value)
    end
end

--- API 新增 按行列访问/
function Matrix4x4:At(row, col, val)
    local index = row * 4 + col
    if val ~= nil then
        self[index] = val
    end
    return self[index]
end

-- Inplementation of MonoGame
function Matrix4x4.Inverse(matrix)
    -- 参考 https://github.com/mono/MonoGame/blob/develop/MonoGame.Framework/Matrix.cs#L1251
    local num1 = matrix.m00;
    local num2 = matrix.m01;
    local num3 = matrix.m02;
    local num4 = matrix.m03;
    local num5 = matrix.m10;
    local num6 = matrix.m11;
    local num7 = matrix.m12;
    local num8 = matrix.m13;
    local num9 = matrix.m20;
    local num10 = matrix.m21;
    local num11 = matrix.m22;
    local num12 = matrix.m23;
    local num13 = matrix.m30;
    local num14 = matrix.m31;
    local num15 = matrix.m32;
    local num16 = matrix.m33;
    local num17 = (num11 * num16 - num12 * num15);
    local num18 = (num10 * num16 - num12 * num14);
    local num19 = (num10 * num15 - num11 * num14);
    local num20 = (num9 * num16 - num12 * num13);
    local num21 = (num9 * num15 - num11 * num13);
    local num22 = (num9 * num14 - num10 * num13);
    local num23 = (num6 * num17 - num7 * num18 + num8 * num19);
    local num24 = -(num5 * num17 - num7 * num20 + num8 * num21);
    local num25 = (num5 * num18 - num6 * num20 + num8 * num22);
    local num26 = -(num5 * num19 - num6 * num21 + num7 * num22);
    local num27 = (1.0 / (num1 * num23 + num2 * num24 + num3 * num25 + num4 * num26));

    local result = Matrix4x4.new()
    result.m00 = num23 * num27;
    result.m10 = num24 * num27;
    result.m20 = num25 * num27;
    result.m30 = num26 * num27;
    result.m01 = -(num2 * num17 - num3 * num18 + num4 * num19) * num27;
    result.m11 = (num1 * num17 - num3 * num20 + num4 * num21) * num27;
    result.m31 = -(num1 * num18 - num2 * num20 + num4 * num22) * num27;
    result.m31 = (num1 * num19 - num2 * num21 + num3 * num22) * num27;
    local num28 = (num7 * num16 - num8 * num15);
    local num29 = (num6 * num16 - num8 * num14);
    local num30 = (num6 * num15 - num7 * num14);
    local num31 = (num5 * num16 - num8 * num13);
    local num32 = (num5 * num15 - num7 * num13);
    local num33 = (num5 * num14 - num6 * num13);
    result.m02 = (num2 * num28 - num3 * num29 + num4 * num30) * num27;
    result.m12 = -(num1 * num28 - num3 * num31 + num4 * num32) * num27;
    result.m22 = (num1 * num29 - num2 * num31 + num4 * num33) * num27;
    result.m32 = -(num1 * num30 - num2 * num32 + num3 * num33) * num27;
    local num34 = (num7 * num12 - num8 * num11);
    local num35 = (num6 * num12 - num8 * num10);
    local num36 = (num6 * num11 - num7 * num10);
    local num37 = (num5 * num12 - num8 * num9);
    local num38 = (num5 * num11 - num7 * num9);
    local num39 = (num5 * num10 - num6 * num9);
    result.m03 = -(num2 * num34 - num3 * num35 + num4 * num36) * num27;
    result.m13 = (num1 * num34 - num3 * num37 + num4 * num38) * num27;
    result.m23 = -(num1 * num35 - num2 * num37 + num4 * num39) * num27;
    result.m33 = (num1 * num36 - num2 * num38 + num3 * num39) * num27;
    return result
end

-- API from UnityEngine
-- Inplementation of XNA(MonoGame)
function Matrix4x4.Ortho(left, right, bottom, top, zNear, zFar)
    -- 参考 CreateOrthographicOffCenter https://github.com/mono/MonoGame/blob/develop/MonoGame.Framework/Matrix.cs#L645
    local result = Matrix4x4.new()
    result.m00 = (2.0 / (right - left));
    result.m01 = 0.0;
    result.m02 = 0.0;
    result.m03 = 0.0;
    result.m10 = 0.0;
    result.m11 = (2.0 / (top - bottom));
    result.m12 = 0.0;
    result.m13 = 0.0;
    result.m20 = 0.0;
    result.m21 = 0.0;
    result.m22 = (1.0 / (zNear - zFar));
    result.m23 = 0.0;
    result.m30 = ((left + right) / (left - right));
    result.m31 = ((top + bottom) / (bottom - top));
    result.m32 = (zNear / (zNear - zFar));
    result.m33 = 1.0;
    return result;
end

-- API from XNA (Modified)
-- Inplementation of XNA(MonoGame)
function Matrix4x4.OrthoCentered(width, height, zNear, zFar)
    -- 参考 CreateOrthographicOffCenters https://github.com/mono/MonoGame/blob/develop/MonoGame.Framework/Matrix.cs#L623
    local result = Matrix4x4.new()
    result.m00 = 2 / width;
    result.m01 = 0
    result.m02 = 0
    result.m03 = 0;
    result.m11 = 2 / height;
    result.m10 = 0
    result.m12 = 0
    result.m13 = 0;
    result.m22 = 1 / (zNear - zFar);
    result.m20 = 0
    result.m21 = 0
    result.m23 = 0;
    result.m30 = 0
    result.m31 = 0;
    result.m32 = zNear / (zNear - zFar);
    result.m33 = 1;
    return result
end

-- API from UnityEngine
-- Inplementation of XNA(MonoGame)
function Matrix4x4.Perspective(fov, aspect, zNear, zFar)
    -- 参考 CreatePerspectiveFieldOfView https://github.com/mono/MonoGame/blob/develop/MonoGame.Framework/Matrix.cs#L708
    if ((fov <= 0) or (fov >= 3.141593)) then
        print("fov <= 0 or >= PI");
    end
    if (zNear <= 0) then
        print("zNear <= 0");
    end
    if (zFar <= 0) then
        print("zFar <= 0");
    end
    if (zNear >= zFar) then
        print("zNear >= zFar");
    end
    local num = 1 / (Math.Tan((fov * 0.5)));
    local num9 = num / aspect;

    local result = Matrix4x4.new()
    result.m11 = num9;
    result.m12 = 0 
    result.m13 = 0
    result.m14 = 0;
    result.m22 = num;
    result.m21 = 0
    result.m23 = 0
    result.m24 = 0;
    result.m31 = 0
    result.m32 = 0;
    result.m33 = zFar / (zNear - zFar);
    result.m34 = -1;
    result.m41 = 0
    result.m42 = 0
    result.m44 = 0;
    result.m43 = (zNear * zFar) / (zNear - zFar);
    return result
end

-- API from XNA (Modified)
-- Inplementation of XNA(MonoGame)
function Matrix4x4.PerspectiveWH(width, height, nearPlaneDistance, farPlaneDistance)
    -- 参考 CreatePerspective https://github.com/mono/MonoGame/blob/develop/MonoGame.Framework/Matrix.cs#L674
    local result = Matrix4x4.new()
    if (nearPlaneDistance <= 0) then
        print("近平面必须大于0!")
    end
    if (farPlaneDistance <= 0) then
        print("远平面必须大于0!")
    end
    if (nearPlaneDistance >= farPlaneDistance) then
        print("远平面小于近平面!")
    end
    result.m00 = (2 * nearPlaneDistance) / width;
    result.m01 = 0
    result.m02 = 0
    result.m03 = 0;
    result.m11 = (2 * nearPlaneDistance) / height;
    result.m10 = 0
    result.m12 = 0
    result.m13 = 0;
    result.m22 = farPlaneDistance / (nearPlaneDistance - farPlaneDistance);
    result.m20 = 0
    result.m21 = 0;
    result.m23 = -1;
    result.m30 = 0
    result.m31 = 0
    result.m33 = 0;
    result.m32 = (nearPlaneDistance * farPlaneDistance) / (nearPlaneDistance - farPlaneDistance);
    return result
end

function Matrix4x4.Scale(vec3)
    -- TODO 支持Matrix4x4.zero
    local matrix = Matrix4x4.new()
    matrix.m00 = vec3.x
    matrix.m11 = vec3.y
    matrix.m22 = vec3.z
    return matrix
end

-- API Unity
-- Impl XNA(MonoGame)
function Matrix4x4.Transpose(matrix)
    -- 参考 Transpose https://github.com/mono/MonoGame/blob/develop/MonoGame.Framework/Matrix.cs#L1817
    local ret = Matrix4x4.new()
            
    ret.m00 = matrix.m00;
    ret.m01 = matrix.m10;
    ret.m02 = matrix.m20;
    ret.m03 = matrix.m30;

    ret.m10 = matrix.m01;
    ret.m11 = matrix.m11;
    ret.m12 = matrix.m21;
    ret.m13 = matrix.m31;

    ret.m20 = matrix.m02;
    ret.m21 = matrix.m12;
    ret.m22 = matrix.m22;
    ret.m23 = matrix.m32;

    ret.m30 = matrix.m03;
    ret.m31 = matrix.m13;
    ret.m32 = matrix.m23;
    ret.m33 = matrix.m33;
    
    return ret;
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
    vec4.x = self:At(0, i)
    vec4.y = self:At(1, i)
    vec4.z = self:At(2, i)
    vec4.w = self:At(3, i)
    return vec4
end

-- function Matrix4x4:GetHashCode()
--     return self.GetColumn(0).GetHashCode () ^ self.GetColumn(1).GetHashCode () << 2 ^ self.GetColumn(2).GetHashCode () >> 2 ^ self.GetColumn(3).GetHashCode() >> 1;
-- end

function Matrix4x4:GetRow()
    local vec4 = Vector4:new()
    vec4.x = self:At(i, 0)
    vec4.y = self:At(i, 1)
    vec4.z = self:At(i, 2)
    vec4.w = self:At(i, 3)
    return vec4
end

function Matrix4x4:MultiplyPoint(vec3)
    local result = Vector3:new()
    result.x = self.m00 * vec3.x + self.m01 * vec3.y + self.m02 * vec3.z + self.m03
    result.y = self.m10 * vec3.x + self.m11 * vec3.y + self.m12 * vec3.z + self.m13
    result.z = self.m20 * vec3.x + self.m21 * vec3.y + self.m22 * vec3.z + self.m23
    local num = self.m30 * vec3.x + self.m31 * vec3.y + self.m32 * vec3.z + self.m33
    num = 1 / num
    result.x = result.x * num
    result.y = result.y * num
    result.z = result.z * num
    return result
end

function Matrix4x4:MultiplyPoint3x4(vec3)
    local result = Vector3:new()
    result.x = self.m00 * vec3.x + self.m01 * vec3.y + self.m02 * vec3.z + self.m03
    result.y = self.m10 * vec3.x + self.m11 * vec3.y + self.m12 * vec3.z + self.m13
    result.z = self.m20 * vec3.x + self.m21 * vec3.y + self.m22 * vec3.z + self.m23
    return result
end


function Matrix4x4:MultiplyVector(vec3)
    local result = Vector3:new()
    result.x = self.m00 * vec3.x + self.m01 * vec3.y + self.m02 * vec3.z
    result.y = self.m10 * vec3.x + self.m11 * vec3.y + self.m12 * vec3.z
    result.z = self.m20 * vec3.x + self.m21 * vec3.y + self.m22 * vec3.z
    return result
end


function Matrix4x4:SetColumn(i, v)
    self:At(0, i, v.x)
    self:At(1, i, v.y)
    self:At(2, i, v.z)
    self:At(3, i, v.w)
end

function Matrix4x4:SetRow(i, v)
    self:At(i, 0, v.x)
    self:At(i, 1, v.y)
    self:At(i, 2, v.z)
    self:At(i, 3, v.w)
end

function Matrix4x4:SetTRS (pos, q, s)
    -- TODO 真的可以这样给self赋值?
    self = Matrix4x4.TRS (pos, q, s)
end

-- TODO 使lua的tostring()能够检测到
function Matrix4x4:__tostring()
    return string.format("%.1f\t%.1f\t%.1f\t%.1f\n%.1f\t%.1f\t%.1f\t%.1f\n%.1f\t%.1f\t%.1f\t%.1f\n%.1f\t%.1f\t%.1f\t%.1f\n",
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

-- function Matrix4x4:__tostring(format)
--     return string.format ("{0}\t{1}\t{2}\t{3}\n{4}\t{5}\t{6}\t{7}\n{8}\t{9}\t{10}\t{11}\n{12}\t{13}\t{14}\t{15}\n", 
--         string.format(format, self.m00),
--         string.format(format, self.m01),
--         string.format(format, self.m02),
--         string.format(format, self.m03),
--         string.format(format, self.m10),
--         string.format(format, self.m11),
--         string.format(format, self.m12),
--         string.format(format, self.m13),
--         string.format(format, self.m20),
--         string.format(format, self.m21),
--         string.format(format, self.m22),
--         string.format(format, self.m23),
--         string.format(format, self.m30),
--         string.format(format, self.m31),
--         string.format(format, self.m32),
--         string.format(format, self.m33))
-- end


-- TODO 重载运算符
function Matrix4x4.__eq(lhs, rhs)
    return lhs:GetColumn(0)==rhs:GetColumn(0) and lhs:GetColumn(1)==rhs:GetColumn(1) and lhs:GetColumn(2)==rhs:GetColumn(2) and lhs:GetColumn(3)==rhs:GetColumn(3)
end

function Matrix4x4.__mul(lhs, rhs)
    if rhs.__cname == "Vector4" then
        local newVec4 = Vector4:new()
        newVec4.x = lhs.m00 * rhs.x + lhs.m01 * rhs.y + lhs.m02 * rhs.z + lhs.m03 * rhs.w
        newVec4.y = lhs.m10 * rhs.x + lhs.m11 * rhs.y + lhs.m12 * rhs.z + lhs.m13 * rhs.w
        newVec4.z = lhs.m20 * rhs.x + lhs.m21 * rhs.y + lhs.m22 * rhs.z + lhs.m23 * rhs.w
        newVec4.w = lhs.m30 * rhs.x + lhs.m31 * rhs.y + lhs.m32 * rhs.z + lhs.m33 * rhs.w
        return newVec4
    else
        local newMat = Matrix4x4:new()
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
end

function Matrix4x4.__concat(a, b)
    return tostring(a)..tostring(b)
end

return Matrix4x4