--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-29 17:49:12
--


local c = cc
local Node = c.Node
local Sprite = c.Sprite

function Node:cap(x, y, w, h)
    self:setCapInsets(CCRect(x, y, w, h))
    return self
end

function Node:anchor(x, y)
    self:setAnchorPoint(ccp(x,y))
    return self
end

function Node:color(color)
    self:setColor(color)
    return self
end

function Sprite:texture(path)
    local sharedTextureCache = CCTextureCache:sharedTextureCache()
    local texture = sharedTextureCache:addImage(path)
    self:setTexture(texture)
    return self
end


function display.newSprite(filename, x, y, params)
    local spriteClass = nil
    local size = nil

    if params then
        spriteClass = params.class
        size = params.size
    end
    if not spriteClass then spriteClass = CCSprite end

    local t = type(filename)
    if t == "userdata" then t = tolua.type(filename) end
    local sprite

    if not filename then
        sprite = spriteClass:create()
    elseif t == "string" then
        if string.byte(filename) == 35 then -- first char is #
            local frame = display.newSpriteFrame(string.sub(filename, 2))
            if frame then
                sprite = spriteClass:createWithSpriteFrame(frame)
            end
        else
            if display.TEXTURES_PIXEL_FORMAT[filename] then
                CCTexture2D:setDefaultAlphaPixelFormat(display.TEXTURES_PIXEL_FORMAT[filename])
                sprite = spriteClass:create(filename)
                CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
            else
                local file = io.open("res/"..filename)
                if file then
                    io.close(filename)
                else
                    filename = "default.png"
                end

                sprite = spriteClass:create(filename)
            end
        end
    elseif t == "CCSpriteFrame" then
        sprite = spriteClass:createWithSpriteFrame(filename)
    elseif t == "CCTexture2D" then
        sprite = spriteClass:createWithTexture(filename)
    else
        printError("display.newSprite() - invalid filename value type")
        sprite = spriteClass:create()
    end

    if sprite then
        if x and y then sprite:setPosition(x, y) end
        if size then sprite:setContentSize(size) end
    else
        printError("display.newSprite() - create sprite failure, filename %s", tostring(filename))
        sprite = spriteClass:create()
    end

    return sprite
end