
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    ui.newTTFLabel({text = "Hello, World", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self)
end

function MainScene:onEnter()
    self:startPostReq()
end

function MainScene:onExit()
end

function MainScene:startGetReq()
    local url = "http://www.lolofinil.com"
    local request = network.createHTTPRequest(function(event)
        self:onResponseGet(event)
    end, url, "GET")
    request:setTimeout(30)
    request:start() 
end

function MainScene:onResponseGet(event)
    local request = event.request
    if event.name ~= "completed" then
        print("request:getErrorCode(), request:getErrorMessage() ", request:getErrorCode(), request:getErrorMessage())
        return
    end
    local code = request:getResponseStatusCode()
    -- 其他状态码
    -- 200 - 服务器成功返回网页
    -- 404 - 请求的网页不存在
    -- 503 - 服务器暂时不可用

    if code ~= 200 then -- 成功
        print("code ", code)
        return 
    end
     
    local strResponse = string.trim(request:getResponseString())
    print(strResponse)
end

function MainScene:startPostReq()
    local url = "http://httpbin.org/post"
    local request = network.createHTTPRequest(function(event)
        self:onResponsePost(event)
    end, url, "POST")

    request:addPOSTValue("key", "value")
    --request:setRequestData("key=value");
    --request:setTag("POST test1");

    request:setTimeout(30)
    request:start()
end

function MainScene:onResponsePost(event)
    local request = event.request
    if event.name ~= "completed" then
        print("request:getErrorCode(), request:getErrorMessage() ", request:getErrorCode(), request:getErrorMessage())
        return
    end
    local code = request:getResponseStatusCode()
    if code ~= 200 then -- 成功
        print("code ", code)
        return 
    end
     
    local strResponse = string.trim(request:getResponseString())
    print(strResponse)
end

return MainScene
