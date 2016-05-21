--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-30 10:31:23
--

local Math = {}

--- [[常量]]
--- PI
Math.PI = 3.14159274

--- 角度转弧度系数
Math.Deg2Rad = 0.0174532924

--- 弧度转角度系数
Math.Rad2Deg = 57.29578

--- 极小数,自然对数底
Math.Epsilon = math.exp(1)      --指数为1时返回值就是e

--- 正无穷
Math.Infinity = math.huge

--- 负无穷
Math.NegativeInfinity = -math.huge

--- 取绝对值
function Math.Abs(num)
    if num > 0 then
        return num
    else
        return -num
    end
end

--- 是否近似相等
function Math.Approximately(a, b)
    return Math.Abs (b - a) < Math.Max (1E-05 * Math.Max (Math.Abs (a), Math.Abs (b)), 1.121039E-44);
end

--- [[三角函数]]
--- Cos
function Math.Cos(rad)
    return math.cos(rad)
end

---  Returns the arc-sine of f - the angle in radians whose sine is f.
function Math.Asin(sinOfRad)
    return math.asin(sinOfRad)
end

--- 反余弦获得弧度
function Math.Acos(cosOfRad)
    return math.acos(cosOfRad)
end

--- 反正切获得弧度
function Math.Atan(tanOfRad)
    return math.atan(tanOfRad)
end

--- 反正切获得弧度
function Math.Atan2(y, x)
    return math.atan2(y, x)
end

--- 大于参数的最小整数
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
function Math.ClosestPowerOfTwo(num)
    -- 参考: Lua中number边界讨论 http://bbs.csdn.net/topics/390560771?page=1#post-395384266
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

--- Converts the given value from gamma to linear color space.
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

--- 大于参数的最小2的幂
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

--- PingPongs the value t, so that it is never larger than length and never smaller than 0.
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
    local inverseTTBy2 = 4 / smoothTime       -- NOTE Unity中分子为2 但改为4才正确，原因不明
    local percentX2 = inverseTTBy2 * deltaTime
    local factorA = 1 / (1 + percentX2 + 0.48 * percentX2 * percentX2 + 0.235 * percentX2 * percentX2 * percentX2)
    local distanceVV = current - target
    local maxMove = maxSpeed * smoothTime
    distanceVV = Math.Clamp (distanceVV, -maxMove, maxMove)
    local fixTarget = current - distanceVV
    local dDis = (currentVelocity + inverseTTBy2 * distanceVV) * deltaTime
    currentVelocity = (currentVelocity - inverseTTBy2 * dDis) * factorA
    local newCur = fixTarget + (distanceVV + dDis) * factorA
    if (fixTarget > current) == (newCur > fixTarget) then
        newCur = fixTarget
        currentVelocity = (newCur - fixTarget) / deltaTime;
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