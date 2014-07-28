
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
  
----------------

require "app.gui.GUIEnum"

-- GUI Class Define
PanelManager      = require "app.gui.PanelManager"

PanelTestMailNotice = require "app.gui.panel.PanelTestMailNotice"
PanelMailBox      = require "app.gui.panel.PanelMailBox"
PanelMailContent  = require "app.gui.panel.PanelMailContent"
PanelMailDetail  = require "app.gui.panel.PanelMailDetail"


WidgetMailBoxItem = require "app.gui.widget.WidgetMailBoxItem"

-- Data Class Define
DataMail = require "app.data.mail.DataMail"

-- Start
PanelManager.StartRootPanel(PanelTestMailNotice.create())
