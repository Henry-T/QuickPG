--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-31 15:50:01
--


-- Quick-x类实现的修改版 支持getter/setter
---[[
function class(classname, super)
    local superType = type(super)
    local cls

    if superType ~= "function" and superType ~= "table" then
        print("!! 进入")
        superType = nil
        super = nil
    end

    if superType == "function" or (super and super.__ctype == 1) then
        print("!! 跳过")
        -- inherited from native C++ Object
        --print("inherite from c++")
        cls = {}

        if superType == "table" then
            print("!! 分支2/1 选择1")
            -- copy fields from super
            for k,v in pairs(super) do cls[k] = v end
            cls.__create = super.__create
            cls.super    = super
        else
            print("!! 分支2/1 选择2")
            cls.__create = super
            cls.ctor = function() end
        end

        cls.__cname = classname
        cls.__ctype = 1

        function cls.new(...)
            local instance = cls.__create(...)
            -- copy fields from class to native object
            for k,v in pairs(cls) do instance[k] = v end
            instance.class = cls
            instance:ctor(...)
            return instance
        end

    else
        print("!! 进入")

        --print("inherite from lua")
        -- inherited from Lua Object
        if super then
            print("!! 跳过")
            cls = {}
            setmetatable(cls, {__index = super})
            cls.super = super
        else
            print("!! 进入")
            cls = {ctor = function() end}
        end

        cls.__cname = classname
        cls.__ctype = 2 -- lua
        cls.__index = cls

        function cls.new(...)
            local instance = setmetatable({}, cls)

            -- dump(cls)
            --if super == nil then
                for i, v in pairs(cls) do
                    instance[i] = v
                end
            --end

            --instance.class = cls
              --  print("测试构造参数 ", cls.__cname, ...)

            instance:ctor(...)
            return instance
        end
    end

    return cls
end
--]]