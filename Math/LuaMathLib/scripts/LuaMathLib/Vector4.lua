--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-01 15:35:51
--


local Vector4 = class("Vector4")

--- [[Static Fields]]
-- kEpsilon = 1E-05;

function Vector4:ctor(x, y, z, w)
    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
    self.w = w or 0
end

function Vector4:__index(index)
    if index == 0 then
        return self.x
    elseif index == 1 then
        return self.y
    elseif index == 2 then
        return self.z
    elseif index == 3 then
        return self.w
    elseif index == "magnitude" then
        return Math.Sqrt(Vector4.Dot(self, self))
    elseif index == "normalized" then
        return Vector4.Normalize (self)
    elseif index == "sqrMagnitude" then
        return Vector4.Dot (self, self);
    else
        return rawget(self, index)
    end
end

local MetaVector4 = {}

function MetaVector4:__index(index)
    if index == "one" then
        return Vector4.new(1,1,1,1)
    elseif index == "zero" then
        return Vector4.new(0,0,0,0)
    else
        return rawget(self, index)
    end
end

setmetatable(Vector4, MetaVector4)

function Vector4:__newindex(index, value)
    if index == 0 then
        self.x = value
    elseif index == 1 then
        self.y = value
    elseif index == 2 then
        self.z = value
    elseif index == 3 then
        self.w = value
    else
        return rawset(self, index, value)
    end
end

--- [[Static Methods]]
function Vector4.Distance (a, b)
    return Vector4.Magnitude (a - b);
end

function Vector4.Dot (a, b)
    return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
end

function Vector4.Lerp (from, to, t)
    t = Math.Clamp01 (t);
    return Vector4.new (from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t, from.z + (to.z - from.z) * t, from.w + (to.w - from.w) * t);
end

function Vector4.Magnitude (a)
    return Math.Sqrt (Vector4.Dot (a, a));
end

function Vector4.Max (lhs, rhs)
    return Vector4.new (Math.Max (lhs.x, rhs.x), Math.Max (lhs.y, rhs.y), Math.Max (lhs.z, rhs.z), Math.Max (lhs.w, rhs.w));
end

function Vector4.Min (lhs, rhs)
    return Vector4.new (Math.Min (lhs.x, rhs.x), Math.Min (lhs.y, rhs.y), Math.Min (lhs.z, rhs.z), Math.Min (lhs.w, rhs.w));
end

function Vector4.MoveTowards (current, target, maxDistanceDelta)
    local a = target - current;
    local magnitude = a.magnitude;
    if (magnitude <= maxDistanceDelta or magnitude == (d)) then
      return target;
    end
    return current + a / magnitude * maxDistanceDelta;
end

function Vector4.Normalize (a)
    local num = Vector4.Magnitude (a);
    if (num > 1E-05) then
        return a / num;
    end
    return Vector4.zero;
end

function Vector4.Project (a, b)
    return b * Vector4.Dot (a, b) / Vector4.Dot (b, b);
end

function Vector4.Scale (a, b)
    return Vector4.new (a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w);
end

function Vector4.SqrMagnitude (a)
    return Vector4.Dot (a, a);
end

--- [[Methods]]
function Vector4:Equals(other)
    if other.__cname ~= "Vector4" then
        return false
    end
    return self.x == other.x and self.y == other.y and self.z == other.z and self.w == other.w;
end

-- public override int GetHashCode ()
-- {
--   return self.x.GetHashCode () ^ self.y.GetHashCode () << 2 ^ self.z.GetHashCode () >> 2 ^ self.w.GetHashCode () >> 1;
-- }

function Vector4:Normalize()
    local num = Vector4.Magnitude (self);
    if (num > 1E-05) then
        self = self / num;
    else
        self = Vector4.zero;
    end
end

function Vector4:Set (new_x, new_y, new_z, new_w)
    self.x = new_x;
    self.y = new_y;
    self.z = new_z;
    self.w = new_w;
end

function Vector4:__tostring()
    return string.format("(%.1f, %.1f, %.1f, %.1f)", self.x, self.y, self.z, self.w)
end

function Vector4:ToFormatString (format)
    return string.format("(%s, %s, %s, %s)",
        format.tostring(format, self.x),
        format.tostring(format, self.y),
        format.tostring(format, self.z),
        format.tostring(format, self.w))
end

function Vector4.__add(a, b)
    return Vector4.new (a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w);
end

function Vector4.__div(a, d)
    return Vector4.new (a.x / d, a.y / d, a.z / d, a.w / d);
end

function Vector4.__eq(lhs, rhs)
    return Vector4.SqrMagnitude (lhs - rhs) < 9.99999944E-11;
end

function Vector4.__mul(a, d)
    if type(d) == "number" then
        return Vector4.new (a.x * d, a.y * d, a.z * d, a.w * d);
    else
        return Vector4.new (a.x * d, a.y * d, a.z * d, a.w * d);
    end
end

function Vector4.__sub(a, b)
    return Vector4.new (a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w);
end

function Vector4.__unm(a)
    return Vector4.new (-a.x, -a.y, -a.z, -a.w);
end

function Vector4.__concat(a, b)
    return tostring(a)..tostring(b)
end

return Vector4