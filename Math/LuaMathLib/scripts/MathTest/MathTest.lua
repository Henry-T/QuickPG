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
-- # 基础测试 meta中的__index与函数是否冲突?
local ClassMeta = {}

ClassMeta.__index = ClassMeta

function ClassMeta:ctor()
    print("ctor")
end

local instance = {}
setmetatable(instance, ClassMeta)
instance:ctor()

--]]


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



--[[
-- # Quick-x实现
-- ## 修改过Quick-x的framework可以实现
--  
--  function cls.new(...)
--     local instance = setmetatable({}, cls)
--     for i, v in pairs(cls) do
--         instance[i] = v
--     end
--     instance.class = cls
--     instance:ctor(...)
--     return instance
--  end
--
Sprite = class("Sprite")

function Sprite:ctor(imageSize)
    self._imageSize = imageSize
    self._scale = 1
    self._name = ""
    self._x = 0
end

function Sprite:__newindex( index, value )
    if index == "Name" then
        print("internal - 设置了新的名称: " .. value)
        rawset(self, "_name", value)
    elseif index == "Size" then
        local newScale = value / self._imageSize
        rawset(self, "_scale", newScale)
    elseif index == "Scale" then
        print("internal - 设置Scale: " .. value)
        rawset(self, "_scale", value)
    elseif index == 1 then
        rawset(self, "_x", value)
    else
        rawset(self, index, value)
    end
end

function Sprite:__index( index )
    if index == "Name" then
        local name = rawget(self, "_name")
        print("internal - 读取名称: ".. name)
        return name
    elseif index == "Size" then
        local scale = rawget(self, "_scale")
        return scale * self._imageSize
    elseif index == "Scale" then
        return rawget( self, "_scale")
    elseif index == 1 then
        return rawget( self, "_x")
    else
        return rawget( self, index)
    end
end

function Sprite:draw()
    print("绘制了一张精灵: ")
    print("Name : " .. self.Name)
    print("Size : " .. self.Size)
    print("Scale: " .. self._scale)
end

local sprite = Sprite.new(100)
sprite.Name = "背景图片"
sprite.Size = 1000
sprite:draw()

sprite.Scale = 0.1
sprite:draw()

sprite[1] = 99.99
print(sprite[1])

print("测试结束")
--]]

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

        -- 改进 Begin
        for i, v in pairs(class_tbl) do
            obj[i] = v
        end

        -- 改进 End

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
    print("init!")
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

function MyClass:Foo()
    print("foo! " .. self.testMember)
end

local foo = MyClass()

foo.testMember = 5
foo.testMember = 2

print( foo.testMember )
-- MyClass.Foo(foo)
foo:Foo()


--]]