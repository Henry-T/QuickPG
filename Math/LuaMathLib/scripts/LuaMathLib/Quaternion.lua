--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-30 10:31:45
--

----------------------------
-- Unity中对Quaternion的描述
----------------------------
-- Quaternions are used to represent rotations.
-- They are compact, don't suffer from gimbal lock and can easily be interpolated. Unity internally uses Quaternions to represent all rotations.
-- They are based on complex numbers and are not easy to understand intuitively. You almost never access or modify individual Quaternion components (x,y,z,w); most often you would just take existing rotations (e.g. from the Transform) and use them to construct new rotations (e.g. to smoothly interpolate between two rotations). The Quaternion functions that you use 99% of the time are: Quaternion.LookRotation, Quaternion.Angle, Quaternion.Euler, Quaternion.Slerp, Quaternion.FromToRotation, and Quaternion.identity. (The other functions are only for exotic uses.)
-- You can use the Quaternion.operator * to rotate one rotation by another, or to rotate a vector by a rotation.

-- 四元数是一种表示旋转的方式
-- 没有万向锁问题，易插值(Quaternion是最适合插值的旋转表示方式)


-- 参考 旋转矩阵、欧拉角和四元数的比较 http://wenku.baidu.com/view/df9e2133eefdc8d376ee32c4
-- 

local Quaternion = class("Quaternion")

--- [[Static Fields]]
Quaternion.kEpsilon = 1E-05;

--- [[Fields]]

function Quaternion:ctor(x, y, z, w)
    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
    self.w = w or 1
end

function Quaternion:__index(index)
    if index == 0 then
        return self.x
    elseif index == 1 then
        return self.y
    elseif index == 2 then
        return self.z
    elseif index == 3 then
        return self.w
    elseif index == "identity" then
        return Quaternion.new(0,0,0,1)
    elseif index == "eulerAngles" then
        return Quaternion.Internal_ToEulerRad (self) * 57.29578;
    else
        return rawget(self, index)
    end
end

local MetaQuaternion = {}

function MetaQuaternion:__index(index)
    if index == "identity" then
        return Quaternion.new(0,0,0,1)
    else 
        return rawget(self, index)
    end
end

setmetatable(Quaternion, MetaQuaternion)

function Quaternion:__newindex(index, value)
    if index == 0 then
        self.x = value
    elseif index == 1 then
        self.y = value
    elseif index == 2 then
        self.z = value
    elseif index == 3 then
        self.w = value
    elseif index == "eulerAngles" then
        self = Quaternion.Internal_FromEulerRad (value * 0.0174532924)
    else
        return rawset(self, index, value)
    end
end

function Quaternion.Angle(a, b)
    local f = Quaternion.Dot (a, b);
    return Math.Acos(Math.Min(Math.Abs(f), 1)) * 2 * 57.29578;
end

function Quaternion.AngleAxis(angle, axis)
    -- return Quaternion.INTERNAL_CALL_AngleAxis (angle, ref axis);
    -- 参考 https://github.com/mrdoob/three.js/blob/master/src/math/Quaternion.js

    local halfAngle = angle / 2
    local s = Math.Sin(halfAngle)

    local q = Quaternion.new()
    q.x = axis.x * s
    q.y = axis.y * s
    q.z = axis.z * s
    q.w = Math.Cos(halfAngle)
    return q
end

function Quaternion.Dot(a, b)
    return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w
end

--- 使用欧拉角构造一个四元数
-- 重载形式 Euler(number, number, number)
-- 重载形式 Euler(Vector3)
function Quaternion.Euler(x, y, z)
    if type(x) == "number" then
        return Quaternion.Internal_FromEulerRad(Vector3.new(x, y, z) * 0.0174532924);
    else
        local euler = x
        return Quaternion.Internal_FromEulerRad (euler * 0.0174532924);
    end
end

