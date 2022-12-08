local LIB_CLASS = require'rove.libs.classic'
local LIB_LOG = require'rove.libs.log'

local utls = {}

---@param _t table table to loop through
---@param fn function the executed function through one loop takes tho args (key, value, ...)
---@return nil any returns what the fn return
function utls.loopInTable(_t , fn --[[:function]], ...)
	for key, item in pairs(_t) do
		fn(key, item, ...)
	end
end

---@param _logType string the log type: debug, error, trace, info, warn, fatal.
---@param ... any print what is given to the console to a format name [type] - value
function utls.log(_logType, ...)
    LIB_LOG[_logType](...);
end

---Create a new class type table
---@param _className string the name of the new generated class
---@return table Class The class with the given name
function utls.Class(_className) return LIB_CLASS:extend(_className) end

utls.MODULE_TYPE = require'rove.modules.module_t'
---Create new module
---@param _moduleName string the name of the new module
---@return Module Module
function utls.Module(_moduleName) return utls.MODULE_TYPE(_moduleName) end

return utls
