--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-30 10:31:34
--

local Vector2 = class("Vector2")

function Vector2:ctor(x, y)
    self.x = x or 0
    self.y = y or 0
end

--- [[Static Fields]]
-- kEpsilon = 1E-06;

--- [[Fields]]

function Vector2:__index(index)
    if index == 0 then
        return self.x
    elseif index == 1 then
        return self.y
    elseif index == "one" then
        return Vector2.new(1, 1)
    elseif index == "zero" then
        return Vector2.new(0, 0)
    elseif index == "right" then
        return Vector2.new(1, 0)
    elseif index == "up" then
        return Vector2.new(0, 1)
    elseif index == "magnitude" then
        return Math.Sqrt(self.x * self.x + self.y * self.y)
    elseif index == "normalized" then
        local result = Vector2.new (self.x, self.y);
        result.Normalize ();
        return result;
    elseif index == "sqrMagnitude" then
        return self.x * self.x + self.y * self.y;
    end
end

function Vector2:__newindex(index, value)
    if index == 0 then
        self.x = value
    elseif index == 1 then
        self.y = value
    end
end


function Vector2.SqrMagnitude (vec2)
  return self.x * self.x + self.y * self.y;
end

--- [[Static Methods]]
function Vector2.Angle (from, to)
    return Math.Acos(Math.Clamp(Vector2.Dot (from.normalized, to.normalized), -1, 1)) * 57.29578;
end

function Vector2.ClampMagnitude (vec2,  maxLength)
    if (vec2.sqrMagnitude > maxLength * maxLength) then
        return vec2.normalized * maxLength;
    end
    return vec2;
end

function Vector2.Distance (a, b)
    return (a - b).magnitude;
end

function Vector2.Dot (lhs, rhs)
    return lhs.x * rhs.x + lhs.y * rhs.y;
end

function Vector2.Lerp (from, to,  t)
    t = Math.Clamp01 (t);
    return Vector2.new (from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t);
end

function Vector2.Max (lhs, rhs)
    return Vector2.new (Math.Max (lhs.x, rhs.x), Math.Max (lhs.y, rhs.y));
end

function Vector2.Min (lhs, rhs)
    return Vector2.new (Math.Min (lhs.x, rhs.x), Math.Min (lhs.y, rhs.y));
end

function Vector2.MoveTowards (current, target, maxDistanceDelta)
    local a = target - current;
    local magnitude = a.magnitude;
    if magnitude <= maxDistanceDelta or magnitude == (d) then
      return target;
    end
    return current + a / magnitude * maxDistanceDelta;
end

function Vector2.Scale (a, b)
    return Vector2.new (a.x * b.x, a.y * b.y);
end

function Vector2.SqrMagnitude (a)
    return a.x * a.x + a.y * a.y;
end

--- [[Methods]]
function Vector2:Equals (other)
    if other.__cname ~= "Vector2" then
        return false
    end
    return self.x == vector.x and self.y == vector.y;
end

-- public override int GetHashCode ()
-- {
--   return self.x.GetHashCode () ^ self.y.GetHashCode () << 2;
-- }

function Vector2:Normalize ()
    local magnitude = self.magnitude;
    if magnitude > 1E-06 then
        self = self / magnitude;
    else
        self = Vector2.zero;
    end
end

function Vector2:Scale (scale)
    self.x = self.x * scale.x;
    self.y = self.y * scale.y;
end

function Vector2:Set (new_x,  new_y)
    self.x = new_x;
    self.y = new_y;
end


function Vector2:__tostring()
    return string.format("(%.2f, %.2f)", self.x, self.y)
end

function Vector2:__concat(a, b)
    return tostring(a)..tostring(b)
end

function Vector2:ToFormatString(format)
    return UnityString.Format ("(%s, %s)", string.format(format, self.x), string.format(format, self.y));
end

function Vector2.__add(a, b)
    return Vector2.new (a.x + b.x, a.y + b.y);
end

function Vector2.__div(a, d)
    return Vector2.new (a.x / d, a.y / d);
end

function Vector2.__eq(lhs, rhs)
    return Vector2.SqrMagnitude (lhs - rhs) < 9.99999944E-11;
end


function Vector2.__mul(a, b)
    if type(a) == "number" then
        return Vector2.new(a * b.x, a * b.y)
    else
        return Vector2.new(a.x * d, a.y * d)
    end
end

function Vector2.__sub(a, b)
    return Vector2.new (a.x - b.x, a.y - b.y);
end

function Vector2.__unm(a)
    return Vector2.new (-a.x, -a.y)
end

return Vector2