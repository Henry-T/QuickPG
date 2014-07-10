--
-- Author: tanghongyang@apowo.com
-- Date: 2014-07-08 15:09:10
--

local DataMail = class("DataMail")

function DataMail:ctor()
    self.uid         = 0
    self.title      = "mail_title"
    self.sender     = "mail_from"
    self.time       = "mail_time"
    self.type       = "mail_type"
    self.content    = "mail_content"
    self.hasRead    = false
    self.type       = 0
end

return DataMail