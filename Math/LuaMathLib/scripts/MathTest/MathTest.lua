--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-30 10:53:05
--


-- Math.Approximately
print("浮点数比较: " .. tostring(1 == 10/10))
print("浮点数近似: " .. tostring(Math.Approximately(1, 10/10)))

print("2的幂检测: 100 ".. tostring(Math.IsPowerOfTwo(100)))
print("2的幂检测: 128 ".. tostring(Math.IsPowerOfTwo(128)))

print("最大值: 2, 32, 4, 45, 1 --", Math.Max(2,32,4,45,1))

print("找到下一个2的幂: 100 " .. tostring(Math.NextPowerOfTwo(100)))


print("PingPong: 10/3 " .. tostring(Math.PingPong(10, 3)))

print("Round: 9.9 " .. tostring(Math.Round(9.9)))

print("符号: -999 " .. tostring(Math.Sign(-999)))