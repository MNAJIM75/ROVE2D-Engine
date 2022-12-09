-- since the rove table was not fully initialized at this point so we going to call class independentlly
local LIB_CLASS = require'rove.libs.classic'

---@class Module The base of all rove2d modules
---@field _internal table all non user api functions and types
local module = LIB_CLASS:extend('MODULE_TYPE')
module._internal = {}

---Create new Modlue
---@param _moduleName string THe new module name
function module:new(_moduleName)
    self._internal.name = _moduleName
end

---Initilize function of the module
module._internal.init = function(self) end

---Update function of the module
module._internal.update = function(self) end

---Deinitialize function of the module
module._internal.deinit = function(self) end


return module