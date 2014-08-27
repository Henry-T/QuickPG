--
-- Author: tanghongyang@apowo.com
-- Date: 2014-08-25 15:10:29
--

-- Wrap up for quick-x apis to handle hd/sd assets automatically
-- no need to care about retina any more

--- Note
-- display.newTilesSprite not supported!

-- Node.scale is mapped because in cocos2d-x the scale will influence size of a node, 
-- and size of a node will influence its children

local HDSandBox = {
}

-- note set right cap rectangle for HD images
-- TODO support TurnOff
local c = cc
local Node = c.Node

-- a node extension without HD handling
function Node:cap(x, y, w, h)
    self:setCapInsets(CCRect(x, y, w, h))
    return self
end

-- factory function for CCLabelAtlas (HD incompatible version)
function ui.newLabelAtlas(text, charImage, charWidth, charHeight, byteOfStartChar)
    return CCLabelAtlas:create(text, charImage, charWidth, charHeight, byteOfStartChar)
end

function HDSandBox:TurnOn()
    -- wrap up can cache all the relative quick-x apis

    -- Node.Scale
    quick_node_scale = Node.scale
    Node.scale = HDSandBox.node_scale

    quick_node_cap = Node.cap
    Node.cap = HDSandBox.node_cap

    quick_node_size = Node.size
    Node.size = HDSandBox.node_size

    -- Image/Asset comes with Image
    quick_display_newSprite = display.newSprite
    display.newSprite = HDSandBox.display_newSprite

    quick_display_newScale9Sprite = display.newScale9Sprite
    display.newScale9Sprite = HDSandBox.display_newScale9Sprite

    quick_display_newTilesSprite = display.newTilesSprite
    display.newTilesSprite = HDSandBox.display_newTilesSprite

    quick_display_newTiledBatchNode = display.newTiledBatchNode
    display.newTiledBatchNode = HDSandBox.display_newTiledBatchNode

    quick_display_newMaskedSprite = display.newMaskedSprite
    display.newMaskedSprite = HDSandBox.display_newMaskedSprite

    quick_display_newFilteredSprite = display.newFilteredSprite
    display.newFilteredSprite = HDSandBox.display_newFilteredSprite

    quick_display_newGraySprite = display.newGraySprite
    display.newGraySprite = HDSandBox.display_newGraySprite

    quick_display_addImageAsync = display.addImageAsync
    display.addImageAsync = HDSandBox.display_addImageAsync

    quick_display_addSpriteFramesWithFile = display.addSpriteFramesWithFile
    display.addSpriteFramesWithFile = HDSandBox.display_addSpriteFramesWithFile

    quick_display_removeSpriteFramesWithFile = display.removeSpriteFramesWithFile
    display.removeSpriteFramesWithFile = HDSandBox.display_removeSpriteFramesWithFile


    quick_display_setTexturePixelFormat = display.setTexturePixelFormat
    display.setTexturePixelFormat = HDSandBox.display_setTexturePixelFormat


    quick_display_removeSpriteFrameByImageName = display.removeSpriteFrameByImageName
    display.removeSpriteFrameByImageName = HDSandBox.display_removeSpriteFrameByImageName


    quick_display_newBatchNode = display.newBatchNode
    display.newBatchNode = HDSandBox.display_newBatchNode


    quick_display_newSpriteFrame = display.newSpriteFrame
    display.newSpriteFrame = HDSandBox.display_newSpriteFrame


    quick_display_newFrames = display.newFrames
    display.newFrames = HDSandBox.display_newFrames

    quick_display_newProgressTimer = display.newProgressTimer
    display.newProgressTimer = HDSandBox.display_newProgressTimer

    quick_ui_newTTFLabel = ui.newTTFLabel
    ui.newTTFLabel = HDSandBox.ui_newTTFLabel

    quick_ui_newBMFontLabel = ui.newBMFontLabel
    ui.newBMFontLabel = HDSandBox.ui_newBMFontLabel

    quick_ui_newLabelAtlas = ui.newLabelAtlas
    ui.newLabelAtlas = HDSandBox.ui_newLabelAtlas
end

--- Just in case you want to disable the auto fit for a special graphics objects
-- You can 
function HDSandBox:TurnOff()
    -- restore quick-x apis

    -- Node.scale
    Node.scale = quick_node_scale

    Node.cap = quick_node_cap 

    Node.size = quick_node_size


    -- Image/Asset comes with Image
    display.newSprite = quick_display_newSprite

    display.newScale9Sprite = quick_display_newScale9Sprite

    display.newTilesSprite = quick_display_newTilesSprite

    display.newTiledBatchNode = quick_display_newTiledBatchNode

    display.newMaskedSprite = quick_display_newMaskedSprite

    display.newFilteredSprite = quick_display_newFilteredSprite

    display.newGraySprite = quick_display_newGraySprite

    display.addImageAsync = quick_display_addImageAsync

    display.addSpriteFramesWithFile = quick_display_addSpriteFramesWithFile

    display.removeSpriteFramesWithFile = quick_display_removeSpriteFramesWithFile

    display.setTexturePixelFormat = quick_display_setTexturePixelFormat

    display.removeSpriteFrameByImageName = quick_display_removeSpriteFrameByImageName

    display.newBatchNode = quick_display_newBatchNode

    display.newSpriteFrame = quick_display_newSpriteFrame

    display.newFrames = quick_display_newFrames

    display.newProgressTimer = quick_display_newProgressTimer

    ui.newTTFLabel = quick_ui_newTTFLabel

    ui.newBMFontLabel = quick_ui_newBMFontLabel

    ui.newLabelAtlas = quick_ui_newLabelAtlas