-- 将输入四元数转换为欧拉角
function Quaternion.Internal_ToEulerRad(q)
    -- 参考 https://github.com/mrdoob/three.js/blob/master/src/math/Euler.js
    local sqx = q.x * q.x
    local sqy = q.y * q.y
    local sqz = q.z * q.z
    local sqw = q.w * q.w

    local eulerAngles = Vector3.new()
    eulerAngles.x = math.atan2(2*(q.x*q.w - q.y*q.z), (sqw - sqx - sqy + sqz))
    eulerAngles.y = Math.Asin(Math.Clamp( 2 * ( q.x * q.z + q.y * q.w ), - 1, 1 ))
    eulerAngles.z = Math.Atan2(2 * ( q.z * q.w - q.x * q.y ), ( sqw + sqx - sqy - sqz ))
    return eulerAngles
end

function Quaternion.Internal_FromEulerRad(euler)
    -- 参考 https://github.com/mrdoob/three.js/blob/master/src/math/Quaternion.js
    local c1 = Math.Cos( euler.x / 2 )
    local c2 = Math.Cos( euler.y / 2 )
    local c3 = Math.Cos( euler.z / 2 )
    local s1 = Math.Sin( euler.x / 2 )
    local s2 = Math.Sin( euler.y / 2 )
    local s3 = Math.Sin( euler.z / 2 )

    local q = Quaternion.new()
    q.x = s1 * c2 * c3 + c1 * s2 * s3
    q.y = c1 * s2 * c3 - s1 * c2 * s3
    q.z = c1 * c2 * s3 + s1 * s2 * c3
    q.w = c1 * c2 * c3 - s1 * s2 * s3
    return q
end

function Quaternion.FromToRotation(fromDirection, toDirection)
    -- return Quaternion.INTERNAL_CALL_FromToRotation (ref fromDirection, ref toDirection);
    -- https://github.com/mrdoob/three.js/blob/master/src/math/Quaternion.js

    local vFrom = fromDirection.normalized
    local vTo = toDirection.normalized

    local v1 = Vector3.new(1,1,1)
    local r = vFrom:Dot( vTo ) + 1;

    if r < Quaternion.kEpsilon then
        r = 0;
        if  Math.Abs( vFrom.x ) > Math.Abs( vFrom.z ) then
            v1.Set( - vFrom.y, vFrom.x, 0 )
        else
            v1.Set( 0, - vFrom.z, vFrom.y )
        end
    else
        v1 = Vector3.Cross(vFrom, vTo)
    end

    local q = Quaternion.new()
    q.x = v1.x;
    q.y = v1.y;
    q.z = v1.z;
    q.w = r;

    -- three.js在返回前对Quaternion做归一化操作，但是归一化如何定义？意义又何在呢？
    -- q.normalize();

    return q;
end

--- 反转
function Quaternion.Inverse(q)
    --return Quaternion.INTERNAL_CALL_Inverse (ref rotation);
    -- 参考 https://github.com/mrdoob/three.js/blob/master/src/math/Quaternion.js
    -- 参考 http://introcs.cs.princeton.edu/java/32class/Quaternion.java.html
    local d = q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w

    local ret = Quaternion.new(-q.x/d, -q.y/d, -q.z/d, q.w/d)
    return ret
end

--- 线性插值
-- API from UnityEngine & XNA
-- Implementation of XNA (MonoGame)
-- Note of UnityEngine 与Slerp相比速度更快，但角度差别大时效果会变差
function Quaternion.Lerp(from, to, t)
    -- return Quaternion.INTERNAL_CALL_Lerp (ref from, ref to, t);
    -- 参考 https://github.com/mono/MonoGame/blob/develop/MonoGame.Framework/Quaternion.cs#L441

    local num = t;
    local num2 = 1 - num;
    local quaternion = Quaternion.new();
    local num5 = (((from.x * to.x) + (from.y * to.y)) + (from.z * to.z)) + (from.w * to.w);
    if (num5 >= 0) then
        quaternion.x = (num2 * from.x) + (num * to.x);
        quaternion.y = (num2 * from.y) + (num * to.y);
        quaternion.z = (num2 * from.z) + (num * to.z);
        quaternion.w = (num2 * from.w) + (num * to.w);
    else
        quaternion.x = (num2 * from.x) - (num * to.x);
        quaternion.y = (num2 * from.y) - (num * to.y);
        quaternion.z = (num2 * from.z) - (num * to.z);
        quaternion.w = (num2 * from.w) - (num * to.w);
    end

    local num4 = (((quaternion.x * quaternion.x) + (quaternion.y * quaternion.y)) + (quaternion.z * quaternion.z)) + (quaternion.w * quaternion.w);
    local num3 = 1 / (Math.Sqrt(num4));
    quaternion.x = quaternion.x * num3;
    quaternion.y = quaternion.y * num3;
    quaternion.z = quaternion.z * num3;
    quaternion.w = quaternion.w * num3;
    return quaternion;
