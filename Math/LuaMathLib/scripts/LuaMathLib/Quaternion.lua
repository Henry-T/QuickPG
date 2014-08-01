--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-30 10:31:45
--

local Quaternion = class("Quaternion")

--- [[Static Fields]]
-- kEpsilon = 1E-06;

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
    end
end

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
    end
end

function Quaternion.Angle (a, b)
    local f = Quaternion.Dot (a, b);
    return Math.Acos (Math.Min (Math.Abs (f), (d))) * (d) * 57.29578;
end

function Quaternion.AngleAxis (angle, axis)
    return Quaternion.INTERNAL_CALL_AngleAxis (angle, axis);
    -- ref axis
end

function Quaternion.Dot ( a,  b)
    return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
end

function Quaternion.Euler (x, y, z)
    return Quaternion.Internal_FromEulerRad (Vector3.new (x, y, z) * 0.0174532924);
end

function Quaternion.Euler (euler)
    return Quaternion.Internal_FromEulerRad (euler * 0.0174532924);
end

function Quaternion.FromToRotation (fromDirection, toDirection)
    -- return Quaternion.INTERNAL_CALL_FromToRotation (ref fromDirection, ref toDirection);

end

function Quaternion.Inverse ( rotation)
    --return Quaternion.INTERNAL_CALL_Inverse (ref rotation);
end

function Quaternion.Lerp ( from,  to, t)
    -- return Quaternion.INTERNAL_CALL_Lerp (ref from, ref to, t);
end

function Quaternion.LookRotation (forward, upwards)
    upwards = upwards or Vector3.up
    -- return Quaternion.INTERNAL_CALL_LookRotation (ref forward, ref upwards);
end

function Quaternion.LookRotation (forward)
    local up = Vector3.up;
    -- return Quaternion.INTERNAL_CALL_LookRotation (ref forward, ref up);
end

function Quaternion.RotateTowards ( from,  to, maxDegreesDelta)
    local num = Quaternion.Angle (from, to);
    if num == 0 then
        return to;
    end
    local t = Math.Min (1, maxDegreesDelta / num);
    return Quaternion.UnclampedSlerp (from, to, t);
end

function Quaternion.Slerp ( from,  to, t)
    -- return Quaternion.INTERNAL_CALL_Slerp (ref from, ref to, t);
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

function Quaternion:Set (new_x, new_y, new_z, new_w)
    self.x = new_x;
    self.y = new_y;
    self.z = new_z;
    self.w = new_w;
end

function Quaternion:SetFromToRotation (fromDirection, toDirection)
    self = Quaternion.FromToRotation (fromDirection, toDirection);
end

function Quaternion:SetLookRotation (view, up)
    up = up or Vector3.up
    self = Quaternion.LookRotation (view, up);
end

function Quaternion:SetLookRotation (view)
    self.SetLookRotation (view, Vector3.up);
end

function Quaternion:ToAngleAxis (angle, axis)
    -- Quaternion.Internal_ToAxisAngleRad (self, out axis, out angle);
    axis, angle = Quaternion.Internal_ToAxisAngleRad (self, axis, angle);
    angle = angle * 57.29578;
    return angle, axis
end

function Quaternion.__tostring()
    return string.format("(%.1f, %.1f, %.1f, %.1f)", self.x, self.y, self.z, self.w)
end

function Quaternion.ToFormatString (format)
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
        local num = lhs.x * (d);
        local num2 = lhs.y * (d);
        local num3 = lhs.z * (d);
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
        result.x = ((d) - (num5 + num6)) * rhs.x + (num7 - num12) * rhs.y + (num8 + num11) * rhs.z;
        result.y = (num7 + num12) * rhs.x + ((d) - (num4 + num6)) * rhs.y + (num9 - num10) * rhs.z;
        result.z = (num8 - num11) * rhs.x + (num9 + num10) * rhs.y + ((d) - (num4 + num5)) * rhs.z;
        return result;
    end  
end

return Quaternion