--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-12 17:22:07
--

local SlimeNode = class("SlimeNode")

function SlimeNode:ctor(pos, normal)
    self.Position = pos or Vector3.zero        -- 位置
    self.Normal = normal or Vector3.one       -- 法线
end

return SlimeNode