--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-30 10:31:29
--

local Vector3 = class("Vector3")

Vector3.kEpsilon = 1e-5

function Vector3:ctor(x, y, z)
    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
end

function Vector3:sqrMagnitude()
    return self.x*self.x, self.y*self.y, self.z*self.z
end

function Vector3:__index(index)
    if index == 0 then
        return rawget(self, "x")
    elseif index == 1 then
        return rawget(self, "y")
    elseif index == 2 then
        return rawget(self, "z")
    elseif index == "magnitude" then
        return Vector3.Magnitude(self)
    elseif index == "normalized" then
        return Vector3.Normalize(self)
    elseif index == "one" then
        return Vector3.new(1,1,1)
    elseif index == "zero" then
        return Vector3.new(0,0,0)
    elseif index == "forward" then
        return Vector3.new(0,0,1)
    elseif index == "back" then
        return Vector3.new(0,0,-1)
    elseif index == "up" then
        return Vector3.new(0,1,0)
    elseif index == "down" then
        return Vector3.new(0,-1,0)
    elseif index == "right" then
        return Vector3.new(1,0,0)
    elseif index == "left" then
        return Vector3.new(-1,0,0)
    else
        return rawget(self, index)
    end
end

function Vector3:__newindex(index, value)
    if index == 0 then
        rawset(self, "x", value)
    elseif index == 1 then
        rawset(self, "y", value)
    elseif index == 2 then
        rawset(self, "z", value)
    else
        rawset(self, index, value)
    end
end

function Vector3.Angle(from, to)
    return Math.Acos(Math.Clamp(Vector3.Dot(from.normalized, to.normalized), -1, 1)) * 57.29578;
end


function Vector3.Cross(lhs, rhs)
    return Vector3.new(lhs.y * rhs.z - lhs.z * rhs.y, lhs.z * rhs.x - lhs.x * rhs.z, lhs.x * rhs.y - lhs.y * rhs.x);
end

function Vector3.Distance(a, b)
    local vector = Vector3.new(a.x - b.x, a.y - b.y, a.z - b.z);
    return Math.Sqrt(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z);
end

function Vector3.Dot(lhs, rhs)
    return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z;
end

--- 与投影垂直的直角边
-- @excludeThis 投影向量
-- @fromThat 原始向量
function Vector3.Exclude(excludeThis, fromThat)
    return fromThat - Vector3.Project (fromThat, excludeThis);
end

function Vector3.Lerp(from, to, t)
    t = Math.Clamp01 (t);
    return Vector3.new(from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t, from.z + (to.z - from.z) * t);
end

function Vector3.Magnitude(a)
    return Math.Sqrt (a.x * a.x + a.y * a.y + a.z * a.z);
end

function Vector3.Max(lhs, rhs)
    return Vector3.new(Math.Max (lhs.x, rhs.x), Math.Max (lhs.y, rhs.y), Math.Max (lhs.z, rhs.z));
end

function Vector3.Min(lhs, rhs)
    return Vector3.new(Math.Min (lhs.x, rhs.x), Math.Min (lhs.y, rhs.y), Math.Min (lhs.z, rhs.z));
end

function Vector3.MoveTowards(current, target, maxDistanceDelta)
    local a = target - current;
    local magnitude = a.magnitude;
    if magnitude <= maxDistanceDelta or magnitude == 0 then
      return target;
    end
    return current + a / magnitude * maxDistanceDelta;
end

function Vector3.Normalize(value)
    local num = Vector3.Magnitude (value);
    if num > 1E-05 then
      return value / num;
    end
    return Vector3.zero;
end

function Vector3.OrthoNormalize(normal, tangent, binormal)
    return Vector3.Internal_OrthoNormalize3 (normal, tangent, binormal);
    -- return normal, tangent, binormal
end

function Vector3.OrthoNormalize(normal, tangent)
    return Vector3.Internal_OrthoNormalize2 (normal, tangent)
    -- return normal, tangent
end

--- 投影向量
function Vector3.Project(vector, onNormal)
    local num = Vector3.Dot (onNormal, onNormal);
    if num < 1.401298E-45 then
        return Vector3.zero;
    end
    return onNormal * Vector3.Dot (vector, onNormal) / num;
end

function Vector3.Reflect(inDirection, inNormal)
    return -2 * Vector3.Dot (inNormal, inDirection) * inNormal + inDirection;
