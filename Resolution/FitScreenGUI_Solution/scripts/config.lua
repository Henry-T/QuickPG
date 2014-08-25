
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 1

-- display FPS stats on screen
DEBUG_FPS = true

-- dump memory info every 10 seconds
DEBUG_MEM = false

-- load deprecated API
LOAD_DEPRECATED_API = false

-- load shortcodes API
LOAD_SHORTCODES_API = true

-- screen orientation
CONFIG_SCREEN_ORIENTATION = "landscape"

-- design resolution
CONFIG_SCREEN_WIDTH  = 960
CONFIG_SCREEN_HEIGHT = 640

-- auto scale mode
CONFIG_SCREEN_AUTOSCALE = "FIXED_HEIGHT"

HD_RES = false

CONFIG_SCREEN_AUTOSCALE_CALLBACK = function(w, h, deviceModel)
    if h == 1536 and w == 2048 then
        HD_RES = true
        CONFIG_SCREEN_WIDTH = 853.33
        CONFIG_SCREEN_HEIGHT = 640
        return 1.0, 1.0
    end
end
