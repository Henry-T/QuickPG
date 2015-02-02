--
-- Lua 标准库扩展
-- Author: tanghongyang@apowo.com
-- Date: 2014-09-22 09:57:27
--

-- todo thy 改为c库

--- 返回table中是否有data项
function table.contains(t, data)
	for _, d in ipairs(t) do
		if data == d then
			return true
		end
	end
	return false
end

--- 返回table中是否有符合检查条件的项
function table.exists(t, checkFunc)
	for _, data in ipairs(t) do
		if checkFunc(data) then
			return true
		end
	end
	return false
end

--- 返回table是否空表
function table.isEmpty(t)
	if next(t) == nil then
		return true
	else
		return false
	end
end

--- 删除相等的元素
function table.delete(t, d)
	for i=#t, 1, -1 do
		if t[i] == d then
			table.remove(t, i)
		end
	end
end

--- 合并两个table，返回一个新的table
function table.combine(t1, t2)
	local result = {}
	for _, d in pairs(t1) do
		result[#result+1] = d
	end
	for _, d in pairs(t2) do
		result[#result+1] = d
	end
	return result
end

--- 顺序查找
function table.find(t, key, value)
	for _, d in ipairs(t) do
		if d[key] == value then
			return d
		end
	end
	return nil
end

--- 查找所有符合条件的项
function table.findAll(t, key, value)
	local result = {}
	for _, d in ipairs(t) do
		if d[key] == value then
			result[#result+1] = d
		end
	end
	return result
end

--- 返回键值对相符的项数
function table.countMatchKV(t, key, value)
	local count = 0
	for _, d in ipairs(t) do
		if d[key] == value then
			count = count + 1
		end
	end
	return count
end

--- 获取表中第index项起取到第count子项的浅拷贝
function table.getRange(t, index, count)
	local result = {}
	for i=index, index+count do
		if i<=#t then
			result[#result+1] = t[i]
		else
			break
		end
	end
	return result
end

--- 多维度二分法查找
-- 例如 t:binaryFind({fkey1=50, fkey2=3})
-- @t 按键值对优先级升序排列
-- @kvpairs 搜索目标属性键值对 高优先级的属性要排在前面
-- @return 找到返回目标，找不到返回nil
function table.binaryFind(t, kvpairs)
	local leftIndex = 1
	local rightIndex = #t
	local midIndex = -1

	while leftIndex <= rightIndex do
		midIndex= math.floor((leftIndex + rightIndex)/2)
		local midItem = t[midIndex]

		local comp = 0
		for name, value in pairs(kvpairs) do
			if value == midItem[name] then
				-- 继续比较下一个键值对
			elseif value < midItem[name] then
				comp = -1
				break
			elseif value > midItem[name] then
				comp = 1
				break
			end
		end

		if comp == 0 then
			return t[midIndex]
		elseif comp == -1 then
			rightIndex = midIndex - 1
		elseif comp == 1 then
			leftIndex = midIndex + 1
		end
	end
	return nil
end

--- 获取表中Key对应的值，如果为nil返回一个空表
function table.getOrNewTableByKey(t, key)
	local result = t[key]
	if not result then
		t[key] = {}
		result = t[key]
	end
	return result
end

--- 克隆一个Table
function table.clone(source)
	if source == nil then
		return source
	end
	local result = {}
	for k, v in pairs(source) do
		result[k] = v
	end
	return result
end

--- 把table里的项拼接成字符串
function table.connect(t, seperator)
	local str = ""
	seperator = seperator or "/"
	for i, item in ipairs(t) do
		if type(item) == "string" then
			if str == "" then
				str = item
			else
				str = str .. seperator .. item
			end
		end
	end
	return str
end

----------------------------------
-- 本地热更新 
----------------------------------
-- 本地热更新启用时
--   每次require都必然多出一个类表,它是一个新实例被成员函数当做upvalue引用(所有super调用)
--   如果添加了一个函数到类里面，之前创建的旧实例会自动获得到这个函数
--   不支持任何成员函数对upvalue的数值操作 比如: "MyClass._varName" 这种

if device.platform == "windows" then
	orgRequire = require

	local function isCLib(path)
		if string.find(path, "Config") then
			return true
		end
		if string.find(path, "skillResult") then
			return true
		end
		if path == "bit" or 
			path == "string" or 
			path == "math" or 
			path == "protobuf.c" then 
			return true
		end
		return false
	end

	function require(path)
		if not isCLib(path) then
			local oldVal = package.loaded[path]
			package.loaded[path] = nil

			local newVal = orgRequire(path)
			if type(oldVal)=="table" and type(newVal)=="table" then
				for k, v in pairs(newVal) do
					oldVal[k] = v
				end
				package.loaded[path] = oldVal
			else
				package.loaded[path] = newVal
			end
			return package.loaded[path]
		else
			return orgRequire(path)
		end
	end
end