end

function Vector3.RotateTowards(current, target, maxRadiansDelta, maxMagnitudeDelta)
    -- TODO 实现RotateTowards
    return Vector3.INTERNAL_CALL_RotateTowards (current, target, maxRadiansDelta, maxMagnitudeDelta);
    -- return current, target, result
end

-- NOTE 修改了实现 分为修改a或创建新Vector3两种情况
function Vector3.Scale(a, b, mod)
    if mod then
        a.x = a.x * b.x;
        a.y = a.y * b.y;
        a.z = a.z * b.z;
        return a
    else
        return Vector3.new(a.x * b.x, a.y * b.y, a.z * b.z)
    end
end

function Vector3.Slerp(from, to, t)
    -- TODO 实现Slerp
    return Vector3.INTERNAL_CALL_Slerp (from, to, t);
end

function Vector3.SmoothDamp(current, target, currentVelocity, smoothTime, maxSpeed, deltaTime)
    smoothTime = Math.Max (0.0001, smoothTime);
    local num = 2 / smoothTime;
    local num2 = num * deltaTime;
    local d = 1 / (1 + num2 + 0.48 * num2 * num2 + 0.235 * num2 * num2 * num2);
    local vector = current - target;
    local vector2 = target;
    local maxLength = maxSpeed * smoothTime;
    vector = Vector3.ClampMagnitude (vector, maxLength);
    target = current - vector;
    local vector3 = (currentVelocity + num * vector) * deltaTime;
    currentVelocity = (currentVelocity - num * vector3) * d;
    local vector4 = target + (vector + vector3) * d;
    if Vector3.Dot (vector2 - current, vector4 - vector2) > 0 then
      vector4 = vector2;
      currentVelocity = (vector4 - vector2) / deltaTime;
    end
    return vector4, currentVelocity;
end

function Vector3.SqrMagnitude(a)
    return a.x * a.x + a.y * a.y + a.z * a.z;
end

function Vector3:Equals (other)
    if other.__cname ~= "Vector3" then
        return false;
    end
    local vector = other;
    return self.x == vector.x and self.y == vector.y and self.z == vector.z;
end

-- TODO 禁用此API
function Vector3:GetHashCode ()
    return self.x.GetHashCode () ^ bit:_lshift(self.y.GetHashCode(),2) ^ bit:_rshift(self.z.GetHashCode(), 2);
end

-- 冲突
-- function Vector3:Normalize()
--     local num = Vector3.Magnitude (self);
--     if num > 1E-05 then
--         self = self / num;
--     else
--         self = Vector3.zero;
--     end
-- end

function Vector3:Set(new_x, new_y, new_z)
    self.x = new_x;
    self.y = new_y;
    self.z = new_z;
end

-- function Vector3:__tostring(format)
--     return string.format("(%s, %s, %s)",
--         string.format(format, self.x),
--         string.format(format, self.y),
--         string.format(format, self.z))
-- end

function Vector3:__tostring()
    return string.format("(%.2f, %.2f, %.2f)",
        self.x,
        self.y,
        self.z)
end


-- 运算符
function Vector3.__add(a, b)
    return Vector3.new(a.x + b.x, a.y + b.y, a.z + b.z);
end

function Vector3.__div(a, d)
    return Vector3.new(a.x / d, a.y / d, a.z / d);
end

function Vector3.__eq(lhs, rhs)
    return Vector3.SqrMagnitude (lhs - rhs) < 9.99999944E-11;
end

-- NOTE 无法重载，因此合并左右参交换的情况
-- TODO 自己在函数内判断函数类型
-- TODO 确定左参能否非Vector3
function Vector3.__mul(a, b)
    if type(a) == "number" then
        return Vector3.new(a * b.x, a * b.y, a * b.z)
    else
        return Vector3.new(a.x * b, a.y * b, a.z * b)
    end
end

function Vector3.__sub(a, b)
    return Vector3.new(a.x - b.x, a.y - b.y, a.z - b.z);
end

function Vector3.__unm(a)
    return Vector3.new(-a.x, -a.y, -a.z);
end

--- 连接字符串的时候再也不用手工调tostring了!
function Vector3.__concat(a, b)
    return tostring(a)..tostring(b)
end

return Vector3