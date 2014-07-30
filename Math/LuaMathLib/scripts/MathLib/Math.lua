--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-30 10:31:23
--

local Math = {}

--- 角度转弧度系数
Math.Deg2Rad = 3.14159265358979 / 180

--- float精度的极小数
-- TODO 确认Unity平台下的值，在lua下是否正确
Math.Epsilon = 1.401298E-45

--- PI
Math.PI = 3.14159265358979

---  弧度转角度系数
Math.Rad2Deg = 180 / 3.14159265358979


--- 去绝对值
function Math.Abs(num)
    if num > 0 then
        return num
    else
        return -num
    end
end

---  Returns the arc-cosine of f - the angle in radians whose cosine is f.
function Math.Acos(cosOfRad)
    return math.acos(cosOfRad)
end

--- 两个浮点数近似相等
function Math.Approximately(a, b)
    return Math.Abs (b - a) < Math.Max (1E-06 * Math.Max (Math.Abs (a), Math.Abs (b)), 1.121039E-44);
end

---  Returns the arc-sine of f - the angle in radians whose sine is f.
function Math.Asin(sinOfRad)
    return math.asin(sinOfRad)
end

---  Returns the arc-tangent of f - the angle in radians whose tangent is f.
function Math.Atan(tanOfRad)
    return math.atan(tanOfRad)
end

--- Returns the angle in radians whose Tan is y/x.
function Math.Atan2(x, y)
    return math.atan2(y/x)
end

---  Returns the smallest integer greater to or equal to f.
function Math.Ceil(num)
    return math.ceil(num)
end

--- Clamps a value between a minimum float and maximum float value.
function Math.Clamp(num, min, max)
    if num < min then
        num = min
    elseif num > max then
        num = max
    end
    return num
end

--- Clamps value between 0 and 1 and returns value.
function Math.Clamp01(num)
    if num < 0 then
        num = 0
    elseif num > 1 then
        num = 1
    end
    return num
end

--- 最近的2的幂
-- 参考: Lua中number边界讨论 http://bbs.csdn.net/topics/390560771?page=1#post-395384266
function Math.ClosestPowerOfTwo(num)
    local index = 0
    for i=index, 53 do
        if num < 2^i then
            index = i
            break
        end
    end

    if index == 0 then
        return 0
    else
        local lastPower = 2^(index-1)
        local nextPower = 2^(index)
        if (num - lastPower) > (nextPower - num) then
            return lastPower
        else
            return nextPower
        end
    end
end

--- Cos
function Math.Cos(rad)
    return math.cos(rad)
end

--- 计算初始角到目标角的最小差值
function Math.DeltaAngle(current, target)
    local num = Math.Repeat(target - current, 360)
    if num > 180 then
        num = num - 360
    end
    return num
end

--- 自然
function Math.Exp(power)
    return 2.71828182846^power
end

--- Returns the largest integer smaller to or equal to f.
function Math.Floor(num)
    return math.floor(num)
end

---  Converts the given value from gamma to linear color space.
function Math.GammaToLinearSpace()
    return 0
end

--- Calculates the Lerp parameter between of two values.
function Math.InverseLerp(from, to, value)
    if from < to then
        if value < from then
            return 0
        end
        if value > to then
            return 1
        end

        value = value - from
        value = value / (to - from)
        return value
    else
        if from <= value then
            return 0
        end
        if to >= value then
            return 1
        end

        value = value - to
        value = value / (from - to)
        return value
    end
end

---  Returns true if the value is power of two.
function Math.IsPowerOfTwo(num)
    -- http://stackoverflow.com/questions/600293/how-to-check-if-a-number-is-a-power-of-2
    return (num ~= 0) and (bit:_and(num, (num - 1)) == 0)
end

---  Interpolates between a and b by t. t is clamped between 0 and 1.
function Math.Lerp(form, to, t)
    return from + (to - from) * Math.Clamp01(t);
end

--- Same as Lerp but makes sure the values interpolate correctly when they wrap around 360 degrees.
function Math.LerpAngle(a, b, t)
  local num = Math.Repeat (b - a, 360)
  if num > 180 then
    num = num - 360
  end
  return a + num * Math.Clamp01 (t);
end

