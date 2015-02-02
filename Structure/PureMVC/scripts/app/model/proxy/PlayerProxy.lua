--
-- Author: tanghongyang@apowo.com
-- Date: 2015-02-02 10:23:48
--

local PlayerProxy = class("PlayerProxy")

function PlayerProxy:ctor()
end

function PlayerProxy:PlayerConfigVO(vo)
	if vo then
		self.__vo = vo
	else
		return self.__vo
	end
end

function PlayerProxy:Name(name)
	if name then
		self._name = name
	else
		return self._name
	end
end



return PlayerProxy