--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-30 10:31:29
--

local Vector3 = class("Vector3")

Vector3.kEpsilon = 1e-5

function Vector3:ctor()
    self.x = 0
    self.y = 0
    self.z = 0
end

function Vector3.forward()
    local vec3 = Vector3:new()
    vec3.x = 0
    vec3.y = 0
    vec3.z = 1
    return vec3
end

function Vector3.back()
    local vec3 = Vector3:new()
    vec3.x = 0
    vec3.y = 0
    vec3.z = -1
    return vec3
end

function Vector3.up()
    local vec3 = Vector3:new()
    vec3.x = 0
    vec3.y = 1
    vec3.z = 0
    return vec3
end

function Vector3.down()
    local vec3 = Vector3:new()
    vec3.x = 0
    vec3.y = -1
    vec3.z = 0
    return vec3
end

function Vector3.right()
    local vec3 = Vector3:new()
    vec3.x = 1
    vec3.y = 0
    vec3.z = 0
    return vec3
end

function Vector3.left()
    local vec3 = Vector3:new()
    vec3.x = -1
    vec3.y = 0
    vec3.z = 0
    return vec3
end

function Vector3.one()
    local vec3 = Vector3:new()
    vec3.x = 1
    vec3.y = 1
    vec3.z = 1
    return vec3
end

function Vector3.zero()
    local vec3 = Vector3:new()
    vec3.x = 0
    vec3.y = 0
    vec3.z = 0
    return vec3
end

-- TODO 改为getter
function Vector3:magnitude()
    Math.Sqrt(self.x*self.x, self.y*self.y, self.z*self.z)
end

-- TODO 改为getter
function Vector3:normalize()
    
end

return Vector3