end


function HDSandBox.WrapPathWithRes(path)
    local head = path:sub(1, 3)
    if head == "hd/" or head == "sd/" then
        return path
    end

    if HD_RES then
        path = "hd/" .. path
    else
        path = "sd/" .. path
    end
    return path 
end

function HDSandBox.node_cap(node, x, y, w, h)
    if HD_RES then
        x, y, w, h = 2*x, 2*y, 2*w, 2*h
    end
    return quick_node_cap(node, x, y, w, h)
end

function HDSandBox.node_scale(node, scale)
    if HD_RES then
        scale = 0.5 * scale
    end
    return quick_node_scale(node, scale)
end

function HDSandBox.node_size(node, w, h)
    if HD_RES and tolua.type(node) == "CCScale9Sprite" then
    -- TODO 找出Scale9这个差异的原因
        w, h = 2*w, 2*h
    end
    return quick_node_size(node, w, h)
end


function HDSandBox.display_newSprite(filename, x, y, params)
    filename = HDSandBox.WrapPathWithRes(filename)

    local sprite = quick_display_newSprite(filename, x, y, params)
    sprite:scale(1)   -- make sure the HD sprite in right size

    return sprite
end

function HDSandBox.display_newScale9Sprite(filename, x, y, size)
    if HD_RES and size then
        size.width = size.width * 2
        size.height = size.height * 2
    end
    local sprite = quick_display_newScale9Sprite(filename, x, y, size)
    -- NOTE not need to map Size because SD/HD share the same design resolution
    -- TODO something wrong here !
    return sprite
end

function HDSandBox.display_newTilesSprite(filename, rect)
    filename = HDSandBox.WrapPathWithRes(filename)
    return quick_display_newTilesSprite(filename, rect)
end

function HDSandBox.display_newTiledBatchNode(filename, plistFile, size, hPadding, vPadding)
    filename = HDSandBox.WrapPathWithRes(filename)
    plistFile = HDSandBox.WrapPathWithRes(plistFile)
    return  quick_display_newTiledBatchNode(filename, plistFile, size, hPadding, vPadding)
end

function HDSandBox.display_newMaskedSprite(__mask, __pic)
    local sprite = quick_display_newMaskedSprite(__mask, __pic)
    sprite:scale(1)
    return sprite
end

function HDSandBox.display_newFilteredSprite(filename, filters, params)
    local sprite = quick_display_newFilteredSprite(filename, filters, params)
    sprite:scale(1)
    return sprite
end

function HDSandBox.display_newGraySprite(filename, params)
    return quick_display_newFilteredSprite(filename, params)
end

function HDSandBox.display_addImageAsync(imagePath, callback)
    imagePath = HDSandBox.WrapPathWithRes(imagePath)
    quick_display_addImageAsync(imagePath, callback)
end

function HDSandBox.display_addSpriteFramesWithFile(plistFilename, image, handler)
    plistFilename = HDSandBox.WrapPathWithRes(plistFilename)
    return quick_display_addSpriteFramesWithFile(plistFilename, image, handler)
end

function HDSandBox.display_removeSpriteFramesWithFile(plistFilename, imageName)
    plistFilename = HDSandBox.WrapPathWithRes(plistFilename)
    return quick_display_removeSpriteFramesWithFile(
        HDSandBox.WrapPathWithRes(plistFilename),
        imageName)
end

function HDSandBox.display_setTexturePixelFormat(filename, format)
    filename = HDSandBox.WrapPathWithRes(filename)
    quick_display_setTexturePixelFormat(filename);
end

function HDSandBox.display_removeSpriteFrameByImageName(imageName)
    imageName = HDSandBox.WrapPathWithRes(imageName)
    quick_display_removeSpriteFrameByImageName(imageName);

end

function HDSandBox.display_newBatchNode(image, capacity)
    image = HDSandBox.WrapPathWithRes(image)
    local sprite = quick_display_display_newBatchNode(imageName);
    sprite:scale(1)
    return sprite
end

function HDSandBox.display_newSpriteFrame(frameName)
    frameName = HDSandBox.WrapPathWithRes(frameName)
    return quick_display_newSpriteFrame(frameName);
end

function HDSandBox.display_newFrames(pattern, begin, length, isReversed)
    pattern = HDSandBox.WrapPathWithRes(pattern)
    return quick_display_newFrames(pattern, begin, length, isReversed)
end

function HDSandBox.display_newProgressTimer(image, progressType)
    local pt = quick_display_newProgressTimer(image, progressType)
    pt:scale(1)
    return pt
end

function HDSandBox.ui_newTTFLabel(params)
    -- NOTE TTF字体Size已经是适配分辨率的
    if HD_RES and params.size~=nil then
        params.size = 1 * params.size
    end
    return quick_ui_newTTFLabel(params)
end

function HDSandBox.ui_newBMFontLabel(params)
    params.font = HDSandBox.WrapPathWithRes(params.font)
    local lbBmFont = quick_ui_newBMFontLabel(params)
    lbBmFont:scale(1)
    return lbBmFont
end

function HDSandBox.ui_newLabelAtlas(text, charImage, charWidth, charHeight, byteOfStartChar)
    charImage = HDSandBox.WrapPathWithRes(charImage)
    local labelAtlas = CCLabelAtlas:create(text, charImage, charWidth * 2, charHeight * 2, byteOfStartChar)
    print("Label Atlas created!")
    labelAtlas:scale(1)
    return labelAtlas
end

return HDSandBox
