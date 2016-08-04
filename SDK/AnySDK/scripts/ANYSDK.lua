--
-- Author: tanghongyang@apowo.com
-- Date: 2016-04-21 20:04:42
--

require "anysdkConst"

local ANYSDK = {}

--- 初始化函数
function ANYSDK:initialize()
	if (device.platform == "android" or device.platform == "ios") and ENABLE_UNIFY_SDK then
		local appKey = "0DBF45D2-B6C0-CCC6-36AB-7A12D34028EB"
		local appSecret = "75d6e06f15b016e37c47d48bb35d46fe"
		local privateKey = "0F244E286BE027C3DD41E77270411CEA"
		local oauthLoginServer = "http://sanguo.apowogame.com/account/verifyuser/anysdk"
		-- local oauthLoginServer = "http://oauth.anysdk.com/api/OauthLoginDemo/Login.php"
		-- global anysdkAgent
		anysdkAgent = AgentManager:getInstance()
		anysdkAgent:init(appKey,appSecret,privateKey,oauthLoginServer)
		anysdkAgent:loadAllPlugins()

		-- anysdkAgent:setIsAnaylticsEnabled(true)
		require("app.anysdk.userLogin").init()

		self._channelName = anysdkAgent:getCustomParam();
		if self._channelName == nil or self._channelName=="" then
			print("ANYSDK 自定义参数(用作ChannelName) 未配置, 采用默认channel: "..DEFAULT_CHANNEL_NAME)
			self._channelName = DEFAULT_CHANNEL_NAME
		end

		if self._channelName == "appstore" then
			apowoAccountAS = require("app.platform.ApowoAccountAS")
			apowoAccountAS:init()
		elseif device.platform == "ios" then
			-- 目前ApowoAccount(iOS)是直接嵌入项目的，因此默认启用它便与测试
			apowoAccountAS = require("app.platform.ApowoAccountAS")
			apowoAccountAS:init()
		end

		-- 一些Java层参数
		local ok = true
		if device.platform == "android" then
			ok, self._androidAppInfoJsonStr = tryCallStaticJavaMethod("com/apowo/projects/Projects", "GetAppInfoJson", {}, "()Ljava/lang/String;")
			if not ok then
				print("ERROR 初始化失败: JNI调用GetAppInfoJson失败")
			else
				local jsonTbl = jsonDecode(self._androidAppInfoJsonStr)
				if not jsonTbl then
					print("ERROR 初始化时 json解析GetAppInfoJson返回值失败 <str>", self._androidAppInfoJsonStr)
				else
					self._Package_VersionName = jsonTbl.Package_VersionName
					self._Package_VersionCode = jsonTbl.Package_VersionCode
				end
			end
		else
			-- TODO thy get ios bundle version
			self._Package_VersionName = "1.0"
			self._Package_VersionCode = 1
		end
	else
		self._channelName = GSDK_ChannelName
		self._Package_VersionName = "1.0"
		self._Package_VersionCode = 1
	end
end

function ANYSDK:onAppExiting()
	anysdkAgent:unloadAllPlugins()
end

------------------------
-- 其他jni函数
------------------------
function ANYSDK:restartApp()
	local ok, ret = tryCallStaticJavaMethod("com/apowo/projects/Projects", "RestartAPP", {}, "()V")
	if not ok then
		print("ERROR 初始化失败: JNI调用RestartAPP失败")
	end
end

function ANYSDK:Package_VersionName()
	return self._Package_VersionName
end

function ANYSDK:Package_VersionCode()
	return self._Package_VersionCode
end

function ANYSDK:ChannelName(val)
	if val~=nil then
		self._channelName = val
	else
		return self._channelName
	end
end

function ANYSDK:CanShowQQGroup()
	if self._channelName == "uc" or self._channelName=="dl" then
		return false
	else
		return true
	end
end

return ANYSDK