---  Converts the given value from linear to gamma color space.
function Math.LinearToGammaSpace()
    -- TODO 实现LinearToGammaSpace
end

--- Returns the logarithm of a specified number in a specified base.
function Math.Log(num)
    return math.log(num)
end

--- Returns the base 10 logarithm of a specified number.
function Math.Log10(num)
    return math.log10(num)
end

--- Returns largest of two or more values.
function Math.Max(a, ...)
    return math.max(a, ...)
end

--- Returns the smallest of two or more values.
function Math.Min(a, ...)
    return math.min(a, ...)
end

--- Moves a value current towards target.
function Math.MoveTowards(current, target, maxDelta)
    if Math.Abs(target - current) <= maxDelta then
      return target
    end
    return current + Math.Sign (target - current) * maxDelta;
end

---  Same as MoveTowards but makes sure the values interpolate correctly when they wrap around 360 degrees.
function Math.MoveTowardsAngle(current, target, maxDelta)
    target = current + Math.DeltaAngle(current, target)
    return Math.MoveTowards(current, target, maxDelta)
end

---  Returns the next power of two value.
function Math.NextPowerOfTwo(num)
    -- https://github.com/kirilligum/dsalgo-1/blob/master/NextPowerOfTwo.java
    local result = 1;
    while num ~= 0 do
        num = bit:_rshift(num, 1)
        result = bit:_lshift(result, 1)
    end
    return result
end

--- Generate 2D Perlin noise.
function Math.PerlinNoise()
    -- TODO 生成噪点值
end

---  PingPongs the value t, so that it is never larger than length and never smaller than 0.
function Math.PingPong(t, length)
    t = Math.Repeat(t, length * 2)
    return length - Math.Abs(t-length)
end

--- Returns f raised to power p.
function Math.Pow(f, p)
    return f^p
end

--- 循环在数字上减去长度，使它处于[0,length)区间
-- 其实就是浮点数求余运算
function Math.Repeat(num, length)
    return num - Math.Floor(num/length) * length;
end

--- Returns f rounded to the nearest integer.
function Math.Round(num)
    return math.round(num)
end

---  Returns f rounded to the nearest integer.
function Math.RoundToInt(num)
    return math.round(num)
end

---  Returns the sign of f.
function Math.Sign(num)
    return num<0 and -1 or 1
end

--- Returns the sine of angle f in radians.
function Math.Sin(rad)
    return math.sin(rad)
end

---  Gradually changes a value towards a desired goal over time.
function Math.SmoothDamp(current, target, currentVelocity, smoothTime, maxSpeed, deltaTime)
    smoothTime = Math.Max(0.0001, smoothTime)
    local inverseBy2 = 2 / smoothTime
    local percentBy2 = inverseBy2 * deltaTime
    local factorA = 1 / (1 + percentBy2 + 0.48 * percentBy2 * percentBy2 + 0.235 * percentBy2 * percentBy2 * percentBy2)
    local distance = current - target
    local maxMove = maxSpeed * smoothTime
    distance = Math.Clamp (distance, -maxMove, maxMove)
    target = current - distance
    local deltaV = (currentVelocity + inverseBy2 * distance) * deltaTime
    currentVelocity = (currentVelocity - inverseBy2 * deltaV) * factorA
    local newCur = target + (distance + deltaV) * factorA
    if (target - current > 0) == (newCur > target) then
        newCur = target;
        currentVelocity = (newCur - target) / deltaTime;
    end
    return newCur, currentVelocity;
end

--- Gradually changes an angle given in degrees towards a desired goal angle over time.
function Math.SmoothDampAngle(current, target, currentVelocity, smoothTime, maxSpeed, deltaTime)
    target = current + Math.DeltaAngle (current, target)
    return Math.SmoothDamp(current, target, currentVelocity, smoothTime, maxSpeed, deltaTime)
end

---  Interpolates between min and max with smoothing at the limits.
function Math.SmoothStep(from, to, t)
    t = Mathf.Clamp01 (t);
    t = -2 * t * t * t + 3 * t * t;
    return to * t + from * (1 - t);
end

---  Returns square root of f.
function Math.Sqrt(num)
    return math.sqrt(num)
end

--- Returns the tangent of angle f in radians.
function Math.Tan(rad)
    return math.tan(rad)
end

return Math