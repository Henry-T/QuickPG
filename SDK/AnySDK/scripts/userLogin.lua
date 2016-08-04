--
-- Author: hanxu
-- Date: 2015-06-16 15:59:00
--

userLogin = {}

local function onUserResult( plugin, code, msg)
    print("=================on user action listener.================")
    print("code:"..code..",msg:"..msg)
    if code == UserActionResultCode.kInitSuccess then
        print("================UserActionResultCode.kInitSuccess======================")
    elseif code == UserActionResultCode.kInitFail then
        print("loginplugin InitFail==================")
    elseif code == UserActionResultCode.kLoginSuccess then
        -- code:2,msg:{"_token":{"uid":"139477183","time":1434449991,"token":"203f6ed22a7c82245699560572a951c5"}}
        print("=============", msg)
        local data = json.decode(msg)
        globalVariable:addVariable("anysdkUserData", data["_token"])
        dump(data["_token"])
        userLogin.onLoginResult(true, data["_token"])
    elseif code == UserActionResultCode.kLoginNetworkError then
        userLogin.onLoginResult(false, "登录时出现网络错误")
    elseif code == UserActionResultCode.kLoginNoNeed then
        userLogin.onLoginResult(false, "无需登录")
    elseif code == UserActionResultCode.kLoginFail then
        print("loginplugin InitFail==================")
        userLogin.onLoginResult(false, "登录失败")
    elseif code == UserActionResultCode.kLoginCancel then
        userLogin.onLoginResult(false, "登录取消")
    elseif code == UserActionResultCode.kLogoutSuccess then
        print("restart app on logout success")
        anySDK:restartApp()
    elseif code == UserActionResultCode.kLogoutFail then
        --do
    elseif code == UserActionResultCode.kSessionInvalid then
        print("restart app on session invalid")
        anySDK:restartApp()
    elseif code == UserActionResultCode.kPlatformEnter then
        --do
    elseif code == UserActionResultCode.kPlatformBack then
        --do
    elseif code == UserActionResultCode.kPausePage then
        --do
    elseif code == UserActionResultCode.kExitPage then
        print("exit on kExitPage")
        shutdownAPP()
    elseif code == UserActionResultCode.kAntiAddictionQuery then
        --do
    elseif code == UserActionResultCode.kRealNameRegister then
        --do
    elseif code == UserActionResultCode.kAccountSwitchSuccess then
        print("restart app on account switch success")
        anySDK:restartApp()
    elseif code == UserActionResultCode.kAccountSwitchFail then
        --do
    elseif code == UserActionResultCode.kOpenShop then
        --do
    end
end

function userLogin.init()
    print("userLogin.init() called")
    if anysdkAgent then
        user_plugin = anysdkAgent:getUserPlugin()
        if user_plugin ~= nil then
            user_plugin:setActionListener(onUserResult)
        end
    end
end

function userLogin.login(onLoginResult)
    print("userLogin.login() called")
    userLogin.onLoginResult = onLoginResult
    if user_plugin ~= nil then
        user_plugin:login()
    end
end

function userLogin.showToolBar()
    if nil ~= user_plugin and user_plugin:isFunctionSupported("showToolBar")  then
        local param1 = PluginParam:create(ToolBarPlace.kToolBarTopLeft)
        user_plugin:callFuncWithParam("showToolBar", param1)
    end
end

--- 加载登录前的渠道公告
function userLogin.getAnnouncementInfoBeforeLogin()
    if nil ~= user_plugin and user_plugin:isFunctionSupported("getAnnouncementInfo")  then
        user_plugin:callFuncWithParam("getAnnouncementInfo")
    end
end

--- 平台是否支持退出
function userLogin.supportExit()
    return user_plugin~=nil and user_plugin:isFunctionSupported("exit")
end

--- 平台的退出接口
function userLogin.exit()
    if nil ~= user_plugin and user_plugin:isFunctionSupported("exit") then
        user_plugin:callFuncWithParam("exit");
    end
end

---
-- @eventType 1进入游戏 2创建角色 3角色升级 4退出
function userLogin:submitLoginGameRole(eventType)
    if user_plugin~=nil and user_plugin:isFunctionSupported("submitLoginGameRole") then
        local userInfo = {}
        if userManager and userManager:getMe() then
            userInfo["roleId"] = userManager:getMe():id()
            userInfo["roleName"] = userManager:getMe():name()
            userInfo["roleLevel"] = userManager:getMe():lv()
            userInfo["zoneId"] = userManager:serverID()
            userInfo["zoneName"] = serverManager:curServerData():name()
            userInfo["dataType"] = eventType
            userInfo["balance"] = userManager:getMe():dollar()
            userInfo["partyName"] = ""
            userInfo["vipLevel"] = userManager:getMe():vipLv();
            userInfo["roleCTime"] = userManager:getMe():createTime() -- todo 改成服务器创角时间
            userInfo["roleLevelMTime"] = eventType==3 and os.time() or -1
            local pluginParamsData = PluginParam:create(userInfo);
            user_plugin:callFuncWithParam("submitLoginGameRole", pluginParamsData);
        else 
            print("userLogin:submitLoginGameRole failed userManager or role is nil")
        end
    end
end

return userLogin