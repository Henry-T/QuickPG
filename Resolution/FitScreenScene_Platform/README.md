自适应屏幕的横版游戏场景

设计分辨率: 640 × 960

Landscape - FIXED_HEIGHT 高度基准

换算公式:

可视区域.h = 设计分辨率.h
缩放比 = 屏幕分辨率.h / 设计分辨率.h
可视区域.w = 屏幕分辨率.w / 缩放比
无效边距 = (可视区域.w - 设计分辨率.w) / 2

缩放比:      display.contentScaleFactor
屏幕分辨率:  display.widthInPixels, display.heightInPixels
可视区域:    display.width, display.height
安全区域:    display.safeLeft, display.safeTop, display.safeRight, display.safeBottom


设备    屏幕分辨率    可视区域      放缩      无效边距
        480 x 800     640 x 1066.67   0.75      53.335
        480 x 854     640 x 1138.67   0.75      89.335
iPad    640 x 853     640 x 853       1                 (不支持)
        640 x 960     640 x 960       1
        640 x 1136    640 x 1136      1
        768 x 1024    640 x 853.33    1.2

