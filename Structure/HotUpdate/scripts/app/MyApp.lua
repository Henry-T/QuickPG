
require("config")
package.path = package.path .. ";../../../?.lua"
require("frameworkClone.init")
require("Object")
require("app.utils.QuickExt")

local MyApp = class("MyApp", cc.mvc.AppBase)


function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    self:enterScene("MainScene")

end

return MyApp
