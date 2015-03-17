
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)


GL_LINEAR_MIPMAP_LINEAR       =    0x2703
GL_LINEAR                     =    0x2601
GL_CLAMP_TO_EDGE              =    0x812f
GL_NEAREST                    =    0x2600

function MainScene:ctor()

    function getPos(row, column)
        return 50 + 100 * (column-1), display.height-50-100*(row-1)
    end

    -------------------------------------------
    -- 1 Linear
    -------------------------------------------
    local texParmas1 = ccTexParams()
    texParmas1.magFilter = GL_LINEAR   
    texParmas1.minFilter = GL_LINEAR                
    texParmas1.wrapS = GL_CLAMP_TO_EDGE        
    texParmas1.wrapT = GL_CLAMP_TO_EDGE    

    --- 1-1 原始尺寸
    local img = display.newSprite("camera_dup1.png")
        :pos(getPos(1,1))
        :addTo(self)    
    img:getTexture():setTexParameters(texParmas1)

    --- 1-2 缩小 LINEAR
    local img = display.newSprite("camera_dup1.png")
        :pos(getPos(1,2))
        :scale(0.7)
        :addTo(self)    

    --- 1-3 放大 LINEAR
    local img = display.newSprite("camera_dup1.png")
        :pos(getPos(1,3))
        :scale(1.3)
        :addTo(self)    

    -------------------------------------------
    -- 1 Nearest
    -------------------------------------------
    local texParmas2 = ccTexParams()
    texParmas2.magFilter = GL_NEAREST   
    texParmas2.minFilter = GL_NEAREST                
    texParmas2.wrapS = GL_CLAMP_TO_EDGE        
    texParmas2.wrapT = GL_CLAMP_TO_EDGE    

    --- 2-2 缩小 NEAREST
    local img = display.newSprite("camera_dup2.png")
        :pos(getPos(2,2))
        :scale(0.7)
        :addTo(self)    
    img:getTexture():setTexParameters(texParmas2)


    --- 2-3 放大 NEAREST
    local img = display.newSprite("camera_dup2.png")
        :pos(getPos(2,3))
        :scale(1.3)
        :addTo(self)    




    -- texParmasXXXX.minFilter = GL_LINEAR_MIPMAP_LINEAR 
end

function MainScene:onEnter()

end

function MainScene:onExit()
end

return MainScene
