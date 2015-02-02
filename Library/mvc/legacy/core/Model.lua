--
-- Author: tanghongyang@apowo.com
-- Date: 2015-02-02 16:52:09
--

local Model = class("Model")

function Model:ctor()
	if Model.instance then
		print("error Model Singleton already constructed!")
	end
end

return Model