end

function Quaternion.LookRotation (forward, upwards)
    -- return Quaternion.INTERNAL_CALL_LookRotation (ref forward, ref upwards);
    -- 实现来自 http://answers.unity3d.com/questions/467614/what-is-the-source-code-of-quaternionlookrotation.html

    local forward = forward.normalized;
    local upwards = upwards or Vector3.up
 
    local vector = Vector3.Normalize(forward);
    local vector2 = Vector3.Normalize(Vector3.Cross(upwards, vector));
    local vector3 = Vector3.Cross(vector, vector2);
    local m00 = vector2.x;
    local m01 = vector2.y;
    local m02 = vector2.z;
    local m10 = vector3.x;
    local m11 = vector3.y;
    local m12 = vector3.z;
    local m20 = vector.x;
    local m21 = vector.y;
    local m22 = vector.z;
 
    local num8 = (m00 + m11) + m22;
    local quaternion = Quaternion.new();
    if (num8 > 0) then
        local num = Math.Sqrt(num8 + 1);
        quaternion.w = num * 0.5;
        num = 0.5 / num;
        quaternion.x = (m12 - m21) * num;
        quaternion.y = (m20 - m02) * num;
        quaternion.z = (m01 - m10) * num;
        return quaternion;
    end

    if ((m00 >= m11) and (m00 >= m22)) then
        local num7 = Math.Sqrt(((1 + m00) - m11) - m22);
        local num4 = 0.5 / num7;
        quaternion.x = 0.5 * num7;
        quaternion.y = (m01 + m10) * num4;
        quaternion.z = (m02 + m20) * num4;
        quaternion.w = (m12 - m21) * num4;
        return quaternion;
    end

    if (m11 > m22) then
        local num6 = Math.Sqrt(((1 + m11) - m00) - m22);
        local num3 = 0.5 / num6;
        quaternion.x = (m10+ m01) * num3;
        quaternion.y = 0.5 * num6;
        quaternion.z = (m21 + m12) * num3;
        quaternion.w = (m20 - m02) * num3;
        return quaternion; 
    end

    local num5 = Math.Sqrt(((1 + m22) - m00) - m11);
    local num2 = 0.5 / num5;
    quaternion.x = (m20 + m02) * num2;
    quaternion.y = (m21 + m12) * num2;
    quaternion.z = 0.5 * num5;
    quaternion.w = (m01 - m10) * num2;
    return quaternion;
end

function Quaternion.RotateTowards ( from,  to, maxDegreesDelta)
    local num = Quaternion.Angle (from, to);
    if num == 0 then
        return to;
    end
    local t = Math.Min (1, maxDegreesDelta / num);

    -- TODO 了解UnclampedSlerp的意图，实现并替换它
    -- return Quaternion.UnclampedSlerp (from, to, t);
    return Quaternion.Slerp (from, to, t);
end

function Quaternion.UnclampedSlerp(from, to, t)
    -- TODO ...
end

--- 球面线性插值
-- API from UnityEngine & XNA
-- Implementation of XNA (MonoGame)
function Quaternion.Slerp ( from,  to, t)
    -- return Quaternion.INTERNAL_CALL_Slerp (ref from, ref to, t);
    -- 参考 https://github.com/mono/MonoGame/blob/develop/MonoGame.Framework/Quaternion.cs#L500

    -- MonoGame这是搬运XNA源码的...
    local num2;
    local num3;
    local q = Quaternion.new();
    local num = t;
    local num4 = (((from.x * to.x) + (from.y * to.y)) + (from.z * to.z)) + (from.w * to.w);
    local flag = false;
    if (num4 < 0) then
        flag = true;
        num4 = -num4;
    end

    if (num4 > 0.999999) then
        num3 = 1 - num;
        if flag then
            num2 = -num
        else
            num2 = num
        end
    else
        local num5 = Math.Acos(num4);
        local num6 = (1.0 / Math.Sin(num5));
        num3 = (Math.Sin(((1 - num) * num5))) * num6;
        if flag then
            num2 = ((-Math.Sin((num * num5))) * num6)
        else
            num2 = ((Math.Sin((num * num5))) * num6)
        end
    end

    q.x = (num3 * from.x) + (num2 * to.x);
    q.y = (num3 * from.y) + (num2 * to.y);
    q.z = (num3 * from.z) + (num2 * to.z);
    q.w = (num3 * from.w) + (num2 * to.w);
    return q;
