
DEBUG = 2
DEBUG_FPS = true

CONFIG_SCREEN_WIDTH  = 480
CONFIG_SCREEN_HEIGHT = 320
CONFIG_SCREEN_AUTOSCALE = "FIXED_HEIGHT"

-- 添加资源搜索路径
local fileutils = CCFileUtils:sharedFileUtils()
fileutils:addSearchPath("res/")
fileutils:addSearchPath("res/SimpleGUI/")

-- 还是先加载下吧，随后移除掉好了
--CCLuaLoadChunksFromZIP("framework_precompiled.zip")
require("framework.init")

-- avoid memory leak
collectgarbage("setpause", 100)
collectgarbage("setstepmul", 5000)
  
Test_UILayout_Absolute    = require "LayoutTest/Test_UILayout_Absolute"
Test_UILayout_Relative    = require "LayoutTest/Test_UILayout_Relative"
Test_UILayout_Horizontal  = require "LayoutTest/Test_UILayout_Horizontal"
Test_UILayout_Vertical    = require "LayoutTest/Test_UILayout_Vertical"
ScrollView_Slider    = require "Container/ScrollView_Slider"
TrimLabelTest = require "LayoutTest/TrimLabelTest"

-- CCDirector:sharedDirector():runWithScene(Test_UILayout_Vertical.Create())

-- CCDirector:sharedDirector():runWithScene(ScrollView_Slider:new())

CCDirector:sharedDirector():runWithScene(TrimLabelTest:new())
