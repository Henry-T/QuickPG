
require("config")
require("frameworkClone.init")

require("app.utils.QuickExt")

require("app.data.CompanyData")


viewPipe = require("app.ViewPipeline.ViewPipeline").new()

companyData = CompanyData.new()

local MyApp = class("MyApp", cc.mvc.AppBase)


function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    -- self:enterScene("MainScene")
    self:enterScene("ViewPipeTestScene")

    
end

return MyApp
