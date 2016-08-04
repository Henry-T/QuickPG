--
-- Author: hanxu
-- Date: 2015-06-17 09:23:00
--

userPay = {}

local function onPayResult( code, msg, info )
    print("on iap result listener.")
    print("code:"..code..",msg:"..msg)
    if code == PayResultCode.kPaySuccess then
        print("================PayResultCode.kPaySuccess===============")
        if anySDK:ChannelName() ~= "uc" then
            -- uc支付渠道下单后取消支付，仍然被归类为支付成功 渠道建议修正或不提示
            userPay.showMsg("支付成功")
        end
    elseif code == PayResultCode.kPayFail then
        print("================PayResultCode.kPayFail===============")
        userPay.showMsg("支付失败")
    elseif code == PayResultCode.kPayCancel then
        print("================PayResultCode.kPayCancel===============")
        userPay.showMsg("支付取消")
    elseif code == PayResultCode.kPayNetworkError then
        print("================PayResultCode.kPayNetworkError===============")
        userPay.showMsg("支付时出现网络错误")
    elseif code == PayResultCode.kPayProductionInforIncomplete then
        print("================PayResultCode.kPayProductionInforIncomplete===============")
        userPay.showMsg("商品信息不完整")
    elseif code == PayResultCode.kPayInitSuccess then
        print("================PayResultCode.kPayInitSuccess===============")
    elseif code == PayResultCode.kPayInitFail then
        print("================PayResultCode.kPayInitFail===============")
    elseif code == PayResultCode.kPayNowPaying then
    	print("================PayResultCode.kPayNowPaying===============")
        if type(iap_plugin_maps.resetPayState) == "function" then
             iap_plugin_maps:resetPayState()
        end
    elseif code == PayResultCode.kPayRechargeSuccess then
        print("================PayResultCode.kPayRechargeSuccess===============")
    end
end

function userPay.showMsg(msg)
    if newUIManager~=nil and type(newUIManager.showMsgPanel)=="function" then
        newUIManager:showMsgPanel(msg)
    end
end

function userPay.init()
	if anysdkAgent and iap_plugin_maps==nil then
		iap_plugin_maps = anysdkAgent:getIAPPlugin()

		for key, value in pairs(iap_plugin_maps) do
		    value:setResultListener(onPayResult)
		end
	end
end

function userPay.pay(params)
	if iap_plugin_maps ~= nil then
		local jsonStr = string.format("{\"cid\":\"%s\", \"sid\":\"%s\", \"pid\":\"%s\"}",
						userManager:getMe():id(), userManager:serverID(), params.productID)

        local info = {
                Product_Price	= params.price,
                Product_Id		= params.productID,--"monthly",  
                Product_Name	= params.propName, --"gold",  
                Server_Id		= userManager:serverID(), --"13",  
                Product_Count	= "1",  
                Role_Id			= userManager:getMe():id(),--"1001",  
                Role_Name		= userManager:getMe():name(),
                EXT 			= jsonStr
            }
        -- analytics_plugin:logEvent("pay", info)
        dump(info)
        for key, value in pairs(iap_plugin_maps) do
            value:payForProduct(info)
        end
	end
end

return userPay