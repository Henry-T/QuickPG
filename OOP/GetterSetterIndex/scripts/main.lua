
function __G__TRACKBACK__(errorMessage)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end

require("config")
require("framework.init")

-- 定义简版 class, 把 Quick-x 的版本覆盖掉
-- function class(classname)
--     local cls = {ctor = function() end}
--     cls.__cname = classname
--     cls.__index = cls

--     function cls.new(...)
--         local instance = setmetatable({}, cls)

--         -- BEGIN 加上这几行就可以了
--         for k,v in pairs(cls) do
--             instance[k] = v
--         end
--         -- END

--         instance:ctor(...)
--         return instance
--     end

--     return cls
-- end

print("===================")
print("Getter/Setter测试")
print("===================")

Sprite = class("Sprite")

function Sprite:ctor(imageSize)
    self._imageSize = imageSize
    self._scale = 1
    self._name = ""
    self._x = 0
end

function Sprite:__newindex( index, value )
    if index == "Name" then
        print("setter - 设置了新的名称: " .. value)
        rawset(self, "_name", value)
    elseif index == "Size" then
        local newScale = value / self._imageSize
        rawset(self, "_scale", newScale)
    elseif index == "Scale" then
        print("setter - 设置Scale: " .. value)
        rawset(self, "_scale", value)
    else
        rawset(self, index, value)
    end
end

function Sprite:__index( index )
    if index == "Name" then
        local name = rawget(self, "_name")
        print("getter - 读取名称: ".. name)
        return name
    elseif index == "Size" then
        local scale = rawget(self, "_scale")
        return scale * self._imageSize
    elseif index == "Scale" then
        return rawget( self, "_scale")
    else
        return rawget( self, index)
    end
end

function Sprite:draw()
    print("\n")
    print("开始绘制精灵: ")
    print("Sprite.Name = " .. self.Name)
    print("Sprite.Size = " .. self.Size)
    print("Sprite.Scale = " .. self._scale.."\n")
end

local sprite = Sprite.new(100)
sprite.Name = "怪兽"
sprite.Size = 1000
sprite:draw()

sprite.Scale = 0.1
sprite:draw()

print("===================")
print("Index/类属性测试")
print("===================")

Vector2 = class("Vector2")

function Vector2:ctor(x, y)
    self.x = x or 0
    self.y = y or 0
end


function Vector2:__tostring()
    return string.format("(%.1f, %.1f)", self.x, self.y)
end

local MetaVector2 = {}

function MetaVector2:__index(index)
    if index == "one" then
        return Vector2.new(1,1)
    else
        return rawget(self, index)
    end
end

setmetatable(Vector2, MetaVector2)

local vec2 = Vector2.one
print("Vector2.one is "..tostring(vec2))