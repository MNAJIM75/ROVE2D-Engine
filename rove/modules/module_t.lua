-- since the rove table was not fully initialized at this point so we going to call class independentlly
local LIB_CLASS = require'rove.libs.classic'

---@class Module The base of all rove2d modules
---@field _internal table all non user api functions and types
local module = LIB_CLASS:extend('MODULE_TYPE')

---Create new Modlue
---@param _moduleName string THe new module name
function module:new(_moduleName)
    self._internal = {}
    self._internal.name = _moduleName
    self._internal.init = function(self) end
    
    ---Update function of the module
    self._internal.update = function(self) end
    
    ---Deinitialize function of the module
    self._internal.deinit = function(self) end
end

---Initilize function of the module


return module