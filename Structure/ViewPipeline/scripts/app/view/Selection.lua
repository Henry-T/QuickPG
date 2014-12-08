--
-- The second and rest part of sharing data between views is Selection
-- Author: tanghongyang@apowo.com
-- Date: 2014-09-18 16:12:17
--

-- Selection is a singleton
-- Selection is not just saved here, but also in ViewStack.
-- When user is doing a "back" action, the ViewStack pops and set the current selection.

local Selection = class("Selection")


