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

--local matrix = Matrix:new()
--matrix.X = 100
--print(matrix.X)


--[[

-- # 原理测试
MyClass = {}

function MyClass:__newindex( index, value )
    if index == "testMember" then
        self.members[index] = value
        print( "Set member " .. index .. " to " .. value )
    else
        rawset( self, index, value )
    end
end

function MyClass:__index( index )
    if index == "testMember" then
        print( "Getting " .. index )
        return self.members[index]
    else
        return rawget( self, index )
    end
end

local instance = {
    members = {}
}
setmetatable(instance, MyClass)


instance.testMember = 100
print(instance.testMember)
--]]



-- # Quick-x实现
local MyClass = class("MyClass", function() return display.newSprite() end)

function MyClass:ctor()
    print("构造")
end

function MyClass:__newindex( index, value )
    if index == "testMember" then
        self.members[index] = value
        print( "Set member " .. index .. " to " .. value )
    else
        rawset( self, index, value )
    end
end

function MyClass:__index( index )
    if index == "testMember" then
        print( "Getting " .. index )
        return self.members[index]
    else
        return rawget( self, index )
    end
end

local instance = MyClass.new()
instance.testMember = 100
print(instance.testMember)

print("测试结束")

--[[
-- # Codea的实现
function Class(base)
    local c = {}    -- a new class instance
    if type(base) == 'table' then
        -- our new class is a shallow copy of the base class!
        for i,v in pairs(base) do
            c[i] = v
        end
        c._base = base
    end

    -- the class will be the metatable for all its objects,
    -- and they will look up their methods in it.
    c.__index = c

    -- expose a constructor which can be called by <classname>(<args>)
    local mt = {}
    mt.__call = function(class_tbl, ...)
        local obj = {}
        setmetatable(obj,c)
        if class_tbl.init then
            class_tbl.init(obj,...)
        else 
            -- make sure that any stuff from the base class is initialized!
            if base and base.init then
                base.init(obj, ...)
            end
        end
        
        return obj
    end

    c.is_a = function(self, klass)
        local m = getmetatable(self)
        while m do 
            if m == klass then return true end
            m = m._base
        end
        return false
    end

    setmetatable(c, mt)
    return c
end



MyClass = Class()

function MyClass:init()
    -- We'll store members in an internal table
    self.members = {}
end

function MyClass:__newindex( index, value )
    if index == "testMember" then
        self.members[index] = value
        print( "Set member " .. index .. " to " .. value )
    else
        rawset( self, index, value )
    end
end

function MyClass:__index( index )
    if index == "testMember" then
        print( "Getting " .. index )
        return self.members[index]
    else
        return rawget( self, index )
    end
end


local foo = MyClass()

    foo.testMember = 5
    foo.testMember = 2

    print( foo.testMember )

--]]