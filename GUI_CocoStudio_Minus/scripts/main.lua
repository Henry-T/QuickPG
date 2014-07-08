
DEBUG = 2
DEBUG_FPS = true

CONFIG_SCREEN_WIDTH  = 960
CONFIG_SCREEN_HEIGHT = 640
CONFIG_SCREEN_AUTOSCALE = "FIXED_HEIGHT"

-- set serach paths
local fileutils = CCFileUtils:sharedFileUtils()
fileutils:addSearchPath("res/")
fileutils:addSearchPath("res/scenetest/UIComponentTest/")

-- load framework
--CCLuaLoadChunksFromZIP("framework_precompiled.zip")
require("framework.init")

-- avoid memory leak
collectgarbage("setpause", 100) 
collectgarbage("setstepmul", 5000)
  
require "CocoStudioGUITest"
----------------

startOnCocosGUITestScene()
