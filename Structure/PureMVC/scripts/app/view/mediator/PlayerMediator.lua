--
-- Author: tanghongyang@apowo.com
-- Date: 2015-02-02 10:38:39
--

local PlayerMediator = class("PlayerMediator")

function PlayerMediator:ctor(playerView)
	PlayerMediator.super.ctor(playerView)
end

function PlayerMediator:PlayerView()
	return self._viewComponent
end

function PlayerMediator:OnRegistor()
	-- View的Event会发送给Mediator
	self:PlayerView():addEventListener(MyAppEvnt.SAVE_PLAYER_CONFIG, savePlayerConfig)

	self:PlayerView():addEventListener(MyAppEvnt.TEST_PLAYER_CONFIG, testPlayerConfig)

	self._playerConfigProxy = Facade.RetrieveProxy("EmailConfigProxy")
end

function PlayerMediator:savePlayerConfig(event)
	self._playerConfigProxy.PlayerConfigVO(event.Data)
end

function PlayerMediator:testPlayerConfig(event)
	sendNotification(MyAppConstants.PERFORM_PLAYER_TEST, self:PlayerView():VO())
end

function PlayerMediator:ListNotificationInterests()
	return {
		MyAppConstants.SHOW_CONFIG,
		PlayerProxy.TEST_RESULT,
	}
end

function PlayerMediator:HandleNotification(note)
	if node:Name() == MyAppConstants.SHOW_CONFIG then
		self:PlayerView():VO(self._playerConfigProxy:PlayerConfigVO())
	else node:Name() == MyAppConstants.TEST_RESULT then
		self:PlayerView():TestResult(note:GetBody())
	end
end

return PlayerMediator