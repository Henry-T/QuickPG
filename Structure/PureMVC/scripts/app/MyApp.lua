
require("config")
require("framework.init")


-- 包含公共库
local curPath = debug.getinfo(1).source   -- E:/proj/QuickPG_bitbucket/Structure/PureMVC/scripts/app/MyApp.lua

local indexs = {}
local i = 0
while true do 
	i = string.find(curPath, "/", i+1)
	if i==nil then break end
	indexs[#indexs+1] = i
end

if #indexs > 5 then
	local index = indexs[#indexs-4]
	local libPath = string.sub(curPath, 1, index).."Library/?.lua"
	package.path = package.path .. ' ;'..libPath	
end

local ApplicationFacade = require("app.ApplicationFacade")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)

    self._facade = ApplicationFacade.Instance()
end

function MyApp:run()

	-- CCFileUtils:sharedFileUtils():addSearchPath("res/")
 --    self:enterScene("MainScene")

    
end

return MyApp