end

--- [[Methods]]
function Quaternion:Equals(other)
    if other.__cname ~= "Quaternion" then
        return false
    end
    return self.x == other.x and self.y == other.y and self.z == other.z and self.w == other.w;
end

-- public override int GetHashCode ()
-- {
--   return self.x.GetHashCode () ^ self.y.GetHashCode () << 2 ^ self.z.GetHashCode () >> 2 ^ self.w.GetHashCode () >> 1;
-- }

function Quaternion:Set(new_x, new_y, new_z, new_w)
    self.x = new_x;
    self.y = new_y;
    self.z = new_z;
    self.w = new_w;
end

function Quaternion:SetFromToRotation(fromDirection, toDirection)
    self = Quaternion.FromToRotation(fromDirection, toDirection);
end

function Quaternion:SetLookRotation(view, up)
    up = up or Vector3.up
    self = Quaternion.LookRotation(view, up);
end

function Quaternion:SetLookRotation(view)
    self.SetLookRotation (view, Vector3.up);
end

function Quaternion:ToAngleAxis(angle, axis)
    -- Quaternion.Internal_ToAxisAngleRad (self, out axis, out angle);
    axis, angle = Quaternion.Internal_ToAxisAngleRad (self, axis, angle);
    angle = angle * 57.29578;
    return angle, axis
end

function Quaternion:__tostring()
    return string.format("(%.1f, %.1f, %.1f, %.1f)", self.x, self.y, self.z, self.w)
end

function Quaternion.ToFormatString(format)
    return string.format("(%s, %s, %s, %s)",
        string.format(format, self.x),
        string.format(format, self.y),
        string.format(format, self.z),
        string.format(format, self.w))
end

function Quaternion.__eq( lhs,  rhs)
    return Quaternion.Dot (lhs, rhs) > 0.999999;
end

function Quaternion.__mul( lhs,  rhs)
    if lhs.__cname == "Quaternion" and rhs.__cname == "Quaternion" then
        return Quaternion.new (lhs.w * rhs.x + lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y, lhs.w * rhs.y + lhs.y * rhs.w + lhs.z * rhs.x - lhs.x * rhs.z, lhs.w * rhs.z + lhs.z * rhs.w + lhs.x * rhs.y - lhs.y * rhs.x, lhs.w * rhs.w - lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z);
    elseif lhs.__cname=="Quaternion" and rhs.__cname=="Vector3" then
        local num = lhs.x * 2;
        local num2 = lhs.y * 2;
        local num3 = lhs.z * 2;
        local num4 = lhs.x * num;
        local num5 = lhs.y * num2;
        local num6 = lhs.z * num3;
        local num7 = lhs.x * num2;
        local num8 = lhs.x * num3;
        local num9 = lhs.y * num3;
        local num10 = lhs.w * num;
        local num11 = lhs.w * num2;
        local num12 = lhs.w * num3;
        local result = Vector3.new()
        result.x = (1 - (num5 + num6)) * rhs.x + (num7 - num12) * rhs.y + (num8 + num11) * rhs.z;
        result.y = (num7 + num12) * rhs.x + (1 - (num4 + num6)) * rhs.y + (num9 - num10) * rhs.z;
        result.z = (num8 - num11) * rhs.x + (num9 + num10) * rhs.y + (1 - (num4 + num5)) * rhs.z;
        return result;
    elseif lhs.__cname=="Quaternion" and rhs.__cname=="Vector2" then
        -- TODO 
        print("暂时不支持Quaternion右乘Vector2")
    end  
end

function Quaternion.__concat(a, b)
    return tostring(a)..tostring(b)
end

return Quaternion